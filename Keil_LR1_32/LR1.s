STACK_TOP EQU 0x20000100
    PRESERVE8
    THUMB
 
    AREA RESET, CODE, READONLY
 ; Таблица векторов прерываний
    DCD STACK_TOP ; Указатель на вершину стека
    DCD Start ; Вектор сброса
    ENTRY
Start   PROC ; Начало программы
; Первая строчка кода на ассемблере
loop ; Бесконечный цикл
    B loop
    ENDP ; Конец программы
    END ; Конец файла