%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	extern FILE *yyin;
	extern FILE *yyout;
	extern int lineno;
	extern int yylex();
	void yyerror();
%}


/* token definition */
%token TOKEN_DATUM TOKEN_INPUT TOKEN_OUTPUT TOKEN_OPERATOR TOKEN_SUBGRAPH TOKEN_CONST
%token TOKEN_IF TOKEN_ELSE TOKEN_MERGE TOKEN_EXPANSION TOKEN_EXPAND TOKEN_MAPIN TOKEN_MAPOUT 
%token IOP OOP ADDOP MULOP SUBOP RELOP
%token LPAR RPAR LBRACK RBRACK LBRACE RBRACE SEMI DOT COMMA
%token ID ICONST FCONST CCONST STRING

/* precedencies and associativities */
%left LPAREN RPAREN LBRACK RBRACK
%right NOTOP INCR REFER
%left MULOP DIVOP
%left ADDOP
%left RELOP
%left EQUOP
%left OROP
%left ANDOP
%right ASSIGN
%left COMMA


%start program

/* expression rules */

%%

program: subgraph | subgraph program;

subgraph: TOKEN_SUBGRAPH LPAR ID RPAR instructions;

instructions: instruction | instructions instruction;

instruction: TOKEN_DATUM LPAR ID RPAR SEMI
				| TOKEN_OUTPUT LPAR ID RPAR SEMI
				| TOKEN_INPUT LPAR ID RPAR SEMI
				| TOKEN_CONST LPAR ID COMMA ICONST RPAR SEMI
				| TOKEN_OPERATOR LPAR ID COMMA RELOP COMMA ID COMMA ID RPAR SEMI
				| TOKEN_OPERATOR LPAR ID COMMA TOKEN_IF COMMA ID COMMA ID RPAR SEMI
				| TOKEN_OPERATOR LPAR ID COMMA TOKEN_ELSE COMMA ID COMMA ID RPAR SEMI
				| TOKEN_OPERATOR LPAR ID COMMA MULOP COMMA ID COMMA ID RPAR SEMI
				| TOKEN_OPERATOR LPAR ID COMMA ADDOP COMMA ID COMMA ID RPAR SEMI
				| TOKEN_OPERATOR LPAR ID COMMA SUBOP COMMA ID COMMA ID RPAR SEMI
				| TOKEN_OPERATOR LPAR ID COMMA TOKEN_MERGE COMMA ID COMMA ID RPAR SEMI
				| TOKEN_EXPAND LPAR ID COMMA TOKEN_MAPIN LPAR ID COMMA ID RPAR SEMI TOKEN_MAPOUT LPAR ID COMMA ID RPAR SEMI RPAR SEMI 

%%

void yyerror ()
{
  fprintf(stderr, "Syntax error at line %d\n", lineno);
  exit(1);
}

int main (int argc, char *argv[]){


	// parsing
	int flag;
	yyin = fopen(argv[1], "r");
	flag = yyparse();
	fclose(yyin);
	
	printf("Parsing finished!\n");
	
	return flag;
}