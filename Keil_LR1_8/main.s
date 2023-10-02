    GET stm32_EQU.s
MAX_SIZE    EQU     0xA
; Объявляем сегмент констант
    AREA CONSTANT_FLASH, DATA, READONLY
; Здесь объявляются константы
mas DCB -0x01, 0x07, 0x09, 0x09, -0x03, 0x00, 0x04, 0x05, -0x01, -0x01
; Объявляем сегмент переменных
negative DCB -0x05, 0x05
    AREA VERIABLE_RAM, DATA, READWRITE
; Здесь объявляются переменные
result  SPACE 0xA
; Объявляем сегмент кода 
        AREA MAIN,  CODE, READONLY
        THUMB
; Объявляем функцию main 
main PROC
        MOV R0, #NULL
        MOV R1, #ONE
        LDR R2, =negative
        LDRB R7, [R2,R0]
        LDRB R4, [R2,R1]
        ADD R7, R4
; Здесь пишется ваша программа
; Пример программы
        LDR R0, =mas ; МАССИВ
        LDR R1, =result ; АДРЕССА МАССИВА
        MOV R2, #MAX_SIZE ;КОЛИЧЕСТВО ЭЛЕМЕНТОВ
        MOV R3, #NULL ; ИСПОЛЬЗУЕТСЯ КАК СЧЕТЧИК
        MOV R4, #NULL ; АДРЕС ПОСЛЕДНЕГО ПОЛОЖИТЕЛЬНОГО ЭЛЕМЕНТА
        MOV R5, #NULL ; ТЕКУЩИЙ ЭЛЕМЕНТ
        MOV R6, #NULL ; СУММУ МАССИВ
        
        
CHECK
        CMP R3, #MAX_SIZE ; ПРОВЕРКА
        BLT SYM
        B   EXIT
        
SYM
        LDRB R5, [R0,R3] ;В R5 КЛАДЁМ ЧИСЛО С МАССИВА
        SXTB R8, R5
        ADD R6, R8       ;СУММА МАССИВА
        STRB R5, [R1,R3] ;ЗАПИСЫВАЕМ ЧИСЛО С R5 В МАССИВ R1
        ADD R3, #ONE
        CMP R8, #NULL ;СРАВНЕНИЕ ОТРИЦАТЕЛЬНОЕ ИЛИ ПОЛОЖИТЕЛЬНОЕ
        BLT CHECK
        SUB R3, #ONE 
        MOV R4, R3
        ADD R3, #ONE
        B CHECK
        
EXIT
        SDIV R6, R6,R2
        STRB R6, [R1,R4]
        
        ENDP ; Конец функции main
        END ; Конец файла