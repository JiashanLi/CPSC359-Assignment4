//*************************************************************************************
//
//	show the score on the top of the screen to follow the change of the screen.
//
//*************************************************************************************






.globl showscore
showscore:
         push	{r4-r10, lr}
  
        ldr	r1, =state
	ldr	r0, [r1]
        cmp     r0, #0
        beq     zero
        cmp     r0, #1
	beq	one
        cmp     r0, #2
	beq	two
        cmp     r0, #3
	beq	three
        cmp     r0, #4
	beq	four
        cmp     r0, #5
	beq	five
        cmp     r0, #6
	beq	six
        cmp     r0, #7
	beq	seven
        cmp     r0, #8
	beq	eight
        cmp     r0, #9
	beq	nine
        cmp     r0, #10
	beq	ten
        cmp     r0, #11
        beq	eleven
        cmp     r0, #12
	beq	twelve
        cmp     r0, #13
	beq	thirteen
        cmp     r0, #14
	beq	fourteen
        cmp     r0, #15
	beq	fifteen
        cmp     r0, #16
	beq	sixteen
        cmp     r0, #17
	beq	seventeen
        cmp     r0, #18
	beq	eighteen
        cmp     r0, #19
	beq	nineteen
        cmp     r0, #20
	beq	twenty
        b       endscore
zero:
	mov	r0, #'0'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
        b       endscore


one:
	mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
        b       endscore

two:
	mov	r0, #'2'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
        b       endscore

three:
	mov	r0, #'3'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
        b       endscore


four:
	mov	r0, #'4'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
        b       endscore

five:
	mov	r0, #'5'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
        b       endscore

six:
	mov	r0, #'6'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
        b       endscore

seven:
	mov	r0, #'7'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
        b       endscore
eight:
	mov	r0, #'8'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
        b       endscore
nine:
	mov	r0, #'9'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
        b       endscore

ten:
        mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'0'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore

eleven:
        mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'1'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore

twelve:
        mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'2'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore
           
thirteen:
        mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'3'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore

fourteen:
        mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'4'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore

fifteen:
        mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'5'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore

sixteen:
        mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'6'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore

seventeen:
        mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'7'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore

eighteen:
        mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'8'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore

nineteen:
        mov	r0, #'1'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'9'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore

twenty:
        mov	r0, #'2'
	mov	r1, #448
	mov	r2, #100
        bl	drawChar
 
        mov	r0, #'0'
	mov	r1, #456
	mov	r2, #100
        bl	drawChar
        b       endscore


endscore:
        pop     {r4-r10, pc}

