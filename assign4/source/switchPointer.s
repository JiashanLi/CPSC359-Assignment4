//*************************************************************************************
//
//	switch pointer between two option in the menu.
//
//*************************************************************************************

.globl	switchPointer
switchPointer:
	push	{r6-r9, lr}
	px	.req	r8
	py	.req	r9

	ldr	r0, =PointerPos
	ldr	r0, [r0]
	cmp	r0, #676
	bne	toQuit
	
	//black quit
	mov     px, #288
        mov     py, #676
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
	
	//set start
setPtoS:
	mov	px, #288
	mov	py, #576
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
	ldr	r0, =PointerPos
	mov	r1,	#576
	str	r1, [r0]
	pop	{r6-r9, pc}






toQuit:
	//black start
	mov     px, #288
        mov     py, #576
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
	mov	py, #676
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
	ldr	r0, =PointerPos
	mov	r1,	#676
	str	r1, [r0]
	
	.unreq	px
	.unreq	py
	pop	{r6-r9, pc}

