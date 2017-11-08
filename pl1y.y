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
%token LEFT_BRACKET RIGHT_BRACKET LEFT_PARENTHESIS RIGHT_PARENTHESIS LEFT_SQ_BRACKET RIGHT_SQ_BRACKET
%token VOID INT FLOAT BOOL FILE_TYPE DIR_TYPE LINKED_LIST STRING
%token TRUE FALSE NUM_INT NUM_FLOAT
%token IDNTFR
%token COMMA SEMI_COLON QUOTO COLON
%token BLTN_COPYFILE BLTN_PLAYMUSIC BLTN_VIEWPHOTO BLTN_EDITFILE BLTN_OPENFILE BLTN_CLOSEFILE
%token BLTN_OPENDIR BLTN_GETPATH BLTN_LISTDIRCONTENT BLTN_MOVE BLTN_DELETE BLTN_CONNECTTOSERVER
%token BLTN_CREATE BLTN_COMPAREFILES BLTN_CHANGEDIRECTORY BLTN_ISDIR BLTN_UPLOADTOCLOUD
%token BLTN_CONTROLUPTODATE BLTN_CLOSESERVERCONN BLTN_READFILE BLTN_PRINT BLTN_LENGTH
%token RETURN BREAK CONTINUE DEFAULT
%token IF ELSE ELSE_IF SWITCH CASE
%token ASSIGNMENT_OPT ADD_ASSIGNMENT_OPT SUB_ASSIGNMENT_OPT MULTIPLY_ASSIGNMENT_OPT DIVIDE_ASSIGNMENT_OPT
%token ADD_OPT SUB_OPT MULTIPLY_OPT DIVIDE_OPT
%token INCREMENT_OPT DECREMENT_OPT
%token LESS_OPT GREAT_OPT LESSEQ_OPT GREATEEQ_OPT EQ_OPT NEQ_OPT NOT_OPT
%token AND OR
%token WHILE FOR IN RANGE
%start program

%%

program	: function
	| program function
	;

function	: FUNC IDNTFR LEFT_PARENTHESIS parameter_list RIGHT_PARENTHESIS block
		;


block	: LEFT_BRACKET empty RIGHT_BRACKET
       	| LEFT_BRACKET statement_list ret_stmt RIGHT_BRACKET
        ;

block_loop	: LEFT_BRACKET statement_list out_of_scope_stmt RIGHT_BRACKET
       		;

ret_stmt	: RETURN factor SEMI_COLON
		| empty
		;

out_of_scope_stmt	: BREAK SEMI_COLON
			| CONTINUE SEMI_COLON
			| empty
			;

relation_operator	: LESS_OPT
			| GREAT_OPT
			| LESSEQ_OPT
			| GREATEEQ_OPT
			| EQ_OPT
			| NEQ_OPT
			;

comparison	: IDNTFR relation_operator compared
		| boolean_expr boolean_operator compared
		| func_call relation_operator compared
		| built_in_func relation_operator compared
		;

boolean_operator	: AND
			| OR
			;


compared	: IDNTFR
		| ltrl_type
		| TRUE
		| FALSE
		;


statement_list	: statement
		| statement_list statement
		;

statement	: built_in_func SEMI_COLON
		| func_call SEMI_COLON
		| decision_statement
		| assignment SEMI_COLON
		| declaration SEMI_COLON
		| loop
		;

initialize	: declaration
		| assignment
		;

loop	: while_loop
	| for_loop
	;


while_loop	: WHILE LEFT_PARENTHESIS comparison RIGHT_PARENTHESIS block_loop
		;

for_loop	: FOR LEFT_PARENTHESIS initialize SEMI_COLON comparison SEMI_COLON assignment RIGHT_PARENTHESIS block_loop
		| FOR IDNTFR IN RANGE LEFT_PARENTHESIS NUM_INT COMMA NUM_INT RIGHT_PARENTHESIS block_loop
		| FOR IDNTFR IN IDNTFR block_loop
		;

assignment_operator	: ASSIGNMENT_OPT
			| ADD_ASSIGNMENT_OPT
			| SUB_ASSIGNMENT_OPT
			| MULTIPLY_ASSIGNMENT_OPT
			| DIVIDE_ASSIGNMENT_OPT
			;


assignment	: left_hand_side assignment_operator right_hand_side
		| left_hand_side INCREMENT_OPT
		| left_hand_side DECREMENT_OPT
		;

