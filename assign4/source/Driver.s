//Created by:	Taylor Stemp	10066205
//				Jiashan Li		10171607	
//				Xinkai Huang	10104662
//Modified by:
//				Xinkai Huang	10104662
.section	.init
/*.globl	InitController

InitController:
	b	main
 */
.section	.text

.globl	InitController
InitController:
	push	{r4, lr}

	mov	r0, #9                  //Initialize latch
	mov	r1, #1
	bl	Init_GPIO
	
	mov	r0, #11                 //Initialize clock
	mov	r1, #1
	bl	Init_GPIO

	mov	r0, #10                 //Initialize data
	mov	r1, #0
	bl	Init_GPIOIn
	pop	{r4, pc}
	
.globl readInput
readInput:                           //read the button we press
	push {r4-r6, lr}
	bl	Read_SNES
	mov	r6, #1
	mov	r4, #0					//loop counter
findBit:     					//check which button we have pressed
	cmp	r4, #16
	bge	noInput
	and r0, r9, r6
	cmp	r0, #0
	beq	haveInput
	lsl	r6, #1
	add	r4, #1
	b	findBit
noInput:                      //if no button was pressed, read another button
	mov r0,	#-1
	pop	{r4-r6, pc}
haveInput:
	mov	r0,	r4
	pop	{r4-r6, pc}

Init_GPIO:						// initialize particular GPIO line
	push {r4, lr}
	mov	r3, r0
	mov	r4, r1
	cmp	r3, #11
	bne	else
	ldr	r0, =0x20200004 		// address for GPFSEL1
	ldr	r1, [r0]				// copy GPFSEL1 into r1
	mov	r2, #7 					// (b0111)
	lsl	r2, #3					// index of 1st bit for pin11
	// r2 = 0 111 000
	bic	r1, r2 					// clear pin11 bits
	mov	r3 , r4 				// output function code
	lsl	r3, #3 					// r3 = 0 001 000
	orr	r1, r3 	 				// set pin11 function in r1
	str	r1, [r0] 				// write back to GPFSEL1
	pop	{r4, pc}

else:
	ldr	r0, =0x20200000 		// address for GPFSEL0
	ldr	r1, [r0]				// copy GPFSEL0 into r1
	mov	r2, #7 					// (b0111)
	lsl	r2, #27 				// index of 1st bit for pin9
	bic	r1, r2 					// clear pin9 bits
	mov	r3 , r4 				// output function code
	lsl	r3, #27 
	orr	r1, r3 					// set pin9 function in r1
	str	r1, [r0] 				// write back to GPFSEL0
	pop	{r4, pc}

Init_GPIOIn:
	push	{r4, lr}
	mov	r4, r1
	ldr	r0, =0x20200004 		// address for GPFSEL1
	ldr	r1, [r0]				// copy GPFSEL1 into r1
	mov	r2, #7 					// (b0111)
	bic	r1, r2 					// clear pin10 bits
	mov	r3 , r4 				// input function code
	orr	r1, r3 					// set pin10 function in r1
	str	r1, [r0] 				// write back to GPFSEL1
	pop	{r4, pc}
	



	
Write_Latch:                    // Write 0 or 1 to latch
	push	{lr}
	// r1 = value to write {o,1}
	mov	r0, #9 					// pin#9 = LATCH line
	ldr	r2, =0x20200000 		// base GPIO reg
	mov	r3, #1
	lsl	r3, r0 					// align bit for pin#9
	teq	r1, #0
	streq	r3, [r2, #40] 		// GPCLR0
	strne	r3, [r2, #28] 		// GPSET0
	pop	{pc} 



Write_Clock:					// Write 0 or 1 to clock
	push	{lr}
	// r1 = value to write {o,1}
	mov	r0, #11 				// pin#11 = LATCH line
	ldr	r2, =0x20200000 		// base GPIO reg
	mov	r3, #1
	lsl	r3, r0 					// align bit for pin#11
	teq	r1, #0
	streq	r3, [r2, #40]  		// GPCLR0
	strne	r3, [r2, #28]       // GPSET0
	pop	{pc}

Read_data:						// Read button
	push	{lr}
	mov	r0, #10 				// pin#10 = DATA line
	ldr	r2, =0x20200000 		// base GPIO reg
	ldr	r1, [r2, #52] 			// GPLEV0
	mov	r3, #1
	lsl	r3, r0 					// align pin10 bit
	and	r1, r3 					// mask everything else
	teq	r1, #0
	moveq	r0, #0 				// return 0
	movne	r0, #1 				// return 1
	pop	{pc}



Wait:							// Wait certain amount of time
	push	{lr}
	mov	r4, r0
	ldr	r0, =0x20003004 		// address of CLO
	ldr	r1, [r0] 				// read CLO
	add	r1, r4					// add 6 or 12 micros
waitLoop:
	ldr	r2, [r0]
	cmp	r1, r2 					// stop when CLO = r1
	bhi	waitLoop
	pop	{pc}

Read_SNES:						//Process to read the pressed button
	push	{lr}
	mov	r9, #0
	mov	r1, #1
	bl	Write_Clock				// Set clock to 1

	mov	r1, #1
	bl	Write_Latch				// Set latch to 1

	mov	r0, #12
	bl	Wait					// Wait 12 microseconds
 
	mov	r1, #0
	bl	Write_Latch				// Set latch to 0

	mov	r7, #0					// Pulseloop counter

pulseloop:						// Start pulsing to read SNES
	cmp	r7, #16
	bge	done

	mov	r0, #6
	bl	Wait					// Wait 6 microseconds

	mov	r1, #0
	bl	Write_Clock				// Set clock to 0

	mov	r0, #6
	bl	Wait					// Wait 6 microseconds

	bl	Read_data				// Read specific bit
	lsl	r0, r7
	orr	r9, r0

	mov	r1, #1
	bl	Write_Clock				// Set clock to 1

	add	r7,#1   				// Increment counter
	b	pulseloop				

done:
	pop	{pc}
    
    
	
	
Print_Message:					// Print appropriate button that was pressed
	push {lr}
	
	mov	r5, r0					// Store r0 for cmp below
	mov	r1, #33					// space for one element in the array
	mul	r1, r0					// r1 = r1 * r0
	ldr	r2, =Array				// address for the array
	
	add r0, r2, r1				// address for the element is going to print
	mov	r1, #33
	bl	WriteStringUART
	cmp	r5, #3					// Check if the user press "start"
	beq 	haltLoop$			// terminate if so
	b 	after
	
after:
	pop {pc}


haltLoop$:
	b	haltLoop$

.section	.data
number:
	.int	100000
create:
	.ascii	"\n\rCreated by: Xinkai Huang, Jiashan Li and Taylor Stemp\n" 
  
button:
	.ascii	"\n\rPlease press a button...\n"

.balign 32
Array:
	.ascii	"\n\rYou have pressed B            \n"
	.ascii	"\n\rYou have pressed Y            \n"
	.ascii	"\n\rYou have pressed Select       \n"
	.ascii	"\n\rProgram is terminating...     \n"
	.ascii	"\n\rYou have pressed Joy-pad UP   \n"
	.ascii	"\n\rYou have pressed Joy-pad DOWN \n"
	.ascii	"\n\rYou have pressed Joy-pad LEFT \n"
	.ascii	"\n\rYou have pressed Joy-pad RIGHT\n"
	.ascii	"\n\rYou have pressed A            \n"
	.ascii	"\n\rYou have pressed X            \n"
	.ascii	"\n\rYou have pressed L            \n"
	.ascii	"\n\rYou have pressed R            \n"
