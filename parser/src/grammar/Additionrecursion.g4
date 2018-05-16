grammar Additionrecursion;

program: (statement)+;

statement: println ';'
         | print ';'
         | varDeclarationList ';'
         | varDeclaration ';'
         | assignment ';'
         | branch
         | do_while ';'
         | while_statement
         | incrementation ';'
         | decrement ';'
         | forLoop 
         | booleanVarDeclaration ';'
         | booleanVarAssignment ';'
         | charArray ';'
         | arrayAssignment ';'
         ;

expression: lft= expression '/' rght=expression #Div
                | lft=expression '*' rght=expression #Mult
                | lft=expression '-' rght=expression #Minus
                | lft=expression '+' rght=expression #Plus
                | lft=expression operator = ('<'| '<=' | '>' |'>=') rght=expression #Relational
                | lft=expression '&&' rght=expression #And
                | lft=expression '||' rght=expression #Or
		| number=NUM #Number
                | subSign = MINUS number = NUM  #NegativeNumber
                | txt= STRING #String
                | varName=IDENTIFIER #Variable 
                | inverseBoolean #InverseBool
                ;

varDeclaration: 'int' varName=IDENTIFIER '=' exp = expression   #VarDeclarationAndAssignment
                |'int' varName=IDENTIFIER   #SimpleVarDeclaration
                | ',' varName= IDENTIFIER	#ListDeclaration
                ;
				
				
varDeclarationList: varDeclarationList varDeclaration
		| varDeclaration
		;

assignment: varName=IDENTIFIER '=' expr=expression  #directVarAssignment
            | varName= IDENTIFIER '=' input = userInput #InputVar
            ;

println: 'println(' txt=STRING '+' varName=IDENTIFIER ')' #PrintStatementAndVariable
         | 'println(' argument=expression ')' #simplePrintStatement 
         ;

print: 'print(' argument=expression ')' ;

branch: 'if' '(' lft=expression operator = ('<'| '<=' | '>' |'>=') rght=expression ')' onTrue=block 'else' onFalse=block    #CompareStatements_if
        | 'if' '(' '(' left_condition = expression ')' operator = '||' '(' right_condition = expression ')'')' onTrue = block          #If_statement_Or_Operator    
        |'if' '(' condition= expression ')' onTrue=block 'else' onFalse=block   #OtherIfStatements
        ;

do_while :'do' loop=block 'while' '(' '(' left_condition= expression ')' operator = '||' '(' right_condition=expression ')' ')' #DoWhile_Or_Operator
         | 'do' loop=block 'while' '(' condition= expression ')'    #SimpleDoWhile
         ;
while_statement: 'while' '(' condition = expression ')' loopCondition= block;

block: '{'statement* '}';

userInput: 'UserInputReader.readInt()'      
           | 'UserInputReader.readChar()'   
           ;

incrementation: varName= IDENTIFIER '++';

decrement: varName= IDENTIFIER '--';

forLoop: 'for' '('  initialization=forInitialization  ';' condition = expression ';' change=forChange ')' loopCondition= block ;

forInitialization: varDeclaration   #DeclareVariable_For
                 | assignment       #AssignVariable_For
                 ;

forChange: incrementation
           | decrement
           ;

booleanVarDeclaration: 'boolean' variableName = IDENTIFIER          #SimpleBooleanVariableDeclaration
                     | 'boolean' variableName = IDENTIFIER '=' value = booleanValue #BooleanVariableDeclarationAndAssignment
                     ; 

booleanVarAssignment: variableName = IDENTIFIER '=' value=booleanValue;

booleanValue: 'true'    #true
            | 'false'   #false
            ;

inverseBoolean: '!' variableName = IDENTIFIER;

charArray : 'char' '[]' arrayName = IDENTIFIER '=' 'new' 'char' '[' varName = IDENTIFIER ']';

arrayAssignment: arrayName = IDENTIFIER '[' number= expression ']' '=' InputCharacter = userInput ; 

MINUS: '-';

NUM: [0-9]+;

NEWLINE : [\r\n]+ ;

IDENTIFIER: [a-zA-Z][a-zA-Z0-9]*;

WHITESPACE: [ \t\n\r]+ -> skip;

STRING: '"' .*? '"';