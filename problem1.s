.global _start
_start:
    
    MOV r0, #6
    
    BL factorial
    
    MOV r7, #1      
    SWI 0           

factorial:
    PUSH {r2, lr}
    
    CMP r0, #0
    MOVEQ r1, #1
    BEQ factorial_end
    
    MOV r2, r0      
    SUB r0, r0, #1  
    BL factorial
    
    MUL r1, r2, r1
    
factorial_end:
    POP {r2, pc}