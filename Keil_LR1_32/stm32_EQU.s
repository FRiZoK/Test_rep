; Определение макроподстановок
STACK       EQU     0x20000000 ; адрес стека
STACK_SIZE  EQU     0x500 ; размер стэка
STACK_TOP   EQU     STACK+STACK_SIZE ; вершина стека
    
    
NULL        EQU     0x00
ONE         EQU     0x01
FOUR        EQU     0x04
MAX         EQU     0x100
    END