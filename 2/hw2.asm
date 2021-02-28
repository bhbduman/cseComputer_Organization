.data
#int arraySize = MAX_SIZE;
arraySize: 	.word 0
#int arr[MAX_SIZE];
arr: 		.space 400
#int num;
num: 		.word 0
#int returnVal;
returnVal: 	.word 0

#int returnVal1=0, returnVal2=0;
returnVal1:	.word 0
returnVal2:	.word 0


possible: 	.asciiz "Possible!"
impossible:	.asciiz "Not Possible"
newline: 	.asciiz "\n"
space: 		.asciiz " "
bspace: 	.asciiz "\b"
allelements:	.asciiz "Summation of all array elements provides the given value"
smaller:		.asciiz "The Summation given array is smaller than the value"


.text
main:
	#cin >> arraySize;
	li $v0, 5
	syscall
	sw  $v0,arraySize
	
	#cin >> num;
	li $v0, 5
	syscall
	sw  $v0,num
	
	#for (int i = 0; i < arraySize; i++){
	and $s0, $s0, $zero
	lw  $t0, arraySize
	li $s1,0
fill:	
	beq $s0,$t0,next	
    	#cin >> arr[i];
	li $v0, 5
	syscall
	add $t9,$t9,$v0
	
	sw   $v0, arr($s1)
	add  $s1,$s1,4
	addi $s0,$s0,1
	j fill	
next:	
	la $a0,newline
	li $v0, 4
	syscall
	lw $t8,num
	#if equal to num it wont go to recursive call it will print sum of array is equal to given value
	beq $t9,$t8,equaltosum
	#if sum of array element less than given input it wont go to recursive call it only print the sum of array smaller than num
	blt $t9,$t8,lessthannum 
	#CheckSumPossibility(num, arr, arraySize);
	lw $a0, num
	lw $a2, arraySize
	addi $a1,$a2,-1#indexlast
	jal isPossible

	
	move $a0, $v0
	beq $a0,1,possiblejump
	#cout << "Not possible" << endl;
	la $a0,impossible
back:	
	li $v0, 4
	syscall
	
	
	j halt#exit
	
equaltosum:
	la $a0,allelements
	li $v0, 4
	syscall
	
	#cout << "Possible!" <<endl;
possiblejump: la $a0,possible
	j back	
lessthannum:
	la $a0,smaller
	li $v0, 4
	syscall
	j back
	


	
    	#int CheckSumPossibility(int num, int arr[], int size){
isPossible:
    	#int returnVal1=0, returnVal2=0;
	sw $zero,returnVal2
	sw $zero,returnVal1
	
    	#if (num == 0){
	bnez $a0,continue
	
	#cout<<",";
	la $a0,newline
	li $v0, 4
	syscall
	
	#   return 1;
	li  $v0,1
	jr $ra

continue:
	#if(size < 0 || num <0){
   	sle $t1,$a2,$zero
    	slt  $t2,$a0,$zero
    	or $t3,$t2,$t1
    	beqz $t3,continue2
    	#return 0;
    	li $v0,0
    	jr $ra
continue2:
	sub $sp, $sp, 16
	sw $ra, 0($sp)
	
    	#if(CheckSumPossibility( num-arr[size-1], arr, size-1)){
    	sw $a0, 4($sp)#num
  	sw $a2, 8($sp)#arraysize
  	sub $a2,$a2,1#size-1
  	sll  $t4, $a2,2
  	lw $t5,arr($t4)#arr[size-1]
  	sub $a0, $a0,$t5#num-arr[size-1]
  	
  	jal isPossible
  	#returnVal1= 1;
    	sw $v0, 12($sp)#save return(first call)
    	
	
	beq $v0, 1,print
    	j donotprint
print:
    	#cout<<arr[size-1]<<" ";
	lw $a2, 8($sp)
	sub $t6,$a2,1
	sll  $t4, $t6,2
	lw $a0,arr($t4)
	li $v0, 1
	syscall
	
	
	la $a0,newline
	li $v0, 4
	syscall
donotprint: 

    	
  	
  	lw $a0, 4($sp)# restorenum
  	lw $a2, 8($sp)#restore arraysize
  	
  	
  	 
  	#if(CheckSumPossibility(num, arr, size-1)){
    	sub $a2,$a2,1#size-1
    	jal isPossible 

    
	#returnVal1= 1;
    	lw $s0, 12($sp) #restore first recursive
    
   

  	
  	#return returnVal1 || returnVal2;
  	or $v0,$s0 ,$v0
  	
	lw $ra,0($sp)
	add $sp, $sp, 16
	jr $ra


halt:	
	li $v0, 10 # syscall code 10 is for exit.
	syscall
	
	
