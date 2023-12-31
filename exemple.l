b%option noyywrap
%{
#include "exp.tab.h"
int yyerror(char *sp);
%}
%%
[0-9]+ {yylval.vale=atoi(yytext); return NBI;}
[0-9]+\.[0-9]+ {yylval.valf=atof(yytext); return NBF;}
"+"     {return ADD;}
"-"     {return SUB;}
"*"     {return MULT;}
"/"     {return DIV;}
"^"     {return POW;}
"("     {return PO;}
")"     {return PV;}
","     {return SP;}
"cos"   {return COS;}
"sin"   {return SIN;}
"tan"   {return TAN;}
"sqrt"  {return SQRT;}
[ \t] ;
"\n" {return NL;}
. {yyerror("Error Lexical !!!");}

%%
main(){
    char file_Name[100];
    printf("wrtire the name fo file: ");
    scanf("%s", &file_Name);
    yyin = fopen(file_Name, "r");
    yyparse();
}
int yyerror(char *sp){
printf("%s", sp);
exit(1);
}
