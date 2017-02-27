letter [a-zA-Z]
digit [0-9]
any [a-zA-z0-9~`!@#$%\\\^&*()\-{}[\] =|/?.>,<''"":;]
%%

[ \t\n]+											{}

"%"													printf("MOD: %s\n", yytext);
"^"												printf("EXP: %s\n", yytext);
"\+"|"\-"|"\*"|"/"										printf("OPA: %s\n", yytext);
"="													printf("EQ: %s\n", yytext);
">="|"<="|">"|"<"|"=="|"!="									printf("ROP: %s\n", yytext);

{digit}{digit}*|{digit}{digit}*(\.{digit}+)			printf("NUM: %s", yytext);

"{"|"}"|"("|")"|"["|"]"						printf("PAR: %s", yytext);
";"													printf("STP: %s\n", yytext);
"scan"|"print"|"repeat"|"if"|"else"|"else if"		printf("KEY: %s\n", yytext);
"int"|"char"|"float"|"string"						printf("DTP: %s\n", yytext);

"\'"{any}"\'"										printf("CHAR: %s\n", yytext);
"\""({any})*"\""									printf("STR: %s\n", yytext);
"/*"({any})*"*/"									printf("CMT: %s\n", yytext);

{letter}({letter}|{digit}|_)*						printf("VAR: %s\n", yytext);
.													printf("Err: Undefined token - %s\n", yytext);

%%

main(){
	yylex();
}

