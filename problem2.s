.global _start
_start:
    
    MOV r0, #48
    MOV r1, #18
    
    BL gcd
    
    MOV r7, #1
    SWI 0


gcd:
    CMP r1, #0
    BEQ gcd_done
    
    MOV r2, r1
    MOV r3, r0
    
mod_loop:
    CMP r3, r1
    BLT mod_done
    
    SUB r3, r3, r1
    B mod_loop
    
mod_done:
    MOV r1, r3
    MOV r0, r2
    B gcd
    
gcd_done:
    BX lr