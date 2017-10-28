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
%}
 	
%%
"{"	{return(atoi("LEFT_BRACKET"));}
"}"	{return(atoi("RIGHT_BRACKET"));}
"("	{return(atoi("LEFT_PARENTHESIS"));}
")"	{return(atoi("RIGHT_PARENTHESIS"));}


"void"	{return(atoi("VOID"));}

"func"	{return(atoi("FUNC"));}
{UPPER_CASE_LETTER}?{LOWER_CASE_LETTER}+  {return(atoi("IDNTFR"));}


(\r|\n|\r\n)	;
[ \t\v\f]+	;
.		printf("Error!");

%%

int yywrap(){
	return 1;
}
