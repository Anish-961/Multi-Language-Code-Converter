%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

extern int yylineno;
%}

%%
[ \t]           ; /* ignore whitespace */
\n              { yylineno++; }
"#".*\n         { yylineno++; } /* ignore comments */

"def"           { return DEF; }
"if"            { return IF; }
"else"          { return ELSE; }
"elif"          { return ELIF; }
"for"           { return FOR; }
"while"         { return WHILE; }
"in"            { return IN; }
"range"         { return RANGE; }
"return"        { return RETURN; }
"print"         { return PRINT; }

"True"          { return TRUE; }
"False"         { return FALSE; }
"None"          { return NONE; }

"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIV; }
"%"             { return MOD; }
"="             { return ASSIGN; }
"=="            { return EQ; }
"!="            { return NEQ; }
"<"             { return LT; }
">"             { return GT; }
"<="            { return LE; }
">="            { return GE; }
"and"           { return AND; }
"or"            { return OR; }
"not"           { return NOT; }

"["             { return LBRACKET; }
"]"             { return RBRACKET; }
"("             { return LPAREN; }
")"             { return RPAREN; }
":"             { return COLON; }
","             { return COMMA; }
"."             { return DOT; }

[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }
[0-9]+\.[0-9]+  { yylval.fnum = atof(yytext); return FLOAT; }
\"[^\"]*\"      { yylval.str = strdup(yytext); return STRING; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENTIFIER; }

.               { return yytext[0]; }
%%

int yywrap(void) {
    return 1;
} 