left_hand_side	: IDNTFR
		| IDNTFR LEFT_SQ_BRACKET NUM_INT RIGHT_SQ_BRACKET
		| IDNTFR LEFT_SQ_BRACKET IDNTFR RIGHT_SQ_BRACKET
		;

declaration	: data_type IDNTFR
		| declaration assignment_operator right_hand_side


right_hand_side : arithmetic_expression
		| func_call
		| built_in_func
		| QUOTO IDNTFR QUOTO
		| QUOTO file QUOTO
		| QUOTO DIRECTORY QUOTO
		;

arithmetic_expression	: term
			| arithmetic_expression ADD_OPT term
			| arithmetic_expression SUB_OPT term
			;
term 	: ltrl_type 
	| term MULTIPLY_OPT ltrl_type
	| term DIVIDE_OPT ltrl_type
	;

func_call	: IDNTFR LEFT_PARENTHESIS send_parameter_list RIGHT_PARENTHESIS
		;


decision_statement	: if_else_elseif_stmt
			;

if_else_elseif_stmt	: if_stmt
			| if_stmt else_stmt
			| if_stmt else_if 
			| if_stmt else_if else_stmt
			;
			
else_if	: elseif_stmt
	| else_if elseif_stmt
	;

if_stmt	: IF LEFT_PARENTHESIS boolean_expr RIGHT_PARENTHESIS block
	| IF LEFT_PARENTHESIS func_call RIGHT_PARENTHESIS block
	| IF LEFT_PARENTHESIS comparison RIGHT_PARENTHESIS block
	| IF LEFT_PARENTHESIS built_in_func RIGHT_PARENTHESIS block
	;

elseif_stmt	: ELSE_IF LEFT_PARENTHESIS boolean_expr RIGHT_PARENTHESIS block
	        | ELSE_IF LEFT_PARENTHESIS func_call RIGHT_PARENTHESIS block
	        | ELSE_IF LEFT_PARENTHESIS comparison RIGHT_PARENTHESIS block
		| ELSE_IF LEFT_PARENTHESIS built_in_func RIGHT_PARENTHESIS block
        	;

else_stmt	: ELSE block
		;
 

built_in_func	: copyFile
		| playMusic
		| viewPhoto
		| editFile
		| readFile
		| openFile
		| closeFile
		| openDir
		| getPath
		| listDirContent
		| move
		| delete
		| create
		| connectToServer
		| compareFiles
		| changeDirectory
		| isDir
		| uploadToCloud
		| controlUpToDate
		| closeServerConn
		| print
		| length
		;

length	: BLTN_LENGTH LEFT_PARENTHESIS IDNTFR RIGHT_PARENTHESIS
	;

copyFile	: BLTN_COPYFILE LEFT_PARENTHESIS QUOTO file QUOTO  RIGHT_PARENTHESIS
		;


playMusic	: BLTN_PLAYMUSIC LEFT_PARENTHESIS QUOTO MUSIC_FILE QUOTO RIGHT_PARENTHESIS
		;

viewPhoto	: BLTN_VIEWPHOTO LEFT_PARENTHESIS QUOTO PHOTO_FILE QUOTO RIGHT_PARENTHESIS
		;

openFile	: BLTN_OPENFILE LEFT_PARENTHESIS QUOTO file QUOTO RIGHT_PARENTHESIS
		;

closeFile	: BLTN_CLOSEFILE LEFT_PARENTHESIS IDNTFR RIGHT_PARENTHESIS
		;

closeServerConn	: BLTN_CLOSESERVERCONN LEFT_PARENTHESIS empty RIGHT_PARENTHESIS
		;

connectToServer	: BLTN_CONNECTTOSERVER LEFT_PARENTHESIS empty RIGHT_PARENTHESIS
		;

controlUpToDate	: BLTN_CONTROLUPTODATE LEFT_PARENTHESIS QUOTO file QUOTO RIGHT_PARENTHESIS
		| BLTN_CONTROLUPTODATE LEFT_PARENTHESIS IDNTFR RIGHT_PARENTHESIS	
		;

editFile	:  BLTN_EDITFILE LEFT_PARENTHESIS QUOTO file QUOTO RIGHT_PARENTHESIS
		|  BLTN_EDITFILE LEFT_PARENTHESIS IDNTFR RIGHT_PARENTHESIS
		;

readFile	:  BLTN_READFILE LEFT_PARENTHESIS TEXT_FILE RIGHT_PARENTHESIS
		;

