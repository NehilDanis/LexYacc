LEFT_SQ_BRACKET	[
RIGHT_SQ_BRACKET	]
COLON	:
UPPER_CASE_LETTER	[A-Z] 
CHARACTER	[A-Za-z]
TEXT_FILE \.(txt)
MUSIC_FILE \.(mp[3-4])
PHOTO_FILE \.((jpg)|(jpeg)|(png))
DIGIT [0-9]
DIRECTORY	{UPPER_CASE_LETTER}{COLON}(\\{CHARACTER}+)*
 	
%%
{DIRECTORY}	printf("DIRECTORY\n");
{DIRECTORY}(\\{CHARACTER}+{DIGIT}*{TEXT_FILE}) 	printf("TEXT_FILE\n");
{DIRECTORY}(\\{CHARACTER}+{DIGIT}*{MUSIC_FILE})	printf("MUSIC_FILE\n");
{DIRECTORY}(\\{CHARACTER}+{DIGIT}*{PHOTO_FILE})	printf("PHOTO_FILE\n");




"createFile"	printf("BLTIN_CREATE_FILE");
"func"	printf("FUNCTION");

(\r|\n|\r\n)	printf("NEW_LINE\n");
[ \t\v\f]+	printf("WHITE_SPACE\n");
%%
