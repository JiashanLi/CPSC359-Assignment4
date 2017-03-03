//*************************************************************************************************
//
//	Checks the win/lost flag and draws the appropriate message when flag is set.
//
//*************************************************************************************************

.globl	checkWL
checkWL:
	ldr	r0, =state
	ldr	r0, [r0, #12]
	
	cmp	r0,#0
	beq	lose
        cmp     r0, #1
        beq     win
        b       dono

/**********		**************
		WIN
***********		**************/
win:
	px	.req	r8
	py	.req	r9
	mov	px, #96
	mov	py, #288
	ldr	r6, =showwin
	mov     r4, #0
        mov     r5, #0
winVL:
        cmp     r5, #160
        bge     doneLoseV

winHL:     
        cmp     r4, #736
        bge     doneWinH
        add     r0, r4, px
        add     r1, r5, py
	ldrh	r2, [r6]
	bl	DrawPixel			
        add     r4, #1
	add     r6, #2
        b       winHL
doneWinH:
        add             r5, #1
	mov		r4, #0
        b               winVL

/**********		**************
		LOSE
***********		**************/

lose:
	px	.req	r8
	py	.req	r9
	mov	px, #32
	mov	py, #288
	ldr	r6, =showlose
	mov     r4, #0
        mov     r5, #0
loseVL:
        cmp     r5, #128
        bge     doneLoseV

LoseHL:     
        cmp     r4, #992
        bge     doneLoseH
        add     r0, r4, px
        add     r1, r5, py
	ldrh	r2, [r6]
	bl	DrawPixel			
        add     r4, #1
	add     r6, #2
        b       LoseHL
doneLoseH:
        add             r5, #1
	mov		r4, #0
        b               loseVL

doneLoseV:
	ldr	r0,=number
	ldr	r0, [r0]
	bl	Wait

//	bl	readInput
	cmp	r0, #-1
	bne	read

	b	doneLoseV
read:
	b	initGame
dono:
