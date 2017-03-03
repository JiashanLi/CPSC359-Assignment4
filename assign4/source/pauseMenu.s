//*************************************************************************************
//
//	Being called when players press start in the game.
//
//*************************************************************************************


.globl pauseMenu
pauseMenu:
	push	{r4-r8, lr}
	px	.req	r7
	py	.req	r8
//**********************************************************************************
//		BACKGROUND
//**********************************************************************************
        mov      px, #32
        mov      py, #192
pauseBGYL:
        cmp      py, #576
        bge      donePauseBGYL

pauseBGXL: 
        cmp      px, #988
        bge      donePauseBGXL

        mov     r0, px
        mov     r1, py	    
        mov	r2,#0x0000
	bl	DrawPixel
	add	px, #1
        b       pauseBGXL

donePauseBGXL:
	mov		px, #32
	add		py, #1
	b		pauseBGYL
   
donePauseBGYL:
	
//**********************************************************************************
//		BORDER
//**********************************************************************************

        mov      px, #32
        mov      py, #192
pauseBYL:
        cmp      py, #576
        bge      donePauseBYL

pauseBXL: 
        cmp	px, #992
        bge	donePauseBXL		
        mov	r0, px
        mov	r1, py	    
        mov	r2,#0x9F
	bl	DrawPixel

	cmp	py, #194
	ble	skip
	
	mov	r0, #576
	sub	r0, #2
	
	cmp	py, r0
	bge	skip
	
	mov	r0, #992
	sub	r0, #3
	add	px, r0
        b       pauseBXL

skip:
	add	px, #1
	b	pauseBXL

donePauseBXL:
	mov		px, #32
	add		py, #1
	b		pauseBYL
   
donePauseBYL:

//**********************************************************************************
//		RESTART GAME MENU
//**********************************************************************************
	mov	px, #352
	mov	py, #276
	ldr	r6, =restart
	mov     r4, #0
        mov     r5, #0
pauseRVL:
        cmp     r5, #64
        bge     donePauseRVL

pauseRHL:     
        cmp     r4, #352
        bge     donePauseRHL
        add     r0, r4, px
        add     r1, r5, py
	ldrh	r2, [r6]
	bl	DrawPixel			
        add     r4, #1
	add     r6, #2
        b       pauseRHL
donePauseRHL:
        add             r5, #1
	mov		r4, #0
        b               pauseRVL

donePauseRVL:

//**********************************************************************************
//		QUIT GAME MENU
//**********************************************************************************
	mov	px, #352
	mov	py, #376
	ldr	r6, =quit
	mov     r4, #0
        mov     r5, #0
pauseQVL:
        cmp     r5, #64
        bge     donePauseQVL

pauseQHL:     
        cmp     r4, #288
        bge     donePauseQHL
        add     r0, r4, px
        add     r1, r5, py
	ldrh	r2, [r6]
	bl	DrawPixel			
        add     r4, #1
	add     r6, #2
        b       pauseQHL
donePauseQHL:
        add             r5, #1
	mov		r4, #0
        b               pauseQVL

donePauseQVL:
	ldr	r0, =PointerPosP
	mov	r1, #376
	str	r1, [r0]
	bl	switch
getInput:
	ldr	r0, =number
	ldr	r0, [r0]
	bl	Wait

	cmp	r0, #8
	beq	check
	cmp	r0, #3
	beq	currentGame

	cmp	r0, #4
	bleq	switch
	cmp	r0, #5
	bleq	switch

	b	getInput

check:
	ldr	r0, =PointerPosP
	ldr	r0, [r0]
	cmp	r0, #376
	beq	initGame
	cmp	r0, #276
	beq	reset
