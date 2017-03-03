//*****************************************************************************************
//
//	Draws the apple to a valid location.
//
//*****************************************************************************************

.globl test
test:
    push   {r4-r9, lr}

test1:
    ldr    r0, =0x20003004         	// address of CLO
    ldr    r1, [r0]

    bl    randNum			//generate x
    mov    r5, r0
    ldr    r0,=randomNumber
    str    r5, [r0]
    bl    randNum			//generate y
    mov    r6, r0
    ldr    r0,=randomNumber
    add    r0, #4
    str    r6, [r0]
    
    mov    r0, r5
    mov    r1, r6
    ldr    r2, =apple
    bl     drawCell
    
    cmp   r5, #32
    blt   checkcolour   
    cmp   r5, #960
    bgt   checkcolour
    cmp   r6, #160
    blt   checkcolour
    cmp   r6, #704
    bgt   checkcolour
    cmp   r5, #96
    bne   finish1
    cmp   r6, #192
    beq   addwall
finish1:
    cmp   r5, #128
    bne   finish2
    cmp   r6, #192
    beq   addwall
finish2:
    cmp   r5, #128
    bne   finish3
    cmp   r6, #224
    beq   addwall
finish3:
    cmp   r5, #128
    bne   finish4
    cmp   r6, #256
    beq   addwall
finish4:
    cmp   r5, #128
    bne   finish5
    cmp   r6, #288
    beq   addwall
finish5:
    cmp   r5, #256
    bne   finish6
    cmp   r6, #352
    beq   addwall
finish6:
    cmp   r5, #288
    bne   finish7
    cmp   r6, #352
    beq   addwall
finish7:
    cmp   r5, #320
    bne   finish8
    cmp   r6, #352
    beq   addwall
finish8:
    cmp   r5, #640
    bne   finish9
    cmp   r6, #352
    beq   addwall
finish9:
    cmp   r5, #640
    bne   finish10
    cmp   r6, #384
    beq   addwall
finish10:
    cmp   r5, #160
    bne   finish11
    cmp   r6, #448
    beq   addwall
finish11:
    cmp   r5, #192
    bne   finish12
    cmp   r6, #448
    beq   addwall
finish12:
    cmp   r5, #768
    bne   finish13
    cmp   r6, #416
    beq   addwall
finish13:
    cmp   r5, #800
    bne   finish14
    cmp   r6, #320
    beq   addwall
finish14:
    cmp   r5, #928
    bne   finish15
    cmp   r6, #576
    beq   addwall
finish15:
    cmp   r5, #928
    bne   finish16
    cmp   r6, #608
    beq   addwall
finish16:
    cmp   r5, #512
    bne   finish17
    cmp   r6, #224
    beq   addwall
finish17:
    cmp   r5, #512
    bne   finish18
    cmp   r6, #192
    beq   addwall
finish18:
    cmp   r5, #480
    bne   checkbody
    cmp   r6, #192
    beq   addwall

checkbody:
    ldr r0,=SnakeLength
    ldr r4, [r0]
    ldr r0,=Buffer
    ldr r7,[r0]
    ldr r1,=ABuffer
    ldr r8,[r1]
    cmp r5,r7
    bne checkother
    cmp r6, r8
    beq addyellow
    mov r9,#4
    mov r2, #0
checkother:
    cmp r2, r4
    bge finish
    ldr r0,=Buffer   
    add r0, r9
    ldr r1,=ABuffer
    add r1, r9   
    ldr r7,[r0]
    ldr r8,[r1]   
    cmp r5, r7
    bne check1
    cmp r6, r8
    beq addred
check1:
    add r2, #1
    add r9, #4
    b   checkother

addred:
        mov	r0, r5
	mov	r1, r6
        mov     r2, #0xF800
	bl	drawColour
        b       test1
    
addyellow:
        mov	r0, r5
	mov	r1, r6
        mov     r2, #0xF500
	bl	drawColour
        b       test1 

  
checkcolour:
       cmp r5, #0
       beq addwall
       cmp r5, #992
       beq addwall
       cmp r6, #736
       beq addwall
       cmp r6, #128
       beq addwall              

addgreen:
        mov	r0, r5
	mov	r1, r6
        mov     r2, #0x4F00
	bl	drawColour
        b       test1

addwall:
        mov	r0, r5
	mov	r1, r6
	ldr	r2, =wall
	bl	drawCell
        b       test1
finish:    
    pop     {r4-r9, pc}
 
