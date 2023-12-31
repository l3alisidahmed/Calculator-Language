%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int yylex();
int yyerror(const char *s);
%}
%union{
int vale;
float valf;
}
%token<vale> NBI
%token<valf> NBF
%token NL 
%token ADD
%token MULT
%token PO
%token PV
%token SP
%left ADD SUB
%left MULT DIV
%left COS SIN TAN
%left SQRT
%right POW
%type<vale> expression
%type<valf> expressionf
%start calcul
%%
calcul : 
       |calcul exp
       ;
exp : NL
    |expression NL {printf("Result %i \n",$1);}
    |expressionf NL {printf("Result %.2f \n",$1);}
    ;
expression : NBI {$$=$1;}
           | ADD PO expression SP expression PV {$$=$3+$5;}
           | SUB PO expression SP expression PV {$$=$3-$5;}
           | MULT PO expression SP expression PV {$$=$3*$5;} 
           | SQRT PO expression PV {$$=sqrt($3);}
           | POW PO expression SP expression PV {$$=pow($3, $5);}
           ;
expressionf : NBF {$$=$1;}
            | ADD PO expressionf SP expressionf PV {$$=$3+$5;}
            | ADD PO expression SP expressionf PV {$$=$3+$5;}
            | ADD PO expressionf SP expression PV {$$=$3+$5;}
            | SUB PO expressionf SP expressionf PV {$$=$3-$5;}
            | SUB PO expression SP expressionf PV {$$=$3-$5;}
            | SUB PO expressionf SP expression PV {$$=$3-$5;}
            | MULT PO expressionf SP expressionf PV {$$=$3*$5;}
            | MULT PO expression SP expressionf PV {$$=$3*$5;}
            | MULT PO expressionf SP expression PV {$$=$3*$5;}
            | DIV PO expressionf SP expressionf PV {if($5 != 0) $$=$3/$5; else yyerror("ne peut pas diviser sur 0");}
            | DIV PO expression SP expressionf PV {if($5 != 0) $$=$3/$5; else yyerror("ne peut pas diviser sur 0");}
            | DIV PO expressionf SP expression PV {if($5 != 0) $$=$3/$5; else yyerror("ne peut pas diviser sur 0");}
            | DIV PO expression SP expression PV {if($5 != 0) $$=$3/$5; else yyerror("ne peut pas diviser sur 0");}
            | COS PO expression PV {$$=cos($3);}
            | SIN PO expression PV {$$=sin($3);}
            | TAN PO expression PV {$$=tan($3);}
            | SIN PO expressionf PV {$$=sin($3);}
            | SIN PO ADD PO expressionf SP expression PV PV {$$=sin($5+$7);}
            | SIN PO ADD PO expression SP expressionf PV PV {$$=sin($5+$7);}
            | SIN PO ADD PO expressionf SP expressionf PV PV {$$=sin($5+$7);}
            | SIN PO SUB PO expressionf SP expression PV PV {$$=sin($5-$7);}
            | SIN PO SUB PO expression SP expressionf PV PV {$$=sin($5-$7);}
            | SIN PO SUB PO expressionf SP expressionf PV PV {$$=sin($5-$7);}
            | SIN PO MULT PO expressionf SP expression PV PV {$$=sin($5*$7);}
            | SIN PO MULT PO expression SP expressionf PV PV {$$=sin($5*$7);}
            | SIN PO MULT PO expressionf SP expressionf PV PV {$$=sin($5*$7);}
            | SIN PO DIV PO expressionf SP expression PV PV {if($7 != 0) $$=sin($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | SIN PO DIV PO expression SP expressionf PV PV {if($7 != 0) $$=sin($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | SIN PO DIV PO expressionf SP expressionf PV PV {if($7 != 0) $$=sin($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | SIN PO DIV PO expression SP expression PV PV {if($7 != 0) $$=sin($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | COS PO expressionf PV {$$=cos($3);}
            | COS PO ADD PO expressionf SP expression PV PV {$$=cos($5+$7);}
            | COS PO ADD PO expression SP expressionf PV PV {$$=cos($5+$7);}
            | COS PO ADD PO expressionf SP expressionf PV PV {$$=cos($5+$7);}
            | COS PO SUB PO expressionf SP expression PV PV {$$=cos($5-$7);}
            | COS PO SUB PO expression SP expressionf PV PV {$$=cos($5-$7);}
            | COS PO SUB PO expressionf SP expressionf PV PV {$$=cos($5-$7);}
            | COS PO MULT PO expressionf SP expression PV PV {$$=cos($5*$7);}
            | COS PO MULT PO expression SP expressionf PV PV {$$=cos($5*$7);}
            | COS PO MULT PO expressionf SP expressionf PV PV {$$=cos($5*$7);}
            | COS PO DIV PO expressionf SP expression PV PV {if($7 != 0) $$=cos($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | COS PO DIV PO expression SP expressionf PV PV {if($7 != 0) $$=cos($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | COS PO DIV PO expressionf SP expressionf PV PV {if($7 != 0) $$=cos($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | COS PO DIV PO expression SP expression PV PV {if($7 != 0) $$=cos($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | TAN PO expressionf PV {$$=tan($3);}
            | TAN PO ADD PO expressionf SP expression PV PV {$$=tan($5+$7);}
            | TAN PO ADD PO expression SP expressionf PV PV {$$=tan($5+$7);}
            | TAN PO ADD PO expressionf SP expressionf PV PV {$$=tan($5+$7);}
            | TAN PO SUB PO expressionf SP expression PV PV {$$=tan($5-$7);}
            | TAN PO SUB PO expression SP expressionf PV PV {$$=tan($5-$7);}
            | TAN PO SUB PO expressionf SP expressionf PV PV {$$=tan($5-$7);}
            | TAN PO MULT PO expressionf SP expression PV PV {$$=tan($5*$7);}
            | TAN PO MULT PO expression SP expressionf PV PV {$$=tan($5*$7);}
            | TAN PO MULT PO expressionf SP expressionf PV PV {$$=tan($5*$7);}
            | TAN PO DIV PO expressionf SP expression PV PV {if($7 != 0) $$=tan($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | TAN PO DIV PO expression SP expressionf PV PV {if($7 != 0) $$=tan($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | TAN PO DIV PO expressionf SP expressionf PV PV {if($7 != 0) $$=tan($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | TAN PO DIV PO expression SP expression PV PV {if($7 != 0) $$=tan($5/$7); else yyerror("ne peut pas diviser sur le nombre 0");}
            | POW PO expressionf SP expressionf PV {$$=pow($3,$5);}
            | POW PO expression SP expressionf PV {$$=pow($3,$5);}
            | POW PO expressionf SP expression PV {$$=pow($3,$5);}
            | SQRT PO expressionf PV {$$=sqrt($3);}
            ; 
%%

