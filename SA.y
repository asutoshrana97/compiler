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

map<string,double> variable_map;

int yylex(); 
void varError(string s) { cout << "Variable not found error" << endl ; }
int yyerror(const char *p) { cerr << "Error!" << endl; }

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
%type   <val> exp exp_ term sfactor factor stmts stmt ssfactor 

%%

start: stmts start | stmts

stmts: stmts STOP|stmt STOP
 
stmt: 	PRINT PAR_OPEN exp PAR_CLOSE { cout << $3 <<endl; } |
	VAR EQ exp  { variable_map[*$1] = $3;   } |
	VAR EQ SCAN PAR_OPEN PAR_CLOSE  { double temp; cin >> temp; variable_map[*$1]=temp; } |
	PRINT PAR_OPEN string PAR_CLOSE   { cout << *$3 <<endl; }
     
string: string OPA STR { if($2=='+')
			{
				string s1=*$1,s2=*$3;	
				*$$ = s1+s2;
			}			
			else yyerror("Undefined Operation!");} |
	STR { $$ = $1;}

exp : 
  /*IF PAR_OPEN exp_ PAR_CLOSE exp_ ELSE exp_ { if( $3 ) $$ = $5; else $$ = $7; } 
  |*/ exp_

exp_ : 
   exp_ RELOP term {     if(*$2 == "==") $$ =( $1 == $3); 
		    else if(*$2 == ">=") $$ = ($1 >= $3) ;
		    else if(*$2 == "<=") $$ = ($1 <= $3) ;
		    else if(*$2 == ">" ) $$ = ($1 > $3) ;
		    else if(*$2 == "<" ) $$ = ($1 < $3) ;
		    else  $$ = ($1 != $3 ) ; 
		} 
| exp_ OPA term     { $$ = ($2 == '+' ? $1 + $3 : $1 - $3); }
| term                { $$ = $1; }






term: term OPM factor { if( $2 != '*' and $3 == 0 ) yyerror("Divide by zero") ; $$ = ($2 == '*' ? $1 * $3 : $1 / $3); }
| sfactor             { $$ = $1; }


sfactor : sfactor POW ssfactor { $$ = pow($1,$3); } | ssfactor { $$=$1; }

ssfactor: OPA factor   { $$ = ($1 == '+' ? $2 : -$2); }
| factor              { $$ = $1; }

factor: VAR { if(!variable_map.count(*$1)) varError(*$1); else $$= variable_map[*$1]; }
        |INT		           { $$ = $1; }
	|FLOAT			   { $$ = $1; }
	|PAR_OPEN exp PAR_CLOSE           { $$ = $2; }

%%


int main()
{
  yyparse();
  return 0;
}
