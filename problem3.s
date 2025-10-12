.global _start
_start:
    
    MOV r0, #7
    
    BL parity
   
    MOV r7, #1
    SWI 0


parity:
    MOV r1, r0
    
    EOR r1, r1, r1, LSR #16  
    EOR r1, r1, r1, LSR #8   
    EOR r1, r1, r1, LSR #4   
    EOR r1, r1, r1, LSR #2   
    EOR r1, r1, r1, LSR #1  
    
    AND r1, r1, #1
    
    BX lr