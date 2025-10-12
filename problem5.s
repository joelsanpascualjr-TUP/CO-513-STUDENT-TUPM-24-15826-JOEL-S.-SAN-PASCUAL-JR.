.data
my_array: .word 7, 2, 10, 1, 0, -3, 5
array_size: .word 7

.text
.global _start
_start:
    
    LDR r0, =my_array     
    LDR r1, =array_size    
    LDR r1, [r1]           
    
    BL find_max            
    
    
    MOV r7, #1             
    SWI 0

find_max:
    CMP r1, #0             
    BEQ find_max_done      
    
    LDR r2, [r0]           
    MOV r3, #1             
    
find_max_loop:
    CMP r3, r1             
    BGE find_max_done      
    
    LDR r4, [r0, r3, LSL #2]  
    
    CMP r4, r2             
    MOVGT r2, r4           
    
    ADD r3, r3, #1         
    B find_max_loop        
    
find_max_done:
    BX lr                  