/* CS 152 Phase 1
   Basic flex tool MINI-L
   Robert Yee
*/

 /*definitions */
%{ 
  #include "y.tab.h"
  int currPos = 1; int currLine = 1;
%}

 /*   
DIGIT [0-9]
IDENTIFIER ([a-zA-Z]+([a-zA-Z0-9]*"_"*[a-zA-Z0-9])
 */
  
     /* Rules */
%%
     /* Reserved Words */ 
"function"      return FUNCTION; currPos += yyleng;
"beginparams"   return BEGIN_PARAMS; currPos += yyleng;
"endparams"     return END_PARAMS; currPos += yyleng;
"beginlocals"   return BEGIN_LOCALS; currPos += yyleng;
"endlocals"     return END_LOCALS; currPos += yyleng;
"beginbody"     return BEGIN_BODY; currPos += yyleng;
"endbody"       return END_BODY; currPos += yyleng;
"integer"       return INTEGER; currPos += yyleng;
"arrray"        return ARRAY; currPos += yyleng;
"of"            return OF; currPos += yyleng;
"if"            return IF; currPos += yyleng;
"then"          return THEN; currPos += yyleng;
"endif"         return ENDIF; currPos += yyleng;
"else"          return ELSE; currPos += yyleng;
"while"         return WHILE; currPos += yyleng;
"do"            return DO; currPos += yyleng;
"beginloop"     return BEGINLOOP; currPos += yyleng;
"endloop"       return ENDLOOP; currPos += yyleng;
"continue"      return CONTINUE; currPos += yyleng;
"read"          return READ; currPos += yyleng;
"write"         return WRITE; currPos += yyleng;
"and"           return AND; currPos += yyleng;
"or"            return OR; currPos += yyleng;
"not"           return NOT; currPos += yyleng;
"true"          return TRUE; currPos += yyleng;
"false"         return FALSE; currPos += yyleng;
"return"        return RETURN; currPos += yyleng;
  
     /*arith ops*/
"-"             return SUB; currPos += yyleng;
"+"             return ADD; currPos += yyleng;
"*"             return MULT; currPos += yyleng;
"/"             return DIV; currPos += yyleng;
"%"             return MOD; currPos += yyleng; 

     /* compare ops */
"=="            return EQ; currPos += yyleng;
"<>"            return NEQ; currPos += yyleng;
"<"             return LT; currPos += yyleng;
">"             return GT; currPos += yyleng;
"<="            return LTE; currPos += yyleng;
">="            return GTE; currPos += yyleng;
     /*identifiers and numbers */
[a-zA-Z]+([a-zA-Z0-9]*"_"*[a-zA-Z0-9])*    strcpy(yylval.char_val,yytext); return IDENT; currPos += yyleng;

[0-9]+   yylval.int_val = atoi(yytext); return NUMBER; currPos += yyleng;



     /*special symbol */
";"             return SEMICOLON; currPos += yyleng;
":"             return COLON; currPos += yyleng;
","             return COMMA; currPos += yyleng;
"("             return LPAREN; currPos += yyleng;
")"             return RPAREN; currPos += yyleng;
"["             return LSQUARE; currPos += yyleng;
"]"             return RSQUARE; currPos += yyleng;
":="            return ASSIGN; currPos += yyleng;

    /* error catching */
"##".*          {currPos += yyleng;}

[ \t]+          {/* ignore spaces */ currPos += yyleng;}

"\n"            {currLine++; currPos = 1;}

.         {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

[0-9_][a-zA-Z]+[a-zA-Z0-9_]*   {printf("Error at line %d, column %d: end with underscore error \"%s\" \n", currLine, currPos, yytext); exit(0);}

[a-zA-Z]+[a-zA-Z0-9]*"_"       {printf("Error at line %d, column %d: unknown symbol \"%s\" \n", currLine, currPos, yytext); exit(0);}



 
%%

