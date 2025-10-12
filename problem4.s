.global _start
_start:

    MOV r0, #0xA4
    
    BL swap_nibbles
    
    MOV r7, #1     
    SWI 0

swap_nibbles:

    MOV r1, r0, LSL #4   
    MOV r2, r0, LSR #4   
    ORR r1, r1, r2       
    
    BX lr