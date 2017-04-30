%{
#include <iostream>
#include <stdio.h>
#include <string>
#include <map>
#include <vector>
#include <cstdlib> 
#include <cmath>
#include <string.h>

using namespace std;
int i=0,e=0,b=0;
map<string,double> variable_map;

int yylex(); 
void varError(string s) { cout << "Variable not found error" << endl ; exit(0);}
int yyerror(const char *p) { cerr << p << " Error!" << endl; exit(0);}

%}


 %union {
  double val;
  char sym;
  std::string *str_val;
};

%token  <val> INT FLOAT
%token  <sym> MOD POW OPA OPM EQ PAR_OPEN PAR_CLOSE CB_OPEN CB_CLOSE STOP SCAN PRINT REP CHAR IF ELSE ELIF DTP
%token  <str_val> RELOP VAR STR
%type   <str_val> string
%type   <val> exp conditions scan_stmt cond


%left OPA OPM RELOP
%right POW

%%

start: 
	stmts start 
	|stmts
	;


stmts: 
	stmts stmt 
	| stmt 
	;

stmt: 
	block_stmt 
	| conditional_stmt 
	| assignment_stmt STOP 
	| print_stmt STOP 
	| scan_stmt STOP 
	;
	 
print_stmt: 	
	PRINT PAR_OPEN exp PAR_CLOSE { if(i==0 && e==0 || b==0 && e==1|| b==1 && i==1){cout << $3 <<endl;}  }
	|PRINT PAR_OPEN conditions PAR_CLOSE { if(i==0 && e==0 || b==0 && e==1|| b==1 && i==1){cout << $3 <<endl;}  }
	|PRINT PAR_OPEN string PAR_CLOSE   { if(i==0 && e==0 || b==0 && e==1|| b==1 && i==1){cout << *$3 <<endl;}  }
	;

scan_stmt:
	VAR EQ SCAN PAR_OPEN PAR_CLOSE  { if(i==0 && e==0 || b==0 && e==1|| b==1 && i==1){double temp; cin >> temp; variable_map[*$1]=temp;} }
	;
	
string: STR { $$ = $1;}
	;

block_stmt:   CB_OPEN stmts CB_CLOSE
	;
conditional_stmt
	:IF PAR_OPEN cond PAR_CLOSE block_stmt elsest{b=0;i=0;}
	;
elsest	
	:ELSE block_stmt{i=0;e=0;b=0;}
	|
	;
cond: conditions {if($1){b=1;}else{b=0;}}
	;
conditions : 
	conditions RELOP exp {if(*$2 == "==") $$ =( $1 == $3); 
		    else if(*$2 == ">=") $$ = ($1 >= $3) ;
		    else if(*$2 == "<=") $$ = ($1 <= $3) ;
		    else if(*$2 == ">" ) $$ = ($1 > $3) ;
		    else if(*$2 == "<" ) $$ = ($1 < $3) ;
		    else  $$ = ($1 != $3 ) ; 
		} 
	|exp	{ $$ = $1; }
	;

assignment_stmt:
	VAR EQ exp  { if(i==0 && e==0 || b==0 && e==1|| b==1 && i==1){variable_map[*$1] = $3;}   } 
	;

exp:
	VAR { if(!variable_map.count(*$1)) varError(*$1); else $$= variable_map[*$1]; }
        |INT		           { $$ = $1; }
	|FLOAT			   { $$ = $1; }
	|exp OPA exp { $$ = ($2 == '+' ? $1 + $3 : $1 - $3); }
	|exp OPM exp { if( $2 != '*' && $3 == 0 ) yyerror("Divide by zero") ; $$ = ($2 == '*' ? $1 * $3 : $1 / $3); }
	|exp POW exp { $$ = pow($1,$3); }
	|PAR_OPEN exp PAR_CLOSE           { $$ = $2; }
	;

%%


int main()
{
  yyparse();
  return 0;
}
