
.equ ADDR_JP1, 0xFF200060
.equ ADDR_JP2, 0xFF200070
.equ ADDR_HEX, 0xFF200020
.equ ADDR_KEY, 0xFF200050 
.equ ADDR_SW,  0xFF200040

.equ DEBOUNCE_DELAY, 50000
.equ COUNTER_DELAY, 3000000

.section .data
counter:        .word 0
running:        .word 0
prev_key0:      .word 1
prev_key1:      .word 1

.section .text
.global _start

_start:
    
    mov sp, #0x20000
    
    ldr r0, =running
    mov r1, #0
    str r1, [r0]
    
    ldr r0, =counter
    mov r1, #0
    str r1, [r0]
    
    ldr r0, =prev_key0
    mov r1, #1
    str r1, [r0]
    
    ldr r0, =prev_key1
    mov r1, #1
    str r1, [r0]
    
main_loop:
    bl check_buttons
    bl update_counter
    bl display_counter
    bl delay_short
    b main_loop


check_buttons:
    push {r4-r8, lr}
    
    ldr r4, =ADDR_KEY
    ldr r4, [r4]
    and r5, r4, #1
    and r6, r4, #2
    lsr r6, #1
    
    ldr r7, =prev_key0
    ldr r7, [r7]
    ldr r8, =prev_key1
    ldr r8, [r8]
    
    cmp r7, #1
    bne check_key1
    cmp r5, #0
    bne check_key1
    
    bl delay_debounce
    bl verify_key0_press
    cmp r0, #1
    bne check_key1
    
    ldr r0, =running
    ldr r1, [r0]
    eor r1, #1
    str r1, [r0]
    
check_key1:

    cmp r8, #1
    bne update_prev_states
    cmp r6, #0
    bne update_prev_states
    
    bl delay_debounce
    bl verify_key1_press
    cmp r0, #1
    bne update_prev_states
    
    ldr r0, =counter
    mov r1, #0
    str r1, [r0]
    
    ldr r0, =running
    mov r1, #0
    str r1, [r0]
    
update_prev_states:

    ldr r0, =prev_key0
    str r5, [r0]
    ldr r0, =prev_key1
    str r6, [r0]
    
    pop {r4-r8, pc}


verify_key0_press:
    push {lr}
    ldr r0, =ADDR_KEY
    ldr r0, [r0]
    and r0, #1
    cmp r0, #0
    moveq r0, #1
    movne r0, #0
    pop {pc}

verify_key1_press:
    push {lr}
    ldr r0, =ADDR_KEY
    ldr r0, [r0]
    and r0, #2
    cmp r0, #0
    moveq r0, #1
    movne r0, #0
    pop {pc}

update_counter:
    push {r4-r6, lr}
    
    ldr r4, =running
    ldr r4, [r4]
    cmp r4, #0
    beq update_done
    
    bl delay_counter
    
    ldr r5, =ADDR_SW
    ldr r5, [r5]
    and r5, #1
    
    ldr r6, =counter
    ldr r4, [r6]
    
    cmp r5, #0
    bne count_down
    
count_up:

    add r4, #1
    cmp r4, #60
    movge r4, #0
    b store_counter
    
count_down:

    sub r4, #1
    cmp r4, #0
    movlt r4, #59
    
store_counter:
    str r4, [r6]
    
update_done:
    pop {r4-r6, pc}


display_counter:
    push {r4-r8, lr}
    
    ldr r4, =counter
    ldr r4, [r4]
    
    mov r6, #0
    mov r5, r4
    
calculate_tens:
    cmp r5, #10
    blt calculate_done
    sub r5, r5, #10
    add r6, r6, #1
    b calculate_tens
    
calculate_done:
    mov r7, r5
    
    mov r0, r6
    bl digit_to_hex
    mov r6, r0
    
    mov r0, r7
    bl digit_to_hex
    mov r7, r0
    
    lsl r6, #8
    orr r8, r6, r7
    
    ldr r0, =ADDR_HEX
    str r8, [r0]
    
    pop {r4-r8, pc}


digit_to_hex:
    push {r1, lr}
    

    ldr r1, =hex_patterns
    ldr r0, [r1, r0, lsl #2]
    
    pop {r1, pc}

hex_patterns:
    .word 0x3F  /* 0 */
    .word 0x06  /* 1 */
    .word 0x5B  /* 2 */
    .word 0x4F  /* 3 */
    .word 0x66  /* 4 */
    .word 0x6D  /* 5 */
    .word 0x7D  /* 6 */
    .word 0x07  /* 7 */
    .word 0x7F  /* 8 */
    .word 0x6F  /* 9 */


delay_counter:
    push {r0}
    ldr r0, =COUNTER_DELAY
counter_delay_loop:
    subs r0, #1
    bne counter_delay_loop
    pop {r0}
    mov pc, lr

delay_debounce:
    push {r0}
    ldr r0, =DEBOUNCE_DELAY
debounce_loop:
    subs r0, #1
    bne debounce_loop
    pop {r0}
    mov pc, lr

delay_short:
    push {r0}
    ldr r0, =5000
short_delay_loop:
    subs r0, #1
    bne short_delay_loop
    pop {r0}
    mov pc, lr

.end