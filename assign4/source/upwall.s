//*************************************************************************************
//
//	when the snake moves up and crash the wall, lose a life.
//
//*************************************************************************************



.globl     upwall
upwall:
        push	{r6-r7, lr}
        px	.req	r8
        py	.req	r9
        
	ldr	r6, =Buffer
	ldr	r7, =ABuffer        
        

        ldr     px, [r6]
        ldr     py, [r7]
        sub     py, #32
        cmp     py, #128
        beq     bb2
        cmp     px, #96
        bne     up1
        cmp     py, #192
        beq     bb2
up1:       
        cmp     px, #128
        bne     up2
        cmp     py, #288
        beq     bb2
up2:
         cmp    px, #256
        bne     up3
        cmp     py, #352
        beq     bb2
up3:
        cmp     px, #288
        bne     up4
        cmp     py, #352
        beq     bb2
up4:
        cmp     px, #320
        bne     up5
        cmp     py, #352
        beq     bb2
up5:     
        cmp     px, #640
        bne     up6
        cmp     py, #384
        beq     bb2
up6:
         cmp     px, #192
        bne      up7
        cmp     py, #448
        beq     bb2
up7:
         cmp     px, #160
        bne     up8
        cmp     py, #448
        beq     bb2
up8:
         cmp     px, #768
        bne      up9
        cmp     py, #416
        beq     bb2
up9: 
         cmp     px, #800
        bne     up10
        cmp     py, #320
        beq     bb2
up10:
         cmp     px, #928
        bne     up11
        cmp     py, #608
        beq     bb2
up11:
         cmp     px, #512
        bne     up12
        cmp     py, #224
        beq     bb2
up12:
        cmp     px, #480
        bne     up13
        cmp     py, #192
        bne     up13          
       

bb2:
         ldr	r1, =state
	 ldr	r0, [r1, #8]
         sub    r0, #1
         str    r0, [r1,#8]
         cmp    r0, #0
         bne    bbb2



 mov      px, #568
        mov      py, #100
BYLoopgreen7:
        cmp      py, #115
        bge      BYDonegreen7

BXLoopgreen7: 
        cmp      px, #576
        bge      BXDonegreen7

        mov     r0, px
        mov     r1, py	    
        mov		r2,#0x4F00
	    bl		DrawPixel
	    add		px, #1
        b       BXLoopgreen7

BXDonegreen7:
		mov		px, #568
		add		py, #1
		b		BYLoopgreen7
   
BYDonegreen7:

        mov	r0, #'0'
	mov	r1, #568
	mov	r2, #100
        bl	drawChar



         ldr	r1, =state
	 ldr	r0, [r1, #12]
         mov    r0, #0
         str    r0, [r1,#12]         
         b      checkWL
bbb2:
         b      start1 
           
up13:  
        .unreq	px
	.unreq	py 
	pop     {r6-r7, pc} 

