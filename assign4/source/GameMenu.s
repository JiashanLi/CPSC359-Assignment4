//***************************************************************************************
//
//	Draws the main menu to the game with the "Start Game" and "Quit Game" menu 
//	options.  Also, draws the indicator showing which option to be selected.
//
//***************************************************************************************

.globl GameMenu
GameMenu:
	push	{r6-r9, lr}
	px	.req	r8
	py	.req	r9
	mov	r0,#0x0000
	bl	drawBackground



	mov	px, #320
	mov	py, #64
	ldr	r6, =startmenu
	mov     r4, #0
        mov     r5, #0
verticalloop:
        cmp     r5, #448
        bge     donevertical

horizontalloop:     
        cmp     r4, #352
        bge     donehorizontal
        add     r0, r4, px
        add     r1, r5, py
	ldrh	r2, [r6]
	bl	DrawPixel			
        add     r4, #1
	add     r6, #2
        b       horizontalloop
donehorizontal:
        add             r5, #1
	mov		r4, #0
        b               verticalloop

donevertical:

//**********************************************************************************
//		START GAME
//**********************************************************************************
	mov	px, #352
	mov	py, #576
	ldr	r6, =start
	mov     r4, #0
        mov     r5, #0
vertical2loop:
        cmp     r5, #64
        bge     donevertical2

horizontal2loop:     
        cmp     r4, #288
        bge     donehorizontal2
        add     r0, r4, px
        add     r1, r5, py
	ldrh	r2, [r6]
	bl	DrawPixel			
        add     r4, #1
	add     r6, #2
        b       horizontal2loop
donehorizontal2:
        add             r5, #1
	mov		r4, #0
        b               vertical2loop

donevertical2:

//********************************************************************************
//	QUIT GAME
//********************************************************************************

	mov	px, #352
	mov	py, #676
	ldr	r6, =quit
	mov     r4, #0
        mov     r5, #0
vertical3loop:
        cmp     r5, #64
        bge     donevertical3

horizontal3loop:     
        cmp     r4, #288
        bge     donehorizontal3
        add     r0, r4, px
        add     r1, r5, py
	ldrh	r2, [r6]
	bl	DrawPixel			
        add     r4, #1
	add     r6, #2
        b       horizontal3loop
donehorizontal3:
        add             r5, #1
	mov		r4, #0
        b               vertical3loop

donevertical3:

//********************************************************************************
//		POINTER
//********************************************************************************
	ldr	r0, =PointerPos
	mov	r1, #676
	str	r1, [r0]
	bl	switchPointer
	.unreq	px
	.unreq	py

	pop	{r6-r9, pc}
