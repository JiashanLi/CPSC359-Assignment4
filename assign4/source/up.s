//**************************************************************************************************
//
//	move the snake up for one cell.
//
//**************************************************************************************************

.globl     moveUp
moveUp:
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
         sub     py, #32

         ldr    r0,=randomNumberdoor
	 ldr    r1, [r0]
         add    r0, #4
         ldr    r2,[r0]
         cmp    px, r1
         bne    checkrandom2
         cmp    py, r2         
	 bne	checkrandom2
         ldr    r1, =state
         ldr    r0, [r1,#12]
         mov    r0, #1
         str    r0, [r1, #12]
         b      checkWL
        
        
checkrandom2:
	 ldr    r0,=randomNumber
	 ldr    r1, [r0]
         add    r0, #4
         ldr    r2,[r0]
         cmp    px, r1
         bne    b3
         cmp    py, r2         
	 bne	b3
	 add	bodylength, #1
	
         ldr    r0, =state
         ldr    r1, [r0]
         add    r1, #1
         str    r1, [r0]

        mov      px, #448
        mov      py, #100
BYLoopgreenup:
        cmp      py, #115
        bge      BYDonegreenup

BXLoopgreenup: 
        cmp      px, #472
        bge      BXDonegreenup

        mov     r0, px
        mov     r1, py	    
        mov		r2,#0x4F00
	    bl		DrawPixel
	    add		px, #1
        b       BXLoopgreenup

BXDonegreenup:
		mov		px, #448
		add		py, #1
		b		BYLoopgreenup
BYDonegreenup:
          bl     showscore
         b    noRemove1
       

b3:             
        mov     r5,#4
        mul     r4, r5, bodylength
        add     r3, r6,r4
        add     r5, r7,r4   
        ldr     r0,[r3]
        ldr     r1,[r5]     
        mov     r2, #0x4F00
	bl	drawColour

noRemove1:
       mov     r11,bodylength
loopup:
        cmp     r11, #0
        ble     doneup
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
        b       loopup
doneup:      
        sub     py, #32
        str     py, [r7]       
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
        beq     long1
        ldr   r0,=state
         ldr   r0, [r0]
         cmp    r0, #20
         blt    longg2      
         bl     door
         b      notshow3
longg2:
        bl      test
notshow3:
        ldr     r0, =comparelength
        ldr     r1, [r0]
        add     r1, #1
        str     r1, [r0]  
       
long1:
          
        ldr     r0, =SnakeLength
	str	bodylength, [r0]



       
        .unreq	px
	.unreq	py
        .unreq bodylength   
	pop     {r4-r11, pc}

