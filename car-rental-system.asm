
# Car Rental Reservation System
# 1718487 Syed Mohammed Khalid
# 1715845 Muhammad Syahmi Fathimi bin Ahmad Fauzi
# 1718485 Muhammad Farhan bin Azhar
# 1715805 Muhammad Akmal Bin Ahmad Zmari
# CSC3402 Section 1

#username user
#password 1234


.include "macros.asm"

.data
	# Cars data
	array: .word 'B', 'A', 'A', 'A', 'A', 'B', 'C', 'B', 'B', 'C', 'A', 'B', 'A', 'A', 'A', 'A', 'B', 'C', 'B', 'B'
	
	car1: .asciiz "Axia"
	car2: .asciiz "Alza"
	car3: .asciiz "Viva"
	car4: .asciiz "Kancil"
	car5: .asciiz "Saga"
	car6: .asciiz "Exora"
	car7: .asciiz "Iriz"
	car8: .asciiz "Waja"
	car9: .asciiz "Axia"
	car10: .asciiz "Alza"
	car11: .asciiz "Viva"
	car12: .asciiz "Kancil"
	car13: .asciiz "Saga"
	car14: .asciiz "Exora"
	car15: .asciiz "Iriz"
	car16: .asciiz "Waja"
	car17: .asciiz "Axia"
	car18: .asciiz "Alza"
	car19: .asciiz "Viva"
	car20: .asciiz "Kancil"
	cars: .word car1, car2, car3, car4, car5, car6, car7, car8, car9, car10, car11, car12, car13, car14, car15, car16, car17, car18, car19, car20
	
	# A - RETURNED (available for renting)
	# B - RESERVED (someone has booked the car)
	# C - COLLECTED (by someone who reserved the car)

	# Admin
	username: .asciiz "user\n"
	password: .asciiz "1234\n"
	username2: .space 6
	password2: .space 6

	loading: .asciiz "\nLoading...\n"
	errorMsg0: .asciiz "\n########\nWrong username or password"
	loginMsg0: .asciiz "================================ You have logged in! ================================\n"
	errorMsg1: .asciiz "\nWrong input"
	userMenuStr0: .asciiz "\nMenu\n1. View Car \n2. Book Car \n3. Collect Car \n4. Return Car  \n5. Logout \nChoose(1 / 2 / 3 / 4 / 5): "
	userMenuStr1: .asciiz "\nWould you like to continue? (1-Yes, 2-No)\n"
	MessageforIndicator: .asciiz "\nA - RETURNED/AVAILABLE \nB - RESERVED \nC - COLLECTED\n"
	Message1: .asciiz "\n================================ FAILED! The car has been reserved by someone else  ================================\nPlease try again \nGoing to main menu...\n"
	Message2: .asciiz "\n================================ SUCCESSFULLY RESERVED CAR!! ================================\nGoing to main menu...\n"
	Message3: .asciiz "\n================================ FAILED! The car is being rented out now ================================\nPlease try again \nGoing to main menu...\n"
	LoggingOut: .asciiz "\n================================ Logging Out ================================\n"
	opt0: .space 1
	opt1: .space 1
        
        Msg1: .asciiz "\n================================ FAILED! The car has not been reserved yet ================================\nPlease try again \nGoing to main menu...\n"
	Msg2: .asciiz "\n================================ SUCCESSFULLY COLLECTED CAR!! ================================\nGoing to main menu...\n"
	Msg3: .asciiz "\n================================ FAILED! The car is being rented out now ================================\nPlease try again \nGoing to main menu...\n"
	
	M1: .asciiz "\n================================ FAILED! The car has not been reserved yet ================================\nPlease try again \nGoing to main menu...\n"
	M2: .asciiz "\n================================ SUCCESSFULLY RETURNED CAR!! ================================\nGoing to main menu...\n"
	M3: .asciiz "\n================================ FAILED! The car has not been collected yet ================================\nPlease try again \nGoing to main menu...\n"
	
	totalCars: .word 20
	newline: .asciiz "\n"
	spaces: .asciiz "\t"

	titleStr0: .asciiz "    Car Rental Reservation System    \n"
	titleStr1: .asciiz "=====================================\n"

	initAdminStr0: .asciiz "\nAdmin Registration\n"
	initAdminStr1: .asciiz "Username (4 characters only): "
	initAdminStr2: .asciiz "Password (4 characters only): "

	displayAllCarsStr0: .asciiz "\nNo.    MODEL   AVAILABILITY"
	displayAllCarsStr1: .asciiz "\n===    =====   ============\n"

	bookCarStr0: .asciiz "\nBook Car\nEnter No.: "
	bookCarStr1: .asciiz "\n########\nOption out of range!\n"
	carNo: .word
        CollectcarStr0: .asciiz "\nCollect Car\nEnter No.: "
         ReturncarStr0: .asciiz "\nReturn Car\nEnter No.: "
        


