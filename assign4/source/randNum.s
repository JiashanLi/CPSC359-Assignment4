//*************************************************************************************
//
//	Random number generator.
//
//*************************************************************************************


.globl randNum
randNum:
	push	{r4, lr}

	mov	r4, r1			//t = x	
	eor	r4, r4, lsl #11		//t ^= t << 11
	eor	r4, r4, lsr #8		//t ^= t >> 8

	mov	r1, r2			//x = y 
	mov	r2, r3			//y = z
	mov	r3, r0			//z = w

	eor	r0, r0, lsr #19		//w ^= w >> 19
	eor 	r0, r0, r4		//w ^= t

	and	r1, r0, #31
        mov     r0, #32
	mul     r0, r0, r1
	pop	{r4, pc}

