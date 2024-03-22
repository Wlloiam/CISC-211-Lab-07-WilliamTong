/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global a_value,b_value
.type a_value,%gnu_unique_object
.type b_value,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
a_value:          .word     0  
b_value:           .word     0  

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    /**creating constant value**/
    .equ constant_value1, 0xffff0000
    .equ constant_value2, 0x0000ffff
    
    mov r10,r0			//storing the r0,input value from C code, in r10
    ldr r1,=constant_value1	//storing 0xffff0000 in r1
    ldr r2,=constant_value2	//storing 0x0000ffff in r2
    ANDS r5,r10,r1		//using logical operator AND to get the value of A, then update the flags
    LSR r5,16			//shifting the value in r5 to right 16 times
    BMI Negative1		//if the negative flag is set, will direct to the negative1 branch
    B Case_For_B		//if the neagtive flag is not set, will direct to the Case_For_B branch
    /**This is Negative1 branch. This is for the sign extension for A value**/
    Negative1:
	ORR r5,r5,r1		//using logical operator OR to make sign extension for A value
    /**This is Case_For_B branch. This branch will unpack the input from C code. if the value is negative, will do sign extension, otherwise, not***/
    Case_For_B:
	AND r6,r10,r2		//using logical operator AND to get the value of B
	LSL r3,r6,16		//shifting the B value to the left 16 times to check the sign value, and stored it in r3
	ADDS r3,r3,0		//adding 0 to r3, and store it in r3 to check the sign value of B
	BMI Negative2		//if the negative flag is set, will direct to the Negative2 branch
	B Storing_A_and_B	//if the negative flag is not set, will direct to the Storing_A_and_B branch
    /**This is Negative2 branch. This is for the sign extension for B value.**/
    Negative2:
	ORR r6,r6,r1		////using logical operator OR to make sign extension for B value
    /**This is Storing_A_and_B branch. it will store the A value, which is in r5, in a_value, and B value, which is in r6, in b_value.**/
    Storing_A_and_B:
	LDR r9,=a_value		//storing the memory location of a_value in r9
	STR r5,[r9]		//storing the A value in a_value
	LDR r9,=b_value		//storing the memory location of b_value in r9
	STR r6,[r9]		//storing the B value in b_value
	
	
	
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




