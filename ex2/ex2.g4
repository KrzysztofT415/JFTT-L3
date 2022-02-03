// ex2.g4
grammar ex2;

// Tokens
COMMENT: '#';
ENDLINE: [\n];
BACKSLASH: '\\';
WHITESPACE: [ \r\t];
CHARACTERS: [a-zA-Z]+;
LBRACKET: '(';
RBRACKET: ')';
PWR: '^';
MUL: '*';
DIV: '/';
MOD: '%';
ADD: '+';
SUB: '-';
NUMBER: [0-9]+;


// Rules
start
   : start line
   | EOF?;

line
   : ENDLINE #Nothing
   | COMMENT comment #Commentary
   | expression ENDLINE #Print
   ;

comment
    : BACKSLASH ENDLINE|EOF comment
    | (CHARACTERS|NUMBER|PWR|ADD|SUB|DIV|MUL|MOD|COMMENT|LBRACKET|RBRACKET|WHITESPACE) comment
    | ENDLINE
    ;

expression
   : operator=SUB? NUMBER #Numer
   | LBRACKET inner=expression RBRACKET #Parentheses
   | left=expression operator=PWR right=expression #Pwr
   | left=expression operator=(MUL|DIV|MOD) right=expression # MulDivMod
   | left=expression operator=(ADD|SUB) right=expression # AddSub
   ;