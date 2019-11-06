/* definitions */
%{
  #include "compiler.tab.h"
  char* newProgram;
  int currLine = 1;
  int currCol = 1;
%}

DIGIT [0-9]
LETTER [a-zA-Z]
LETTER_UNDER [a-zA-Z_]
CHAR [0-9a-zA-Z_]
ALPHANUM [0-9a-zA-Z]
WHITESPACE [\t ]
NEWLINE [\n]

/* rules */
%%
"function"     {return FUNCTION; currCol += yyleng;}
"beginparams"  {return BEGIN_PARAMS; currCol += yyleng;}
"endparams"    {return END_PARAMS;  currCol += yyleng;}
"beginlocals"  {return BEGIN_LOCALS; currCol += yyleng;}
"endlocals"    {return END_LOCALS; currCol += yyleng;}
"beginbody"    {return BEGIN_BODY; currCol += yyleng;}
"endbody"      {return END_BODY; currCol += yyleng;}
"integer"      {return INTEGER; currCol += yyleng;}
"array"        {return ARRAY; currCol += yyleng;}
"of"           {return OF; currCol += yyleng;}
"if"           {return IF; currCol += yyleng;}
"then"         {return THEN; currCol += yyleng;}
"endif"        {return ENDIF; currCol += yyleng;}
"else"         {return ELSE; currCol += yyleng;}
"while"        {return WHILE; currCol += yyleng;}
"do"           {return DO; currCol += yyleng;}
"foreach"      {return FOREACH; currCol += yyleng;}
"in"           {return IN; currCol += yyleng;}
"beginloop"    {return BEGINLOOP; currCol += yyleng;}
"endloop"      {return ENDLOOP; currCol += yyleng;}
"continue"     {return CONTINUE; currCol += yyleng;}
"read"         {return READ; currCol += yyleng;}
"write"        {return WRITE; currCol += yyleng;}
"and"          {return AND; currCol += yyleng;}
"or"           {return OR; currCol += yyleng;}
"not"          {return NOT; currCol += yyleng;}
"true"         {return TRUE; currCol += yyleng;}
"false"        {return FALSE; currCol += yyleng;}
"return"       {return RETURN; currCol += yyleng;}

"-"       {return SUB; ++currCol;}
"+"       {return ADD; ++currCol;}
"*"       {return MULT; ++currCol;}
"/"       {return DIV; ++currCol;}
"%"       {return MOD; ++currCol;}

"=="      {return EQ; currCol += 2;}
"<>"      {return NEQ; currCol += 2;}
"<"       {return LT; ++currCol;}
">"       {return GT; ++currCol;}
"<="      {return LTE; currCol += 2;}
">="      {return GTE; currCol += 2;}

";"       {return SEMICOLON; ++currCol;}
":"       {return COLON; ++currCol;}
","       {return COMMA; ++currCol;}
"("       {return L_PAREN; ++currCol;}
")"       {return R_PAREN; ++currCol;}
"["       {return L_SQUARE_BRACKET; ++currCol;}
"]"       {return R_SQUARE_BRACKET; ++currCol;}
":="      {return ASSIGN; currCol += 2;}

"##".*{NEWLINE} {currCol = 1; ++currLine;}
{NEWLINE}+      {currLine++; currCol = 1;}
{WHITESPACE}+   {currCol += yyleng;}

{LETTER}({CHAR}*{ALPHANUM}+)? {
  yylval.op_val = yytext;
  return IDENT;
  currCol += yyleng;
}

{DIGIT}+ {
  yylval.val = atoi(yytext);
  return NUMBER;
  currCol += yyleng;
}

({DIGIT}+{LETTER_UNDER}{CHAR}*)|("_"{CHAR}+) {
  printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter.\n",
	 currLine, currCol, yytext);
  exit(1);
}

{LETTER}({CHAR}*{ALPHANUM}+)?"_" {
  printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore.\n",\
	 currLine, currCol, yytext);
  exit(1);
			   }

. {
  printf("Error at line %d, column %d: unrecognized symbol \"%s\" \n",
	   currLine, currCol, yytext);
  exit(1);
}

%%
/* user code */
int yyparse();

int main(int argc, char* argv[]) {

  if (argc == 2) {
    yyin = fopen(argv[1], "r");
    if (yyin == 0) {
      printf("Error opening file: %s\n", argv[1]);
      exit(1);
    }
  }

  else {
    yyin = stdin;
  }
  newProgram = strdup(argv[1]);

  yyparse();
  return 0;
}
