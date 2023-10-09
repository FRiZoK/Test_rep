   AREA |.text|, CODE, READONLY
	
array_processing_asm	PROC	; Начало функции array_treatment_asm
	EXPORT array_processing_asm
    
    
    PUSH {R0-R11, LR}
    MOV R4, #4
    MUL R1, R4
    BL array_copy_asm
    BL array_minmax_asm 
    BL array_change_asm
    POP {R0-R11, PC}
    ENDP

; функция копирования массива в оперативную память
array_copy_asm PROC
    EXPORT array_copy_asm

    PUSH {R4-R11, LR}
    MOV R4, #0
    
exactly_COPY
    LDRB R5, [R0, R4]
    STRB R5, [R2, R4]
    ADD R4, #4
    CMP R4, R1
    BLT exactly_COPY
    POP {R4-R11, PC}
    
    ENDP

; функция поиска минимума и максимума
array_minmax_asm PROC
    EXPORT array_minmax_asm
    
    PUSH {R4-R11, LR}
    MOV R4, #0
    LDRB R5, [R2, #0]
    LDRB R6, [R2, #0]
    
CHECK
    
    ADD R4, #4        
    CMP R4, R1          
    BLT CHECK_MAX       
    MOV R0, R8
    MOV R1, R9
    POP {R4-R11, PC}

CHECK_MAX
    
    LDRB R7, [R2, R4]   
    CMP R7, R6          
    BGT CALC_MAX        
    B CHECK_MIN         
    
CALC_MAX
    
    MOV R6, R7
    MOV R8, R4          
    B CHECK             
    
CHECK_MIN
    
    CMP R7, R5          
    BLT CALC_MIN        
    B CHECK           
    
CALC_MIN
    
    MOV R5, R7
    MOV R9, R4          
    B CHECK             
    
    ENDP                

; функция перемены местами
array_change_asm PROC
    EXPORT array_change_asm
    
    PUSH {R4-R11, LR}
    LDRB R4, [R2, R0]
    LDRB R5, [R2, R1]
    STRB R4, [R2, R1]
    STRB R5, [R2, R0]
    POP {R4-R11, PC}
    
    ENDP
        
    END
	