uploadToCloud	: BLTN_UPLOADTOCLOUD LEFT_PARENTHESIS QUOTO file QUOTO RIGHT_PARENTHESIS
		| BLTN_UPLOADTOCLOUD LEFT_PARENTHESIS QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
		| BLTN_UPLOADTOCLOUD LEFT_PARENTHESIS IDNTFR RIGHT_PARENTHESIS
		;

openDir		: BLTN_OPENDIR LEFT_PARENTHESIS QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
		;

getPath		: BLTN_GETPATH LEFT_PARENTHESIS empty RIGHT_PARENTHESIS
		| BLTN_GETPATH LEFT_PARENTHESIS IDNTFR RIGHT_PARENTHESIS
		;

listDirContent	: BLTN_LISTDIRCONTENT LEFT_PARENTHESIS empty RIGHT_PARENTHESIS
		| BLTN_LISTDIRCONTENT LEFT_PARENTHESIS IDNTFR RIGHT_PARENTHESIS
		| BLTN_LISTDIRCONTENT LEFT_PARENTHESIS QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
		;



move	: BLTN_MOVE LEFT_PARENTHESIS QUOTO file QUOTO COMMA QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
	| BLTN_MOVE LEFT_PARENTHESIS IDNTFR COMMA QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
	| BLTN_MOVE LEFT_PARENTHESIS IDNTFR LEFT_SQ_BRACKET IDNTFR RIGHT_SQ_BRACKET COMMA QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
	| BLTN_MOVE LEFT_PARENTHESIS IDNTFR LEFT_SQ_BRACKET NUM_INT RIGHT_SQ_BRACKET COMMA QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
	;

delete	: BLTN_DELETE LEFT_PARENTHESIS QUOTO file QUOTO COMMA QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
	| BLTN_DELETE LEFT_PARENTHESIS QUOTO file QUOTO RIGHT_PARENTHESIS
	;

create	: BLTN_CREATE LEFT_PARENTHESIS QUOTO file QUOTO COMMA QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
        | BLTN_CREATE LEFT_PARENTHESIS QUOTO file QUOTO RIGHT_PARENTHESIS
        ;

compareFiles	: BLTN_COMPAREFILES LEFT_PARENTHESIS QUOTO file QUOTO COMMA QUOTO file QUOTO RIGHT_PARENTHESIS
		;

changeDirectory	: BLTN_CHANGEDIRECTORY LEFT_PARENTHESIS QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
		| BLTN_CHANGEDIRECTORY LEFT_PARENTHESIS IDNTFR RIGHT_PARENTHESIS
		;

print	: BLTN_PRINT LEFT_PARENTHESIS empty RIGHT_PARENTHESIS
	| BLTN_PRINT LEFT_PARENTHESIS IDNTFR RIGHT_PARENTHESIS
	| BLTN_PRINT LEFT_PARENTHESIS QUOTO IDNTFR QUOTO RIGHT_PARENTHESIS
	;

isDir	: BLTN_ISDIR LEFT_PARENTHESIS QUOTO DIRECTORY QUOTO RIGHT_PARENTHESIS
	| BLTN_ISDIR LEFT_PARENTHESIS IDNTFR RIGHT_PARENTHESIS
	| BLTN_ISDIR LEFT_PARENTHESIS IDNTFR LEFT_SQ_BRACKET IDNTFR RIGHT_SQ_BRACKET RIGHT_PARENTHESIS
	| BLTN_ISDIR LEFT_PARENTHESIS IDNTFR LEFT_SQ_BRACKET NUM_INT RIGHT_SQ_BRACKET RIGHT_PARENTHESIS
	;


file	: TEXT_FILE
	| PHOTO_FILE
	| MUSIC_FILE
	;

empty	: /*empty*/
	;

factor		: boolean_expr
		| ltrl_type
		| factor COMMA boolean_expr
		| factor COMMA ltrl_type
		| empty
		;

boolean_expr	: IDNTFR
		| boolean_vals
		| NOT_OPT IDNTFR
		;


boolean_vals	: TRUE
		| FALSE
		;

ltrl_type	: NUM_INT
		| NUM_FLOAT
		;

data_type	: INT
		| FLOAT
		| BOOL
		| LINKED_LIST
		| FILE_TYPE
		| DIR_TYPE
		;

parameter_list	: VOID
		| another_parameters
		;

another_parameters	: data_type IDNTFR
			| another_parameters COMMA data_type IDNTFR
			;

send_parameter_list	: boolean_expr
			| func_call
			| built_in_func
			| send_parameter_list COMMA boolean_expr
			| send_parameter_list COMMA func_call
			| send_parameter_list COMMA built_in_func
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
