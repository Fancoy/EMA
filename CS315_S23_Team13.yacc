%{
#define YYDEBUG 1
int yylex();
void yyerror(const char *s);
%}

%token letter digit alphanumeric SEMICOLON LB RB LP RP LS RS	IF ELSE ELSEIF WHILE FOR ASSGNOP RETURN VOID BOOL_TYPE OR AND NOT IMPLIES DOUBLE_IMPLIES EQUAL NEQUAL COMMA SYMBOL COMMENT CHARS CHAR BOOL_CONST IN OUT FUNC LOOP NEWLINE TAB INDEX CONST
%left OR
%left AND
%left NOT
%left IMPLIES DOUBLE_IMPLIES
%left EQUAL NEQUAL
%left LS
%left LB
%left LP
%nonassoc IF

%start start

%%
start:   program {printf("Input program is valid\n"); return 0;}
program: 	stmts 
stmts: 	stmt  |  stmt  stmts;  
stmt: comment
   |  decl_stmts 
	|  assign_stmt 
   |  cond_stmt  
   |  input_stmt  
   |  output_stmt 
   |  loop_stmts     
   |  func_decl  
   |  array_decl 
   |  return_stmt
   
decl_stmts:  decl_stmt  
   |  decl_stmt  COMMA  decl_stmts  
   |  decl_stmt  NEWLINE  decl_stmts;  
decl_stmt:  BOOL_TYPE   var_id  ASSGNOP  expr  
	|  BOOL_TYPE   var_id 
	|  CONST var_id;	
   |  var_id 
assign_stmt:  var_id  ASSGNOP  expr 
   |  array_call ASSGNOP expr ;
var_id: letter | alphanumeric ;
cond_stmt : IF LP exprs RP LB stmts RB %prec IF
          | IF LP exprs RP LB stmts RB NEWLINE ELSE stmt %prec IF
          | IF LP exprs RP LB stmts RB NEWLINE ELSEIF LP exprs RP LB stmts RB %prec IF
          | IF LP exprs RP LB stmts RB NEWLINE ELSEIF LP exprs RP LB stmts RB NEWLINE ELSE stmt %prec IF
          ;
loop_stmts:   while_loop  
   |  for_loop ;
while_loop: WHILE  LP  exprs  RP LB  stmts  RB;
for_loop:   FOR  var_id  LOOP   array_call  LB  stmts  RB 
	|	 FOR  var_id  LOOP  array_stc  LB  stmts  RB ;
exprs: expr  
   |  expr  COMMA  exprs ;
expr: BOOL_CONST  
	| not_expr
   | and_expr
   | or_expr 
   | implies_expr
   | equaliy_expr
	| var_id 
	| input_stmt  
	| func_call  
   | array_stc ;
not_expr: NOT expr;
and_expr: expr AND expr ;
or_expr: expr OR expr ;
implies_expr: expr IMPLIES expr | expr DOUBLE_IMPLIES expr ;
equaliy_expr: expr EQUAL expr | expr NEQUAL expr ;
func_decl:  func_type   func_id  LP  decl_stmts  RP LB  stmts  RB  ;
func_id:   var_id ;
func_type: VOID FUNC |  BOOL_TYPE  FUNC;
func_call:  func_id  LP  exprs  RP ;
   |  func_id  LP RP  ;
return_stmt: RETURN  expr  ;
	| RETURN LP  expr  RP;
comment: COMMENT; 
input_stmt: IN LP  CHARS  RP ;
output_stmt: OUT LP  out_in  RP;
out_in:  CHARS  
	|  var_id 
   |  var_id  COMMA  out_in 
   |  CHARS  COMMA  out_in ;
array_decl:  BOOL_TYPE   var_id  LS  RS 
   |  BOOL_TYPE  var_id  LS RS ASSGNOP  array_stc ;
array_call:  arr_id LS INDEX RS ;
arr_id: letter | alphanumeric;
array_stc: LS  bool_var  RS;
bool_var:  BOOL_CONST  COMMA  bool_var  |  BOOL_CONST;
%%

int lineno = 1;

int main() {
    // yydebug = 1;
    if (yyparse() == 0) {
        printf("Input program is valid.\n");
	    return 0;
	} else {
		return 1;
    }

}

void yyerror(const char *s) { printf( "Syntax error on line %d!\n", lineno);}