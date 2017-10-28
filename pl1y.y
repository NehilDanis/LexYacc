%{
#include <stdio.h>
extern char *yytext;
extern int line_count;

int yylex(void);
void yyerror(const char *);
%}

%token FUNC
%token LEFT_BRACKET RIGHT_BRACKET LEFT_PARENTHESIS RIGHT_PARENTHESIS
%token VOID INT FLOAT
%token IDNTFR
%token COMMA SEMI_COLON
%start program

%%

program	: function
	| program function
	;

function	: FUNC return_type IDNTFR LEFT_PARENTHESIS 
	   	parameter_list RIGHT_PARENTHESIS block
		;

block	: LEFT_BRACKET empty RIGHT_BRACKET
	;

statement_list	: empty
		;

empty	: /*empty*/
	;

return_type	: VOID 
		| FLOAT
		| INT
		;
types	: FLOAT
	| INT
	;

parameter_list	: VOID
		| another_parameters
		;

another_parameters	: types IDNTFR
			| another_parameters COMMA types IDNTFR


%%
#include "lex.yy.c" 
int main(){
	if( yyparse() )
		printf("\n Error is found during parsing process.\n\n");
         else
               printf("Parsing completed.SUCCESSFULLY!\n\n");
	
	
	return 0;
}
