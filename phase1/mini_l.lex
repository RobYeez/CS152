/* CS 152 Phase 1
   Basic flex tool MINI-L
   Robert Yee
*/

 /*definitions */
%{ 
  int currPos = 1; int currLine = 1;
%}

 /*   
DIGIT [0-9]
IDENTIFIER ([a-zA-Z]+([a-zA-Z0-9]*"_"*[a-zA-Z0-9])
 */
  
     /* Rules */
%%
     /* Reserved Words */ 
"function"      {printf("FUNCTION\n"); currPos += yyleng;}
"beginparams"   {printf("BEGIN_PARAMS\n"); currPos += yyleng;}
"endparams"     {printf("END_PARAMS\n"); currPos += yyleng;}
"beginlocals"   {printf("BEGIN_LOCALS\n"); currPos += yyleng;}
"endlocals"     {printf("END_LOCALS\n"); currPos += yyleng;}
"beginbody"     {printf("BEGIN_BODY\n"); currPos += yyleng;}
"endbody"       {printf("END_BODY\n"); currPos += yyleng;}
"integer"       {printf("INTEGER\n"); currPos += yyleng;}
"arrray"        {printf("ARRAY\n"); currPos += yyleng;}
"of"            {printf("OF\n"); currPos += yyleng;}
"if"            {printf("IF\n"); currPos += yyleng;}
"then"          {printf("THEN\n"); currPos += yyleng;}
"endif"         {printf("ENDIF\n"); currPos += yyleng;}
"else"          {printf("ELSE\n"); currPos += yyleng;}
"while"         {printf("WHILE\n"); currPos += yyleng;}
"do"            {printf("DO\n"); currPos += yyleng;}
"beginloop"     {printf("BEGINLOOP\n"); currPos += yyleng;}
"endloop"       {printf("ENDLOOP\n"); currPos += yyleng;}
"continue"      {printf("CONTINUE\n"); currPos += yyleng;}
"read"          {printf("READ\n"); currPos += yyleng;}
"write"         {printf("WRITE\n"); currPos += yyleng;}
"and"           {printf("AND\n"); currPos += yyleng;}
"or"            {printf("OR\n"); currPos += yyleng;}
"not"           {printf("NOT\n"); currPos += yyleng;}
"true"          {printf("TRUE\n"); currPos += yyleng;}
"false"         {printf("FALSE\n"); currPos += yyleng;}
"return"        {printf("RETURN\n"); currPos += yyleng;}
  
     /*arith ops*/
"-"             {printf("SUB\n"); currPos += yyleng;}
"+"             {printf("ADD\n"); currPos += yyleng;}
"*"             {printf("MULT\n"); currPos += yyleng;}
"/"             {printf("DIV\n"); currPos += yyleng;}
"%"             {printf("MOD\n"); currPos += yyleng;} 

     /* compare ops */
"=="            {printf("EQ\n"); currPos += yyleng;}
"<>"            {printf("NEQ\n"); currPos += yyleng;}
"<"             {printf("LT\n"); currPos += yyleng;}
">"             {printf("GT\n"); currPos += yyleng;}
"<="            {printf("LTE\n"); currPos += yyleng;}
">="            {printf("GTE\n"); currPos += yyleng;}
     /*identifiers and numbers */
[a-zA-Z]+([a-zA-Z0-9]*"_"*[a-zA-Z0-9])*        {printf("INDENT %s\n", yytext); currPos += yyleng;} 

[0-9]+   {printf("NUMBER %s\n", yytext); currPos += yyleng;}
 


     /*special symbol */
";"             {printf("SEMICOLON\n"); currPos += yyleng;}
":"             {printf("COLON\n"); currPos += yyleng;}
","             {printf("COMMA\n"); currPos += yyleng;}
"("             {printf("L_PAREN\n"); currPos += yyleng;}
")"             {printf("R_PAREN\n"); currPos += yyleng;}
"["             {printf("L_SQUARE_BRACKET\n"); currPos += yyleng;}
"]"             {printf("R_SQUARE_BRACKET\n"); currPos += yyleng;}
":="            {printf("ASSIGN\n"); currPos += yyleng;}

    /* error catching */
"##".*          {currPos += yyleng;}

[ \t]+          {/* ignore spaces */ currPos += yyleng;}

"\n"            {currLine++; currPos = 1;}

[ ] 		{currPos++;}

.         {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

[0-9_][a-zA-Z]+[a-zA-Z0-9_]*   {printf("Error at line %d, column %d: end with underscore error \"%s\" \n", currLine, currPos, yytext); exit(0);}

[a-zA-Z]+[a-zA-Z0-9]*"_"       {printf("Error at line %d, column %d: unknown symbol \"%s\" \n", currLine, currPos, yytext); exit(0);}



 
%%

int main () 
{
  yylex();
}


