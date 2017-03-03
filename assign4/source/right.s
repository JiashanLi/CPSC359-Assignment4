//************************************************************************************************
//
//	move the snake right for one cell.
//
//************************************************************************************************

.globl     moveRight
moveRight:
        push	{r4-r11, lr}
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

         ldr    r0,=randomNumberdoor
	 ldr    r1, [r0]
         add    r0, #4
         ldr    r2,[r0]
         cmp    px, r1
         bne    checkrandom3
         cmp    py, r2         
	 bne	checkrandom3
         ldr    r1, =state
         ldr    r0, [r1,#12]
         mov    r0, #1
         str    r0, [r1, #12]
         b      checkWL
        
checkrandom3:
	 ldr    r0,=randomNumber
	 ldr    r1, [r0]
         add    r0, #4
         ldr    r2,[r0]
         cmp    px, r1
         bne    b1
         cmp    py, r2         
	 bne	b1
        add     bodylength, #1
       
         ldr    r0, =state
         ldr    r1, [r0]
         add    r1, #1
         str    r1, [r0]
 

         mov      px, #448
        mov      py, #100
BYLoopgreenright:
        cmp      py, #115
        bge      BYDonegreenright

BXLoopgreenright: 
        cmp      px, #472
        bge      BXDonegreenright

        mov     r0, px
        mov     r1, py	    
        mov		r2,#0x4F00
	    bl		DrawPixel
	    add		px, #1
        b       BXLoopgreenright

BXDonegreenright:
		mov		px, #448
		add		py, #1
		b		BYLoopgreenright
BYDonegreenright:

         bl     showscore        
         b      noRemove3
        

b1:              
        mov     r5,#4
        mul     r4, r5, bodylength
        add     r3, r6,r4
        add     r5, r7,r4   
        ldr     r0,[r3]
        ldr     r1,[r5]     
        mov     r2, #0x4F00
	bl	drawColour 
                      
noRemove3:
        mov     r11,bodylength
loopright:
        cmp     r11, #0
        ble     doneright
        mov     r5, #4
        sub     r4,r11, #1
        mul     r3,r4, r5
        add     r1, r3, r6
        add     r2, r3, r7
        ldr     px,[r1]
        ldr     py,[r2]
        add     r1, #4
        add     r2, #4    
        str     px, [r1]
        str     py, [r2]
        sub     r11,#1
        b       loopright
doneright:      
        add     px, #32
        str     px, [r6]       
        ldr     r0,[r6]
        ldr     r1,[r7]
        mov     r2, #0xF500
	bl	drawColour

        ldr     r0,[r6, #4]
        ldr     r1,[r7,#4]
        mov     r2, #0xF800
	bl	drawColour

         
       
        ldr     r0, =comparelength
        ldr     r0, [r0]
        cmp     bodylength, r0
        beq     long4
        ldr   r0,=state
         ldr   r0, [r0]
         cmp    r0, #20
         blt    longg3      
         bl     door
         b      notshow2
         
longg3:
        bl      test
notshow2:
        ldr     r0, =comparelength
        ldr     r1, [r0]
        add     r1, #1
        str     r1, [r0]   
        
long4:
         
        ldr     r0, =SnakeLength
	str	bodylength, [r0] 
      
        .unreq	px
	.unreq	py
        .unreq bodylength   
	pop     {r4-r11, pc}


