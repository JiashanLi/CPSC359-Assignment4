//*************************************************************************************
//
//	when the snake moves left and bite itself, lose a life.
//
//*************************************************************************************





.globl     leftbody
leftbody:
        push	{r4-r10, lr}
        px	.req	r8
        py	.req	r9
        bodylength   .req r10

        ldr     r0, =SnakeLength
	ldr	bodylength, [r0]
        
	ldr	r6, =Buffer
	ldr	r7, =ABuffer
        
        ldr     px, [r6]
        ldr     py, [r7]
        sub     px, #32

        
        mov    r4, #0
leftbodyloop:
        cmp     r4, bodylength
        bge     leftbodydone1
        add     r5, r4, #1
        mov     r3, #4
        mul     r5, r3,r5
        add     r1, r6, r5 
        add     r2, r7, r5 
        ldr     r1, [r1]
        ldr     r2, [r2]       
        cmp     px, r1
        bne     uequalbodyleft
        cmp     py, r2
        beq     leftbodydone
uequalbodyleft:
        add     r4, #1
        bne     leftbodyloop
leftbodydone:
         ldr	r1, =state
	 ldr	r0, [r1, #8]
         sub    r0, #1
         str    r0, [r1,#8]
         cmp    r0, #0
         bne    bodyleft


        mov      px, #568
        mov      py, #100
BYLoopgreen2:
        cmp      py, #115
        bge      BYDonegreen2

BXLoopgreen2: 
        cmp      px, #576
        bge      BXDonegreen2

        mov     r0, px
        mov     r1, py	    
        mov		r2,#0x4F00
	    bl		DrawPixel
	    add		px, #1
        b       BXLoopgreen2

BXDonegreen2:
		mov		px, #568
		add		py, #1
		b		BYLoopgreen2
   
BYDonegreen2:

        mov	r0, #'0'
	mov	r1, #568
	mov	r2, #100
        bl	drawChar


         ldr	r1, =state
	 ldr	r0, [r1, #12]
         mov    r0, #0
         str    r0, [r1,#12]         
         b      checkWL
bodyleft:
         b      start1  
leftbodydone1:
 
        .unreq	px
	.unreq	py 
        .unreq bodylength   
	pop     {r4-r10, pc} 

