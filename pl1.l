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
%}
 	
%%
"{"	{return (LEFT_BRACKET);}
"}"	{return (RIGHT_BRACKET);}
"("	{return (LEFT_PARENTHESIS);}
")"	{return (RIGHT_PARENTHESIS);}


"void"	{return (VOID);}

"func"	{return (FUNC);}
{UPPER_CASE_LETTER}?{LOWER_CASE_LETTER}+  {return (IDNTFR);}


(\r|\n|\r\n)	;
[ \t\v\f]+	;
.		printf("Error!");

%%
int yywrap(){
	return 1;
}