.text
.globl main
	################################################################################
	main:
		print_str(titleStr0)
		print_str(titleStr1)

		jal adminLogin

		# display user menu
		print_str(userMenuStr0)
		li $v0, 5
		syscall
		move $t9, $v0                    # $v0 contains integer read
		beq $t9, 1, displayAllCars
		beq $t9, 2, bookCar
		beq $t9, 3, CollectCar
		beq $t9, 4, ReturnCar
		beq $t9, 5, End
		

	################################################################################
	adminLogin:
		# get inputs from user
		print_str(initAdminStr0)

		print_str(initAdminStr1)
		read_str(username2, 6)

		print_str(initAdminStr2)
		read_str(password2, 6)

		print_str(loading)

		# checking for login
		la $s4, username # load user information
		la $s5, username2

		la $s6, password # load pass information
		la $s7, password2

		la $t6, 0 #counter for loop compareUsername
		la $t7, 0 #counter for loop comparePassword

	compareUsername:
		lb $t2, 1($s4) #load first byte from user input
		lb $t3, 1($s5) #load 'username' from $s5

		addi $s4, $s4, 1
		addi $s5, $s5, 1
		addi $t6, $t6, 1

		beq $t6, 4, comparePassword
		beq $t2, $t3, compareUsername
		bne $t2, $t3, error

	comparePassword:
		lb $t2, 1($s6) #load first byte from user input
		lb $t3, 1($s7) #load 'password2' from $s7

		addi $s6, $s6, 1
		addi $s7, $s7, 1
		addi $t7, $t7, 1

		beq $t7, 4, login
		beq $t2, $t3, comparePassword
		bne $t2, $t3, error

	login:
		print_str(loginMsg0)
		jr $ra                        # return to caller

	error:
		print_str(errorMsg0)
		li $v0, 10 # end program
		syscall

	################################################################################
	displayAllCars:
		print_str(displayAllCarsStr0)
		print_str(displayAllCarsStr1)

		li $t1, 0 		# counter to loop all cars
		lw $t0, totalCars	# total all cars
		la $s0, cars		# cars array
		la $s1, array		# availability array

		addi $s0, $s0, -4
		addi $s1, $s1, -4
		loopEachCar:
			addi $t1, $t1, 1
			addi $s0, $s0, 4
			addi $s1, $s1, 4
			# print no
			li $v0, 1
			move $a0, $t1
			syscall
			print_str(spaces)
			# print model
			lw $a0, ($s0)
			li $v0, 4
			syscall
			print_str(spaces)
			# print availability
			lw $a0, ($s1)
			li $v0, 11
			syscall
			print_str(newline)
			blt $t1, 20, loopEachCar
		endLoopEachCar:
		
		print_str(MessageforIndicator)

		jr $ra                        # return to caller

	################################################################################
	bookCar:
		print_str(bookCarStr0)
		li $v0, 5
		syscall

		move $t0, $v0
		la $s1, array
		
		subi $t0, $t0, 1 # since array start from 0, we subtract input by 1
		
		li $s5, 4	 # load 4 to multiple input so that we can get the byte of the array
		li $a1, 'A'
		li $a2, 'B'
		li $a3, 'C'		
						
		mult $t0, $s5 	 # multiple by 4 byte to get the address by byte of array (access array by byte)
		mflo $t0 	 # save the result of multiplication into $t0
		
		add $s1, $s1, $t0 # add the $s1(array) with $t0(result of multiplication)
		
		# test for options
		bcTest1:
			lw $a0, ($s1)
			li $v0, 11
			syscall
			
			beq $a0, $a2, Option1 # The car has been booked by other people
			beq $a0, $a3, Option2 # The car has been return
			beq $a0, $a1, Option3 # Reserving the car
		
		Option1:
			print_str(Message1)
			jr $ra
		
		Option2:
			print_str(Message3)
			jr $ra
			
		
		Option3: # Booking success
			sw $a2, ($s1)
			print_str(Message2)
			jr $ra                        # return to caller

CollectCar:
		print_str(CollectcarStr0)
		li $v0, 5
		syscall

		move $t0, $v0
		la $s1, array
		
		subi $t0, $t0, 1 # since array start from 0, we subtract input by 1
		
		li $s5, 4	 # load 4 to multiple input so that we can get the byte of the array
		li $a1, 'A'
		li $a2, 'B'
		li $a3, 'C'		
						
		mult $t0, $s5 	 # multiple by 4 byte to get the address by byte of array (access array by byte)
		mflo $t0 	 # save the result of multiplication into $t0
		
		add $s1, $s1, $t0 # add the $s1(array) with $t0(result of multiplication)
		
		# test for options
		RTest1:
			lw $a0, ($s1)
			li $v0, 11
			syscall
			
			beq $a0, $a2, Opt1 # Collecting the car
			beq $a0, $a3, Opt2 # The car has already been collected
			beq $a0, $a1, Opt3 # The car has not been reserved yet
		
		Opt1: # Collected success
			print_str(Msg2)
		        sw $a3, ($s1)
		        jr $ra
		Opt2:
			print_str(Msg3)
			jr $ra
			
		
		Opt3: 
			
			print_str(Msg1)
			jr $ra                        # return to caller

ReturnCar:
		print_str(ReturncarStr0)
		li $v0, 5
		syscall

		move $t0, $v0
		la $s1, array
		
		subi $t0, $t0, 1 # since array start from 0, we subtract input by 1
		
		li $s5, 4	 # load 4 to multiple input so that we can get the byte of the array
		li $a1, 'A'
		li $a2, 'B'
		li $a3, 'C'		
						
		mult $t0, $s5 	 # multiple by 4 byte to get the address by byte of array (access array by byte)
		mflo $t0 	 # save the result of multiplication into $t0
		
		add $s1, $s1, $t0 # add the $s1(array) with $t0(result of multiplication)
		
		# test for options
		CTest1:
			lw $a0, ($s1)
			li $v0, 11
			syscall
			
			beq $a0, $a2, ROpt1 # The car has not been collected yet so return not possible
			beq $a0, $a3, ROpt2 # Returning the car 
			beq $a0, $a1, ROpt3 # The has not been booked yet so return is not possible
		
		ROpt1:
			print_str(M3)
		        jr $ra
		ROpt2:  # Return success
			print_str(M2)
			 sw $a1, ($s1)
			jr $ra
			
		
		ROpt3: 
			
			print_str(M1)
			jr $ra                        # return to caller


	End: #Logging out / End of program
		print_str(LoggingOut)
		li $v0, 10 # end program
		syscall
