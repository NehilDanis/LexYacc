UPPER_CASE_LETTER	[A-Z]
LOWER_CASE_LETTER	[a-z] 
CHARACTER	{UPPER_CASE_LETTER}|{LOWER_CASE_LETTER}

DIGIT [0-9]
SIGN	[\-+]
INTEGER	{SIGN}?{DIGIT}+
FLOAT	{SIGN}?{DIGIT}*"."{DIGIT}+
NUMBER	{INTEGER}|{FLOAT}

TEXT_FILE \.(txt)
MUSIC_FILE \.(mp[3-4])
PHOTO_FILE \.((jpg)|(jpeg)|(png))
DIRECTORY	{UPPER_CASE_LETTER}{COLON}(\\{CHARACTER}+)*
%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
int line_count=0;
%}
 	
%%
"{"	{return (LEFT_BRACKET);}
"}"	{return (RIGHT_BRACKET);}
"("	{return (LEFT_PARENTHESIS);}
")"	{return (RIGHT_PARENTHESIS);}
"\""    {return (QUOTO);}
";"	{return (SEMI_COLON);}
","	{return (COMMA);}
":"	{return (COLON);}
"["	{return (LEFT_SQ_BRACKET);}
"]"	{return (RIGHT_SQ_BRACKET);}

"="	{return (ASSIGNMENT_OPT);}
"+="	{return (ADD_ASSIGNMENT_OPT);}
"-="	{return (SUB_ASSIGNMENT_OPT);}
"/="	{return (DIVIDE_ASSIGNMENT_OPT);}
"*="	{return (MULTIPLY_ASSIGNMENT_OPT);}

"+"    {return (ADD_OPT);}
"-"    {return (SUB_OPT);}
"/"    {return (DIVIDE_OPT);}
"*"    {return (MULTIPLY_OPT);}
"++"	{return (INCREMENT_OPT);}
"--"	{return (DECREMENT_OPT);}

"<"	{return (LESS_OPT);}
">"	{return (GREAT_OPT);}
"<="	{return (LESSEQ_OPT);}
">="	{return (GREATEEQ_OPT);}
"=="	{return (EQ_OPT);}
"!="	{return (NEQ_OPT);}

"&&"	{return (AND);}
"||"	{return (OR);}
"!"	{return (NOT_OPT);}

"w_loop"	{return (WHILE);}
"f_loop"	{return (FOR);}
"in"	{return (IN);}
"range"	{return (RANGE);}

"_copyFile_"	{return (BLTN_COPYFILE);}

"void"	{return (VOID);}
"int"	{return (INT);}
"float"	{return (FLOAT);}
"bool"	{return (BOOL);}
"return"	{return (RETURN);}
"break"	{return (BREAK);}
"continue"	{return (CONTINUE);}
"default"	{return(DEFAULT);}

"if"	{return (IF);}
"else"	{return (ELSE);}
"else if"	{return(ELSE_IF);}
"switch"	{return (SWITCH);}
"case"	{return (CASE);}
"true"	{return (TRUE);}
"false"	{return (FALSE);}

{SIGN}?{DIGIT}+	{return (NUM_INT);}
{SIGN}?{DIGIT}*\.{DIGIT}+	{return (NUM_FLOAT);}

"func"	{return (FUNC);}

{CHARACTER}+(\-)?{CHARACTER}*  {return (IDNTFR);}

{UPPER_CASE_LETTER}\:(\\{CHARACTER}+)*(\\{CHARACTER}+{TEXT_FILE})	{return (TEXT_FILE);}
{UPPER_CASE_LETTER}\:(\\{CHARACTER}+)*(\\{CHARACTER}+{MUSIC_FILE})      {return (MUSIC_FILE);}
{UPPER_CASE_LETTER}\:(\\{CHARACTER}+)*(\\{CHARACTER}+{PHOTO_FILE})      {return (PHOTO_FILE);}
{UPPER_CASE_LETTER}\:(\\{CHARACTER}+)* {return (DIRECTORY);}

(\r|\n|\r\n)	{line_count++;}
[ \t\v\f]	{ }
.		printf("%s",yytext);

%%
int yywrap(){
	return 1;
} 
