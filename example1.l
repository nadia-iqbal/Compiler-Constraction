%{
    #include<stdio.h>
	int yywrap(void)
	{
		return 1;
	}

    int num_lines = 1, num_chars = 0;
%}

%%
\n    ++num_lines; ++num_chars;
.     ++num_chars;
end	  return 0;
%%
int main()
    {
    /* yyin as pointer
    of File type */
    extern FILE *yyin;
  
    /* yyin points to the file input.txt
    and opens it in read mode*/
    yyin = fopen("Input.txt", "r");
    
    yylex();
    printf( "no. of lines = %d, no. of chars = %d\n",
            num_lines, num_chars );

    }