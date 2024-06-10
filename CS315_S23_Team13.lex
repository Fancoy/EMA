%{
#include <stdio.h>
#include "y.tab.h"
void yyerror(char *);
%}

letter          [A-Za-z_$] 
digit           [0-9] 
alphanumeric    ({letter}{digit})
SEMICOLON       \;
LB              \{ 
RB              \} 
LP              \( 
RP              \) 
LS              \[ 
RS              \]
if              if
else            else
elseif          elseif
while           while
for             for
assgnop         \= 
return          return
void            void
bool_type       bool
OR              \|\|
AND             \&\&
NOT             \!  
IMPLIES         \=\=\>
DOUBLE_IMPLIES  \<\=\=\>
EQUAL           \=\=
NEQUAL          \!\=
COMMA           \,
symbol          [\40-\176]
comment         \#\#\#.*\#\#\#
chars           \"[^\"]*\"
char            \'.\'
bool_const      true|false 
IN              in
OUT             out
func            func 
loop            loop
NEWLINE         \n
TAB             \t
INDEX           \$*
CONST           const

%option yylineno
%%

{letter}    return letter;
{digit}    return digit;
{alphanumeric}    return alphanumeric;
{bool_const}    return BOOL_CONST;
{chars}         return CHARS;
{SEMICOLON}     return SEMICOLON;
{LB}            return LB;
{RB}            return RB;
{LP}            return LP;
{RP}            return RP;
{LS}            return LS;
{RS}            return RS;
{if}            return IF;
{else}          return ELSE;
{while}         return WHILE;
{elseif}        return ELSEIF;
{for}           return FOR;
{assgnop}       return ASSGNOP;
{return}        return RETURN;
{bool_type}     return BOOL_TYPE;
{NEWLINE}       { extern int yylineno; yylineno++; }
{TAB}           return TAB;
{AND}           return AND;
{NOT}           return NOT;
{IMPLIES}       return IMPLIES;
{DOUBLE_IMPLIES} return DOUBLE_IMPLIES;
{EQUAL}         return EQUAL;
{NEQUAL}        return NEQUAL;
{COMMA}         return COMMA;
{comment}       return COMMENT;
{OR}            return OR;
{IN}            return IN;
{OUT}           return OUT;
{void}          return VOID;
{func}          return FUNC;
{loop}          return LOOP;
{char}          return CHAR;
{INDEX}         return INDEX;
{CONST}         return CONST;
%%
int yywrap(void) { return 1; }