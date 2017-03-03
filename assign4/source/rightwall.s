//*************************************************************************************
//
//	when the snake moves right and crash the wall, lose a life.
//
//*************************************************************************************






.globl     rightwall
rightwall:
        push	{r6-r7, lr}
        px	.req	r8
        py	.req	r9
        
	ldr	r6, =Buffer
	ldr	r7, =ABuffer        
        

        ldr     px, [r6]
        ldr     py, [r7]
        add     px, #32
        cmp     px, #992
        beq     bb
        cmp     px, #96
        bne     right1
        cmp     py, #192
        beq     bb
right1:
        cmp     px, #128
        bne     right2
        cmpeq     py, #224
        beq     bb
right2:
        cmp     px, #128
        bne     right3
        cmp     py, #256
        beq     bb
right3:
        cmp     px, #128
        bne     right4
        cmp     py, #288
        beq     bb
right4:
         cmp     px, #256
        bne     right5
        cmp     py, #352
        beq     bb
right5:
         cmp     px, #640
        bne     right6
        cmp     py, #320
        beq     bb
right6:
         cmp     px, #640
        bne     right7
        cmp     py, #352
        beq     bb
right7:
        cmp     px, #640
        bne     right8
        cmp     py, #384
        beq     bb
right8:
         cmp     px, #160
        bne     right9
        cmp     py, #448
        beq     bb
right9:
         cmp     px, #768
        bne     right10
        cmp     py, #416
        beq     bb
right10: 
         cmp     px, #800
        bne     right11
        cmp     py, #320
        beq     bb
right11:
         cmp     px, #928
        bne     right12
        cmp     py, #576
        beq     bb
right12:
         cmp     px, #928
        bne     right13
        cmp     py, #608
        beq     bb
right13:
         cmp     px, #512
        bne     right14
        cmp     py, #224
        beq     bb
right14:
        cmp     px, #480
        bne     right15
        cmp     py, #192
        bne     right15          

bb:
         ldr	r1, =state
	 ldr	r0, [r1, #8]
         sub    r0, #1
         str    r0, [r1,#8]
         cmp    r0, #0
         bne    bbb


        mov      px, #568
        mov      py, #100
BYLoopgreen5:
        cmp      py, #115
        bge      BYDonegreen5

BXLoopgreen5: 
        cmp      px, #576
        bge      BXDonegreen5

        mov     r0, px
        mov     r1, py	    
        mov		r2,#0x4F00
	    bl		DrawPixel
	    add		px, #1
        b       BXLoopgreen5

BXDonegreen5:
		mov		px, #568
		add		py, #1
		b		BYLoopgreen5
   
BYDonegreen5:

        mov	r0, #'0'
	mov	r1, #568
	mov	r2, #100
        bl	drawChar


         ldr	r1, =state
	 ldr	r0, [r1, #12]
         mov    r0, #0
         str    r0, [r1,#12]         
         b      checkWL
bbb:
         b      start1    
right15:  
        .unreq	px
	.unreq	py 
	pop     {r6-r7, pc} 

