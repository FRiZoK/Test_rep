    GET stm32_EQU.s
MAX_SIZE    EQU     0x28
; Объявляем сегмент констант
    AREA CONSTANT_FLASH, DATA, READONLY
; Здесь объявляются константы
mas DCD -0x01, 0x07, 0x09, 0x09, -0x03, 0x00, 0x04, 0x05, -0x01, -0x01
; Объявляем сегмент переменных
    AREA VERIABLE_RAM, DATA, READWRITE
; Здесь объявляются переменные
result  SPACE 0xA
; Объявляем сегмент кода 
        AREA MAIN,  CODE, READONLY
        THUMB
; Объявляем функцию main 
main PROC
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
        LDR R5, [R0,R3] ;В R5 КЛАДЁМ ЧИСЛО С МАССИВА
        ADD R6, R5       ;СУММА МАССИВА
        STRB R5, [R1,R3] ;ЗАПИСЫВАЕМ ЧИСЛО С R5 В МАССИВ R1
        ADD R3, #FOUR
        CMP R5, #NULL ;СРАВНЕНИЕ ОТРИЦАТЕЛЬНОЕ ИЛИ ПОЛОЖИТЕЛЬНОЕ
        BLT CHECK
        SUB R3, #FOUR 
        MOV R4, R3
        ADD R3, #FOUR
        B CHECK
        
EXIT
        MOV R7, #FOUR
        SDIV R2, R2,R7
        SDIV R6, R6,R2
        STRB R6, [R1,R4]
        
        ENDP ; Конец функции main
        END ; Конец файла