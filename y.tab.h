/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT = 258,
    FLOAT = 259,
    MOD = 260,
    POW = 261,
    OPA = 262,
    OPM = 263,
    EQ = 264,
    PAR_OPEN = 265,
    PAR_CLOSE = 266,
    CB_OPEN = 267,
    CB_CLOSE = 268,
    STOP = 269,
    SCAN = 270,
    PRINT = 271,
    REP = 272,
    CHAR = 273,
    IF = 274,
    ELSE = 275,
    ELIF = 276,
    DTP = 277,
    RELOP = 278,
    VAR = 279,
    STR = 280
  };
#endif
/* Tokens.  */
#define INT 258
#define FLOAT 259
#define MOD 260
#define POW 261
#define OPA 262
#define OPM 263
#define EQ 264
#define PAR_OPEN 265
#define PAR_CLOSE 266
#define CB_OPEN 267
#define CB_CLOSE 268
#define STOP 269
#define SCAN 270
#define PRINT 271
#define REP 272
#define CHAR 273
#define IF 274
#define ELSE 275
#define ELIF 276
#define DTP 277
#define RELOP 278
#define VAR 279
#define STR 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 21 "SA.y" /* yacc.c:1909  */

  double val;
  char sym;
  std::string *str_val;

#line 110 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
