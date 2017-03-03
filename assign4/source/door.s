//*******************************************************************************************
//
//	Draws door to a valid location.
//
//*******************************************************************************************

.globl door
door:
    push   {r4-r9, lr}

test1door :
    ldr    r0, =0x20003004         	// address of CLO
    ldr    r1, [r0]

    bl    randNum			//generate x
    mov    r5, r0
    ldr    r0,=randomNumberdoor
    str    r5, [r0]
    bl    randNum			//generate y
    mov    r6, r0
    ldr    r0,=randomNumberdoor
    add    r0, #4
    str    r6, [r0]
    
    mov    r0, r5
    mov    r1, r6
    mov	   r2, #0x0000
    bl	   drawColour
    
    cmp   r5, #32
    blt   checkcolourdoor   
    cmp   r5, #960
    bgt   checkcolourdoor 
    cmp   r6, #160
    blt   checkcolourdoor 
    cmp   r6, #704
    bgt   checkcolourdoor 
    cmp   r5, #96
    bne   finish1door 
    cmp   r6, #192
    beq   addwalldoor 
finish1door :
    cmp   r5, #128
    bne   finish2door 
    cmp   r6, #192
    beq   addwalldoor 
finish2door :
    cmp   r5, #128
    bne   finish3door 
    cmp   r6, #224
    beq   addwalldoor 
finish3door :
    cmp   r5, #128
    bne   finish4door 
    cmp   r6, #256
    beq   addwalldoor 
finish4door :
    cmp   r5, #128
    bne   finish5door 
    cmp   r6, #288
    beq   addwalldoor 
finish5door :
    cmp   r5, #256
    bne   finish6door 
    cmp   r6, #352
    beq   addwalldoor 
finish6door :
    cmp   r5, #288
    bne   finish7door 
    cmp   r6, #352
    beq   addwalldoor 
finish7door :
    cmp   r5, #320
    bne   finish8door 
    cmp   r6, #352
    beq   addwalldoor 
finish8door :
    cmp   r5, #640
    bne   finish9door 
    cmp   r6, #352
    beq   addwalldoor 
finish9door :
    cmp   r5, #640
    bne   finish10door 
    cmp   r6, #384
    beq   addwalldoor 
finish10door :
    cmp   r5, #160
    bne   finish11door 
    cmp   r6, #448
    beq   addwalldoor 
finish11door :
    cmp   r5, #192
    bne   finish12door 
    cmp   r6, #448
    beq   addwalldoor 
finish12door :
    cmp   r5, #768
    bne   finish13door 
    cmp   r6, #416
    beq   addwalldoor 
finish13door :
    cmp   r5, #800
    bne   finish14door 
    cmp   r6, #320
    beq   addwalldoor 
finish14door :
    cmp   r5, #928
    bne   finish15door 
    cmp   r6, #576
    beq   addwalldoor 
finish15door :
    cmp   r5, #928
    bne   finish16door 
    cmp   r6, #608
    beq   addwalldoor 
finish16door :
    cmp   r5, #512
    bne   finish17door 
    cmp   r6, #224
    beq   addwalldoor 
finish17door :
    cmp   r5, #512
    bne   finish18door 
    cmp   r6, #192
    beq   addwalldoor 
finish18door :
    cmp   r5, #480
    bne   checkbodydoor 
    cmp   r6, #192
    beq   addwalldoor 

checkbodydoor :
    ldr r0,=SnakeLength
    ldr r4, [r0]
    ldr r0,=Buffer
    ldr r7,[r0]
    ldr r1,=ABuffer
    ldr r8,[r1]
    cmp r5,r7
    bne checkotherdoor 
    cmp r6, r8
    beq addyellowdoor 
    mov r9,#4
    mov r2, #0
checkotherdoor :
    cmp r2, r4
    bge finishdoor 
    ldr r0,=Buffer   
    add r0, r9
    ldr r1,=ABuffer
    add r1, r9   
    ldr r7,[r0]
    ldr r8,[r1]   
    cmp r5, r7
    bne check1door 
    cmp r6, r8
    beq addreddoor 
check1door :
    add r2, #1
    add r9, #4
    b   checkotherdoor 

addreddoor :
        mov	r0, r5
	mov	r1, r6
        mov     r2, #0xF800
	bl	drawColour
        b       test1door 
    
addyellowdoor :
        mov	r0, r5
	mov	r1, r6
        mov     r2, #0xF500
	bl	drawColour
        b       test1door  

  
checkcolourdoor :
       cmp r5, #0
       beq addwalldoor 
       cmp r5, #992
       beq addwalldoor 
       cmp r6, #736
       beq addwalldoor 
       cmp r6, #128
       beq addwalldoor              

addgreendoor :
        mov	r0, r5
	mov	r1, r6
        mov     r2, #0x4F00
	bl	drawColour 
        b       test1door 

addwalldoor :
        mov	r0, r5
	mov	r1, r6
	ldr	r2, =wall
	bl	drawCell
        b       test1door 
finishdoor:    
    pop     {r4-r9, pc}
 