reset:
	ldr r1, =state
	mov r0, #4
	str r0, [r1, #8]
	b	start1
	pop	{r4-r8, pc}

//**********************************************************************************
//		POINTER
//**********************************************************************************
.globl	switch
switch:
	push	{r4-r8, lr}
	px	.req	r7
	py	.req	r8

	ldr	r0, =PointerPosP
	ldr	r0, [r0]
	cmp	r0, #376
	bne	toQuit
	
	//black quit
	mov     px, #288
        mov     py, #376
	mov     r4, #0
        mov     r5, #0
	
clearVQL:
        cmp     r5, #64
        bge     setPtoS

clearHQL:     
        cmp     r4, #64
        bge     doneCHQL
	add     r0, r4, px
        add     r1, r5, py
	mov	r2, #0x0000
	bl	DrawPixel			
        add     r4, #1
        b       clearHQL
doneCHQL:
        add             r5, #1
	mov		r4, #0
        b               clearVQL
	
	//set restart
setPtoS:
	mov	px, #288
	mov	py, #276
	ldr	r6, =pointer
	mov     r4, #0
        mov     r5, #0
pointerVSL:
        cmp     r5, #64
        bge     donePVSL

pointerHSL:     
        cmp     r4, #64
        bge     donePHSL
        add     r0, r4, px
        add     r1, r5, py
	ldrh	r2, [r6]
	bl	DrawPixel			
        add     r4, #1
	add     r6, #2
        b       pointerHSL
donePHSL:
        add             r5, #1
	mov		r4, #0
        b               pointerVSL

donePVSL:
	ldr	r0, =PointerPosP
	mov	r1,	#276
	str	r1, [r0]
	pop	{r4-r8, pc}






toQuit:
	//black restart
	mov     px, #288
        mov     py, #276
	mov     r4, #0
        mov     r5, #0
clearVSL:
        cmp     r5, #64
        bge     setPtoQ

clearHSL:     
        cmp     r4, #64
        bge     doneCHSL
	add     r0, r4, px
        add     r1, r5, py
	mov	r2, #0x0000
	bl	DrawPixel			
        add     r4, #1
        b       clearHSL
doneCHSL:
        add             r5, #1
	mov		r4, #0
        b               clearVSL
	
	//set quit
setPtoQ:
	mov	px, #288
	mov	py, #376
	ldr	r6, =pointer
	mov     r4, #0
        mov     r5, #0
pointerVQL:
        cmp     r5, #64
        bge     donePVQL

pointerHQL:     
        cmp     r4, #64
        bge     donePHQL
        add     r0, r4, px
        add     r1, r5, py
	ldrh	r2, [r6]
	bl	DrawPixel			
        add     r4, #1
	add     r6, #2
        b       pointerHQL
donePHQL:
        add             r5, #1
	mov		r4, #0
        b               pointerVQL

donePVQL:
	ldr	r0, =PointerPosP
	mov	r1,	#376
	str	r1, [r0]

	.unreq	px
	.unreq	py
	pop	{r4-r8, pc}













currentGame:
	bl	InitBackGround
	bl	InitWall
	bl	showscore

	// draw apple
	ldr	r0,=randomNumber
	add	r0, #4
	ldr	r1, [r0]
	ldr	r0,=randomNumber
	ldr	r0, [r0]
	ldr	r2, =apple
	bl	drawCell
	
	//draw snake
        ldr	r4, =Buffer
	ldr	r5, =ABuffer
        ldr     r0,[r4]
        ldr     r1,[r5]
        mov     r2, #0xF500
	bl	drawColour

	mov	r6, #0 //loop counter
snakeBody:
	ldr	r0, =SnakeLength
	ldr	r0, [r0]
	cmp	r0, r6
	beq	doneBody

        ldr     r0,[r4, #4]
        ldr     r1,[r5,#4]
        mov     r2, #0xF800
	bl	drawColour
	
	add	r4, #4
	add	r5, #4
	add	r6, #1
	b	snakeBody

doneBody:	
	ldr	r0, =number
	ldr	r0, [r0]
	bl	Wait
	
//        bl	readInput
	cmp	r0, #3
	beq	pauseMenu
	cmp	r0, #4
	beq	Up
	cmp	r0, #5
	beq	Down
	cmp	r0, #6
	beq	Left
	cmp	r0, #7
	beq	Right
	b	doneBody
