//*************************************************************************************
//
//	when the snake moves left and crash the wall, lose a life.
//
//*************************************************************************************







.globl     leftwall
leftwall:
        push	{r6-r7, lr}
        px	.req	r8
        py	.req	r9
        
	ldr	r6, =Buffer
	ldr	r7, =ABuffer        
        

        ldr     px, [r6]
        ldr     py, [r7]
        sub     px, #32
        cmp     px, #0
        beq     bb1
        cmp     px, #128
        bne     left1
        cmp     py, #192
        beq     bb1
left1:
        cmp     px, #128
        bne     left2
        cmpeq     py, #224
        beq     bb1
left2:
        cmp     px, #128
        bne     left3
        cmp     py, #256
        beq     bb1
left3:
        cmp     px, #128
        bne     left4
        cmp     py, #288
        beq     bb1
left4:
         cmp     px, #320
        bne     left5
        cmp     py, #352
        beq     bb1
left5:
         cmp     px, #640
        bne     left6
        cmp     py, #320
        beq     bb1
left6:
         cmp     px, #640
        bne      left7
        cmp     py, #352
        beq     bb1
left7:
        cmp     px, #640
        bne     left8
        cmp     py, #384
        beq     bb1
left8:
         cmp     px, #192
        bne      left9
        cmp     py, #448
        beq     bb1
left9:
         cmp     px, #768
        bne      left10
        cmp     py, #416
        beq     bb1
left10: 
         cmp     px, #800
        bne     left11
        cmp     py, #320
        beq     bb1
left11:
         cmp     px, #928
        bne     left12
        cmp     py, #576
        beq     bb1
left12:
         cmp     px, #928
        bne     left13
        cmp     py, #608
        beq     bb1
left13:
         cmp     px, #512
        bne     left14
        cmp     py, #224
        beq     bb1
left14:
        cmp     px, #512
        bne     left15
        cmp     py, #192
        bne     left15          

bb1:
         ldr	r1, =state
	 ldr	r0, [r1, #8]
         sub    r0, #1
         str    r0, [r1,#8]
         cmp    r0, #0
         bne    bbb1


        mov      px, #568
        mov      py, #100
BYLoopgreen3:
        cmp      py, #115
        bge      BYDonegreen3

BXLoopgreen3: 
        cmp      px, #576
        bge      BXDonegreen3

        mov     r0, px
        mov     r1, py	    
        mov		r2,#0x4F00
	    bl		DrawPixel
	    add		px, #1
        b       BXLoopgreen3

BXDonegreen3:
		mov		px, #568
		add		py, #1
		b		BYLoopgreen3
   
BYDonegreen3:

        mov	r0, #'0'
	mov	r1, #568
	mov	r2, #100
        bl	drawChar
         ldr	r1, =state
	 ldr	r0, [r1, #12]
         mov    r0, #0
         str    r0, [r1,#12]         
         b      checkWL
bbb1:
         b      start1    
left15:  
        .unreq	px
	.unreq	py 
	pop     {r6-r7, pc} 

