/* scanner for a toy Pascal-like language */
 
%{
/* need this for the call to atof() below */
#include <math.h>
int yywrap(void) {
	return 1;
}
%}
    
DIGIT    [0-9]
ID       [A-Za-z+_][A-Za-z0-9_]*
CHAR 	 "'"[A-Za-z]"'"
STRING   "'"[A-Za-z]+"'"
REAL     [0-9][0-9+E]*"."[0-9+E]*"-"*[0-9]

 
%%

{DIGIT}+					{
								printf( "An integer: %s (%d)\n", yytext,
								atoi( yytext ) );
							}
 
PROGRAM|program|if|IF|else|ELSE|then|THEN|begin|BEGIN|end|END|procedure|PROCEDURE|function|FUNCTION|var|VAR|real|REAL|char|CHAR|string|STRING|integer|INTEGER|writeln|WRITELN {
								printf( "A keyword: %s\n", yytext );
							}
 
{ID}							printf( "An identifier: %s\n", yytext );
 
 
{CHAR}					{
								printf( "A character: %s \n", yytext
								);
							}
 
{STRING}					{
								printf( "A string: %s \n", yytext );
							}
 
{REAL}			{
								printf( "A real: %s (%g)\n", yytext,
								atof( yytext ) );
							}
[0-9.Ee\-+]+	{
								printf( "A exponential: %s (%g)\n", yytext,
								atof( yytext ) );
				}						

 
"+"|"-"|"*"|"/"|"?"|":="|"("|")"|"'"|"'"|"="|"+="|"/="|"*="|"-="|"=="|"!="|"<"|"<="|">"|">="|"#"|"&"|"&&"|"||"|"|"|"!"|">>"|">>>"|"<<"|"<<<"|"%"|"++"|"--"				printf( "An operator: %s\n", yytext );
 
 
";"|":"|"!"|"#"|"$"|","|"."|"@"|"^"|"_"|"`"|"~"					printf( "A delimiter : %s\n", yytext );
(['"])							printf( "A string : %s\n", yytext );


 
"{"[^{}\n]*"}"					/* eat up one-line comments */
 
[ \t\n\r\v\f]+						/* eat up whitespace */ 
 
%%
 
int main( int argc, char **argv ) {
	++argv, --argc;  /* skip over program name */
	if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
	else
		yyin = stdin;
 
	yylex();
}