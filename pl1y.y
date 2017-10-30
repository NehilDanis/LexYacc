%{
#include <stdio.h>
#include <dirent.h>
extern char *yytext;
extern int line_count;

int yylex(void);
void yyerror(const char *);
%}

%token TEXT_FILE PHOTO_FILE MUSIC_FILE
%token DIRECTORY
%token FUNC
%token LEFT_BRACKET RIGHT_BRACKET LEFT_PARENTHESIS RIGHT_PARENTHESIS
%token VOID INT FLOAT
%token IDNTFR
%token COMMA SEMI_COLON QUOTO
%token BLTN_COPYFILE
%token RETURN
%start program

%%

program	: function
	| program function
	;

function	: FUNC return_type IDNTFR LEFT_PARENTHESIS 
	   	parameter_list RIGHT_PARENTHESIS block
		;

block	: LEFT_BRACKET empty RIGHT_BRACKET
	| LEFT_BRACKET statement_list RIGHT_BRACKET
	;

statement_list	: statement
		| statement_list statement
		;

statement	: built_in_func SEMI_COLON
		| RETURN factor SEMI_COLON
		;

factor	: empty
	| IDNTFR
	;
built_in_func	: copyFile
		;

copyFile	: BLTN_COPYFILE LEFT_PARENTHESIS QUOTO file QUOTO  RIGHT_PARENTHESIS
		;

file	: TEXT_FILE
	| PHOTO_FILE
	| MUSIC_FILE
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
			;


%%

void yyerror(const char *s){
	fprintf(stderr,"<%s>,INVALID RULE IN AVENGER LANGUAGE line : %d\n",s,line_count);
}
int main(){

	if( yyparse() )
		printf("\n Error is found during parsing process.\n\n");
         else
               printf("Parsing completed.SUCCESSFULLY!\n\n");
	
	
	return 0;
}
