%{
    #include <stdio.h>
    #include <math.h>
    #include"calculations.h"

    extern int yylineno;
    int err = 0;
    char* default_err = "invalid syntax";
    char* err_msg = "invalid syntax";
    int yylex(void);
    void yyerror(const char *s);
%}


%token NUM
%token NEWLINE
%left PLUS MINUS
%left MULT MOD DIV
%token LBRACKET
%token RBRACKET
%right PWR
%precedence NEG


%%
input:
    %empty
    | input line
;
line:
    NEWLINE
    | expr NEWLINE  {   
                        if(!err) printf("\nResult: %d \n", $1);
                        else printf("\n");
                    }
    | error NEWLINE 
;
expr:
    NUM { $$ = translate($1); printf(" %d ", translate($1)); }
    | expr PLUS expr { $$ = add(translate($1), translate($3)); printf(" + "); }
    | expr MINUS expr { $$ = substract(translate($1), translate($3)); printf(" - "); }
    | expr MULT expr { $$ = multiply(translate($1), translate($3)); printf(" * "); }
    | expr DIV expr { 
                        if($3 == 0) { err_msg = "dividing by 0 is not allowed"; yyerror(""); }
                        $$ = divide(translate($1), translate($3));
                        printf(" / ");
                    }
    | expr MOD expr {
                        if(translate($3) == 0) { err_msg = "dividing by 0 is not allowed"; yyerror(""); }
                        $$ = modulo(translate($1), translate($3));
                        printf(" %% ");
                    }
    | MINUS expr %prec NEG { $$ = neg(translate($2));  printf(" - "); }
    | expr PWR expr {
                        if(translate($3) < 0) { err_msg = "negative exponent is not allowed"; yyerror(""); }
                        $$ = power(translate($1), translate($3));
                        printf(" ^ ");
                    }
    | LBRACKET expr RBRACKET   { $$ = $2; }
;
%%

int yywrap(void) { return 1; }

void yyerror(const char *s) {
    err = 1;
    printf("\033[0;31mError: %s \033[0;0m", err_msg);
    err_msg = default_err;
    return;
}

int main(void) {
    return yyparse();
}