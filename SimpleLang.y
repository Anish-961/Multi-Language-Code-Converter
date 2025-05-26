%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

extern int yylineno;
extern char* target_language;
%}

%union {
    int num;
    float fnum;
    char* str;
}

%token <num> NUMBER
%token <fnum> FLOAT
%token <str> IDENTIFIER STRING
%token DEF IF ELSE ELIF FOR WHILE IN RANGE RETURN PRINT
%token TRUE FALSE NONE
%token PLUS MINUS MULT DIV MOD ASSIGN
%token EQ NEQ LT GT LE GE
%token AND OR NOT
%token LBRACKET RBRACKET LPAREN RPAREN COLON COMMA DOT

%type <str> stmt stmt_list expr term factor
%type <str> if_stmt for_stmt while_stmt def_stmt
%type <str> array array_elements

%%

program: stmt_list { printf("%s", $1); }
;

stmt_list: stmt { $$ = $1; }
        | stmt_list stmt { $$ = strcat($1, $2); }
;

stmt: expr_stmt
    | if_stmt
    | for_stmt
    | while_stmt
    | def_stmt
    | print_stmt
;

expr_stmt: IDENTIFIER ASSIGN expr { 
    if(strcmp(target_language, "c") == 0) {
        $$ = malloc(100);
        sprintf($$, "int %s = %s;\n", $1, $3);
    }
    else if(strcmp(target_language, "cpp") == 0) {
        $$ = malloc(100);
        sprintf($$, "int %s = %s;\n", $1, $3);
    }
    else if(strcmp(target_language, "java") == 0) {
        $$ = malloc(100);
        sprintf($$, "int %s = %s;\n", $1, $3);
    }
    else {
        $$ = malloc(100);
        sprintf($$, "%s = %s\n", $1, $3);
    }
}
;

if_stmt: IF expr COLON stmt_list { 
    if(strcmp(target_language, "c") == 0) {
        $$ = malloc(200);
        sprintf($$, "if (%s) {\n%s}\n", $2, $4);
    }
    else if(strcmp(target_language, "cpp") == 0) {
        $$ = malloc(200);
        sprintf($$, "if (%s) {\n%s}\n", $2, $4);
    }
    else if(strcmp(target_language, "java") == 0) {
        $$ = malloc(200);
        sprintf($$, "if (%s) {\n%s}\n", $2, $4);
    }
    else {
        $$ = malloc(200);
        sprintf($$, "if %s:\n%s", $2, $4);
    }
}
;

for_stmt: FOR IDENTIFIER IN RANGE LPAREN expr COMMA expr RPAREN COLON stmt_list {
    if(strcmp(target_language, "c") == 0) {
        $$ = malloc(200);
        sprintf($$, "for(int %s = %s; %s < %s; %s++) {\n%s}\n", $2, $6, $2, $8, $2, $11);
    }
    else if(strcmp(target_language, "cpp") == 0) {
        $$ = malloc(200);
        sprintf($$, "for(int %s = %s; %s < %s; %s++) {\n%s}\n", $2, $6, $2, $8, $2, $11);
    }
    else if(strcmp(target_language, "java") == 0) {
        $$ = malloc(200);
        sprintf($$, "for(int %s = %s; %s < %s; %s++) {\n%s}\n", $2, $6, $2, $8, $2, $11);
    }
    else {
        $$ = malloc(200);
        sprintf($$, "for %s in range(%s, %s):\n%s", $2, $6, $8, $11);
    }
}
;

print_stmt: PRINT expr {
    if(strcmp(target_language, "c") == 0) {
        $$ = malloc(100);
        sprintf($$, "printf(\"%%d\\n\", %s);\n", $2);
    }
    else if(strcmp(target_language, "cpp") == 0) {
        $$ = malloc(100);
        sprintf($$, "cout << %s << endl;\n", $2);
    }
    else if(strcmp(target_language, "java") == 0) {
        $$ = malloc(100);
        sprintf($$, "System.out.println(%s);\n", $2);
    }
    else {
        $$ = malloc(100);
        sprintf($$, "print(%s)\n", $2);
    }
}
;

expr: term { $$ = $1; }
    | expr PLUS term { 
        $$ = malloc(100);
        sprintf($$, "(%s + %s)", $1, $3);
    }
    | expr MINUS term {
        $$ = malloc(100);
        sprintf($$, "(%s - %s)", $1, $3);
    }
;

term: factor { $$ = $1; }
    | term MULT factor {
        $$ = malloc(100);
        sprintf($$, "(%s * %s)", $1, $3);
    }
    | term DIV factor {
        $$ = malloc(100);
        sprintf($$, "(%s / %s)", $1, $3);
    }
;

factor: NUMBER { 
    $$ = malloc(20);
    sprintf($$, "%d", $1);
}
    | IDENTIFIER { $$ = $1; }
    | LPAREN expr RPAREN { $$ = $2; }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error at line %d: %s\n", yylineno, s);
}

int main(int argc, char *argv[]) {
    if(argc != 2) {
        printf("Usage: %s <target_language>\n", argv[0]);
        return 1;
    }
    target_language = argv[1];
    yyparse();
    return 0;
} 