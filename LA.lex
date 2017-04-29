%{
#include <iostream>
#include "SA.tab.h"
#include <string>
#include <string.h>
using namespace std;
%}

letter [a-zA-Z]
digit [0-9]
any [a-zA-z0-9~`!@#$%\\^&*()-{}[\]=|/?.>,<'":;]

%option noyywrap

%%

[ \t\n]+					{}

"%"						{return MOD;}
"^"						{return POW;}
"+"|"-"						{yylval.sym = yytext[0]; return OPA;}
"*"|"/"						{yylval.sym = yytext[0]; return OPM;}
"="						{return EQ;}
">="|"<="|">"|"<"|"=="|"!="			{yylval.str_val = new string(yytext); return RELOP;}
	
{digit}+					{yylval.val = (double)atoi(yytext); return INT;}
{digit}+(\.{digit}+)				{yylval.val = (double)atof(yytext); return FLOAT;}
	
"("						{return PAR_OPEN;}
")"						{return PAR_CLOSE;}
"{"						{return CB_OPEN;}
"}"						{return CB_CLOSE;}
";"						{return STOP;}
"scan"						{return SCAN;}
"print"						{return PRINT;}

"repeat"					{return REP;}
"if"						{return IF;}
"else"						{return ELSE;}
"else if"					{return ELIF;}
"int"|"char"|"float"|"string"			{yylval.str_val = new string(yytext); return DTP;}

"'"{any}"'"					{yylval.sym = yytext[1]; return CHAR;}
\".\"						{	std::string str(yytext);
							yylval.str_val = new string(str.substr(1,strlen(yytext)-2)); return STR;}
"/*"."*/"					{}//comments are ignored

{letter}({letter}|{digit}|_)*			{yylval.str_val = new string(yytext); return VAR;}
.					        {cerr << "TOKEN MISMATCH!!" << endl; exit(1); }

%%


