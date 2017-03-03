//*************************************************************************************
//
//	when the snake moves right and bite itself, lose a life.
//
//*************************************************************************************


.globl     rightbody
rightbody:
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
        add     px, #32

        
        mov    r4, #0
rightbodyloop:
        cmp     r4, bodylength
        bge     rightbodydone1
        add     r5, r4, #1
        mov     r3, #4
        mul     r5, r3,r5
        add     r1, r6, r5 
        add     r2, r7, r5 
        ldr     r1, [r1]
        ldr     r2, [r2]       
        cmp     px, r1
        bne     uequalbodyright
        cmp     py, r2
        beq     rightbodydone
uequalbodyright:
        add     r4, #1
        bne     rightbodyloop
rightbodydone:
         ldr	r1, =state
	 ldr	r0, [r1, #8]
         sub    r0, #1
         str    r0, [r1,#8]
         cmp    r0, #0
         bne    bodyright




        mov      px, #568
        mov      py, #100
BYLoopgreen4:
        cmp      py, #115
        bge      BYDonegreen4

BXLoopgreen4: 
        cmp      px, #576
        bge      BXDonegreen4

        mov     r0, px
        mov     r1, py	    
        mov		r2,#0x4F00
	    bl		DrawPixel
	    add		px, #1
        b       BXLoopgreen4

BXDonegreen4:
		mov		px, #568
		add		py, #1
		b		BYLoopgreen4
   
BYDonegreen4:

        mov	r0, #'0'
	mov	r1, #568
	mov	r2, #100
        bl	drawChar



         ldr	r1, =state
	 ldr	r0, [r1, #12]
         mov    r0, #0
         str    r0, [r1,#12]         
         b      checkWL
bodyright:
         b      start1  
rightbodydone1:
 
        .unreq	px
	.unreq	py 
        .unreq bodylength   
	pop     {r4-r10, pc} 

