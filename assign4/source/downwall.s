//*************************************************************************************
//
//	when the snake moves down and crash to the wall, lose a life.
//
//*************************************************************************************




.globl     downwall
downwall:
        push	{r6-r7, lr}
        px	.req	r8
        py	.req	r9
        
	ldr	r6, =Buffer
	ldr	r7, =ABuffer        
        

        ldr     px, [r6]
        ldr     py, [r7]
        add     py, #32
        cmp     py, #736
        beq     bb3
        cmp     px, #96
        bne     down1
        cmp     py, #192
        beq     bb3
down1:       
        cmp     px, #128
        bne     down2
        cmp     py, #192
        beq     bb3
down2:
         cmp    px, #256
        bne     down3
        cmp     py, #352
        beq     bb3
down3:
        cmp     px, #288
        bne     down4
        cmp     py, #352
        beq     bb3
down4:
        cmp     px, #320
        bne     down5
        cmp     py, #352
        beq     bb3
down5:     
        cmp     px, #640
        bne     down6
        cmp     py, #320
        beq     bb3
down6:
         cmp     px, #192
        bne      down7
        cmp     py, #448
        beq     bb3
down7:
         cmp     px, #160
        bne     down8
        cmp     py, #448
        beq     bb3
down8:
         cmp     px, #768
        bne      down9
        cmp     py, #416
        beq     bb3
down9: 
         cmp     px, #800
        bne     down10
        cmp     py, #320
        beq     bb3
down10:
         cmp     px, #928
        bne     down11
        cmp     py, #576
        beq     bb3
down11:
         cmp     px, #512
        bne     down12
        cmp     py, #192
        beq     bb3
down12:
        cmp     px, #480
        bne     down13
        cmp     py, #192
        bne     down13          
       

bb3:
           ldr	r1, =state
	   ldr	r0, [r1, #8]
           sub    r0, #1
           str    r0, [r1,#8]
           cmp    r0, #0
           bne    bbb3


        mov      px, #568
        mov      py, #100
BYLoopgreen:
        cmp      py, #115
        bge      BYDonegreen

BXLoopgreen: 
        cmp      px, #576
        bge      BXDonegreen

        mov     r0, px
        mov     r1, py	    
        mov		r2,#0x4F00
	    bl		DrawPixel
	    add		px, #1
        b       BXLoopgreen

BXDonegreen:
		mov		px, #568
		add		py, #1
		b		BYLoopgreen
   
BYDonegreen:

        mov	r0, #'0'
	mov	r1, #568
	mov	r2, #100
        bl	drawChar

         ldr	r1, =state
	 ldr	r0, [r1, #12]
         mov    r0, #0
         str    r0, [r1,#12]         
         b      checkWL
bbb3:
         b      start1    
down13:  
        .unreq	px
	.unreq	py 
	pop     {r6-r7, pc} 

