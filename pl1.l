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
"_copyFile_"	{return (BLTN_COPYFILE);}

"void"	{return (VOID);}
"int"	{return (INT);}
"float"	{return (FLOAT);}
return		{return (RETURN);}

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
