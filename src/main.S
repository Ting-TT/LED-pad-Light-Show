.syntax unified
.global main

.type main, %function
main:
  nop

  @ set bits of all rows in DIR register
  @ set bit for row 1 in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =21
  bl set_bit

  @ set bit for row 2 in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =22
  bl set_bit

  @ set bit for row 3 in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =15
  bl set_bit

  @ set bit for row 4 in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =24
  bl set_bit

  @ set bit for row 5 in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =19
  bl set_bit


light_show:

@ swirl pattern
@ speed: slow -> fast -> slow
@ keep getting dimmer
  mov r7, 12 @ counter, total number of displaying this pattern
  ldr r8, =650 @ time for displaying the pattern once
  ldr r9, =600 @ brightness
  ldr r10, =0 @ dimness
swirling:
  cmp r7, 0 @ end the swirling pattern after displaying it for 12 times
  beq end_swirling
  @ display all swirl frames in one swirling loop
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl swirl_1
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl swirl_2
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl swirl_3
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl swirl_4
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl swirl_5
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl swirl_6
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl swirl_7
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl swirl_8
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl swirl_9

  @ decrese the brightness for each loop
  sub r9, 50
  add r10, 50

  @ first 5 loops of speeding up swirling
  cmp r7, 8
  ble next_half_swirling
  sub r7, 1 @ decrease the counter
  sub r8, 150 @ decrease the time for one swirling pattern
  b swirling

  @ last 7 loops of slowing down the swirling
  next_half_swirling:
  sub r7, 1 @ decrease the counter
  add r8, 70 @ in the second half, increase the time for one swirling pattern
  b swirling

end_swirling:


@ growth pattern 
@ speed: become faster every loop
  mov r7, 3 @ counter, total number of displaying this pattern
  ldr r8, =1000 @ time for displaying the pattern once
growth:
  cmp r7, 0
  beq end_growth
  @ display all patterns in one growth loop
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl dot
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl small_square
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl big_square
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl small_square
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl dot
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl small_diamond
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl big_diamond
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl small_diamond
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl dot
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl small_cross
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl big_cross
  mov r0, r8
  ldr r1, =200
  ldr r2, =50
  bl small_cross

  sub r7, 1 @ decrease the counter
  sub r8, 300 @ decrease the time for one growth pattern
  b growth

end_growth:

@ hearts pattern
@ loop over "small heart -> big heart -> two hearts together"
  mov r8, 2 @ counter, total number of displaying the loop of all hearts
heart:
  cmp r8, 0
  beq end_heart

  ldr r7, =3 @ counter, number of displaying the loop of small and big hearts
  ldr r9, =500 @ counter, number of displaying the loop of two hearts together
  seperate_hearts:
  cmp r7, 0
  beq two_hearts
  @ display small heart and big heart
  ldr r0, =1500
  ldr r1, =500
  ldr r2, =0
  bl small_heart
  ldr r0, =1500
  ldr r1, =500
  ldr r2, =0
  bl big_heart
  sub r7, 1 @ decrease the counter for small and big hearts
  b seperate_hearts

  @ display two hearts together
  two_hearts:
  cmp r9, 0
  blt end_two_hearts 
  @ set the "time" very small for each heart pattern,
  @ and loop over both pattern many times to display two hearts together
  ldr r0, =5 
  ldr r1, =500
  ldr r2, =0
  bl small_heart
  ldr r0, =5
  ldr r1, =500
  ldr r2, =0
  bl big_heart
  sub r9, 1 @ decrease the counter for two hearts together
  b two_hearts
  end_two_hearts:
  sub r8, 1 @ decrease the counter for all hearts pattern
  b heart @ back to display the loop of all hearts again

end_heart:


@ spinning arrow pattern
@ speed: become faster every loop
@ keep getting brighter
  mov r7, 7 @ counter, total number of displaying this pattern
  ldr r8, =800 @ time for displaying the pattern once
  ldr r9, =0 @ brightness
  ldr r10, =500 @ dimness
arrow:
  cmp r7, 0
  beq end_arrow
  @ display all arrow patterns in one spinning arrow loop
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl arrow_1
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl arrow_2
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl arrow_3
  mov r0, r8
  mov r1, r9
  mov r2, r10
  bl arrow_4

  sub r7, 1 @ decrease the counter
  sub r8, 100 @ decrease the time for one spinning arrow pattern
  @ increase the brightness for each loop
  add r9, 60 
  sub r10, 60
  b arrow

end_arrow:


@ circling pattern (four sides of a square is shown one by one)
@ speed: become slower every loop
@ four sides of the square all have different brightness
  mov r7, 11 @ number of circling will be looped
  ldr r8, =80 @ initial "time" for one pattern to be shown
circling:
  cmp r7, 0 @ end the circling pattern after displaying it for 11 times
  beq end_circling

  @ display the left side of a square
  mov r0, r8
  ldr r1, =800
  ldr r2, =0
  bl side_left
  @ display the up side of a square
  mov r0, r8
  ldr r1, =400
  ldr r2, =400
  bl side_top
  @ display the right side of a square
  mov r0, r8
  ldr r1, =100
  ldr r2, =700
  bl side_right
  @ display the bottom side of a square
  mov r0, r8
  ldr r1, =20
  ldr r2, =780
  bl side_bottom

  sub r7, 1 @ decrease the counter
  add r8, 30 @ increase the time for each pattern every loop
  b circling

end_circling:
  nop

@ end of displaying all different patterns
@ keep looping over the light_show to continue displaying all patterns nonstop
  b light_show




@ helping functions:


@ change the states of four lights in the memory 
@ inputs: r0, r1
@ r0: state of four lights(4th, 3rd, 2nd, 1st) in descending order
@ e.g. the states of four lights are 1010 (on, off, on, off), r0 = 0x00010001
@ r1: group number (0~6), which group are these four lights in
@ details in design document
change_four_lights:
  push {lr}
  ldr r2, =light_states
  @ calculate the correct memory address and store new states into the memory
  str r0, [r2, r1, lsl 2]
  pop {lr}
  bx lr


@ set a bit in DIR/OUT
@ input: r0: base address, r1: offset, r2: pin number
set_bit:
  push {r4, lr}
  @ load-twiddle-store
  ldr r4, [r0, r1] @ load
  mov r3, 0b1
  lsl r3, r3, r2
  orr r4, r4, r3 @ twiddle: set the specific bit(pin no.) to 1
  str r4, [r0, r1] @ store
  pop {r4, lr}
  bx lr


@ clear a bit in DIR/OUT
@ inputs: r0: base address, r1: offset, r2: pin number
clear_bit:
  push {r4, lr}
  @ load-twiddle-store
  ldr r4, [r0, r1] @ load
  mov r3, 0b1
  lsl r3, r3, r2
  bic r4, r4, r3 @ twiddle: clear the specific bit(pin no.) to 0
  str r4, [r0, r1] @ store
  pop {r4, lr}
  bx lr


@ delay code
@ input: r0: dalay "time" (counter), number of times to go over the loop
delay:
  push {lr}
delay_loop:
  cmp r0, 0
  beq delay_finish @ end the delay_loop when counter is zero
  sub r0, 1 @ decrease the counter
  b delay_loop
delay_finish:
  pop {lr}
  bx lr


@ keep looping over a pattern for some time
@ inputs: r0, r1, r2
@ r0: counter, how many times to loop over the pattern
@ r0 will control the time for this pattern to be on
@ r1: delay time when the lights are on in every column
@ r1 will control the brightness of the pattern (brighter as r1 get larger)
@ r2: delay time when the lights are off in every column
@ r2 will control the brightness of the pattern (dimmer as r2 get larger)
loop_over_pattern:
  push {r5-r11, lr}
  mov r9, r0 @ store the counter in r9
  mov r10, r1 @ store the delay time after turn on the column lights in r10
  mov r11, r2 @ store the delay time after turn off the column lights in r11

  start_of_loop_over_pattern:
  mov r8, 1 @ column number
  cmp r9, 0 
  beq end_of_loop_over_pattern @ if the counter for the pattern is zero, 
                               @ stop displaying the pattern
  sub r9, 1 @ decrease the counter

  @ sound
  push {lr}
  bl audio_init
  pop {lr}
  mov r5, 0
  ldr r6, =0xf @ counter for sound_loop
sound_loop:
  add r5, 1 @ increment r5 which will change r0 later
  cmp r6, 0
  beq end_sound @ end the sound_loop when r6 is zero
  @ play the sound by putting an interesting value into r0
  lsr r0, r5, 10
  orr r0, 46
  mul r0, r0, r5 
  push {r5, r6}
  bl audio_play_sample
  pop {r5, r6}
  sub r6, 1 @ decrease the counter
  b sound_loop
  end_sound:
  
  @ pattern
  @ turn on and off lights in every column
  loop_over_columns: 
  @ turn on all the lights which should be on in this columns
  mov r0, r8
  bl turn_on_column
  @ delay
  mov r0, r10
  bl delay
  @ turn off all the lights in this columns
  mov r0, r8
  bl turn_off_column
  @ delay
  mov r0, r11
  bl delay

  add r8, 1 @ add column number
  cmp r8, 5
  bgt start_of_loop_over_pattern @ if all five columns are done,
                                 @ start from the 1st column again
  b loop_over_columns @ otherwise, move on to next column
  
  end_of_loop_over_pattern:
  pop {r5-r11, lr}
  bx lr


@ set bit for the given column in DIR
@ input: r0: column number
set_bit_column_DIR:
  push {lr}
  cmp r0, 1
  bne on_is_column_2
  @ input r0=1, set bit for column 1(P0.28) in DIR 
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =28
  bl set_bit
  b end_of_set_bit_column_DIR

  on_is_column_2:
  cmp r0, 2
  bne on_is_column_3
  @ input r0=2, set bit for column 2(P0.11) in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =11
  bl set_bit
  b end_of_set_bit_column_DIR

  on_is_column_3:
  cmp r0, 3
  bne on_is_column_4
  @ input r0=3, set bit for column 3(P0.31) in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =31
  bl set_bit
  b end_of_set_bit_column_DIR

  on_is_column_4:
  cmp r0, 4
  bne on_is_column_5
  @ input r0=4, set bit for column 4(P1.05) in DIR
  ldr r0, =0x50000300
  ldr r1, =0x514
  ldr r2, =5
  bl set_bit
  b end_of_set_bit_column_DIR

  on_is_column_5:
  @ input r0=5, set bit for column 5(P0.30) in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =30
  bl set_bit

  end_of_set_bit_column_DIR:
  pop {lr}
  bx lr


@ clear bit for the given column in DIR
@ input: r0: column number
clear_bit_column_DIR:
  push {lr}
  cmp r0, 1
  bne off_is_column_2
  @ input r0=1, clear bit for column 1(P0.28) in DIR 
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =28
  bl clear_bit
  b end_of_clear_bit_column_DIR

  off_is_column_2:
  cmp r0, 2
  bne off_is_column_3
  @ input r0=2, clear bit for column 2(P0.11) in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =11
  bl clear_bit
  b end_of_clear_bit_column_DIR

  off_is_column_3:
  cmp r0, 3
  bne off_is_column_4
  @ input r0=3, clear bit for column 3(P0.31) in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =31
  bl clear_bit
  b end_of_clear_bit_column_DIR

  off_is_column_4:
  cmp r0, 4
  bne off_is_column_5
  @ input r0=4, clear bit for column 4(P1.05) in DIR
  ldr r0, =0x50000300
  ldr r1, =0x514
  ldr r2, =5
  bl clear_bit
  b end_of_clear_bit_column_DIR

  off_is_column_5:
  @ input r0=5, clear bit for column 5(P0.30) in DIR
  ldr r0, =0x50000000
  ldr r1, =0x514
  ldr r2, =30
  bl clear_bit

  end_of_clear_bit_column_DIR:
  pop {lr}
  bx lr


@ set bit for the given row in OUT
@ input: r0: row number
set_bit_row_OUT:
  push {lr}
  cmp r0, 1
  bne on_is_row_2
  @ input r0=1, set bit for row 1(P0.21) in OUT
  ldr r0, =0x50000000
  ldr r1, =0x504
  ldr r2, =21
  bl set_bit
  b end_of_set_bit_row_OUT

  on_is_row_2:
  cmp r0, 2
  bne on_is_row_3
  @ input r0=2, set bit for row 2(P0.22) in OUT
  ldr r0, =0x50000000
  ldr r1, =0x504
  ldr r2, =22
  bl set_bit
  b end_of_set_bit_row_OUT

  on_is_row_3:
  cmp r0, 3
  bne on_is_row_4
  @ input r0=3, set bit for row 3(P0.15) in OUT
  ldr r0, =0x50000000
  ldr r1, =0x504
  ldr r2, =15
  bl set_bit
  b end_of_set_bit_row_OUT

  on_is_row_4:
  cmp r0, 4
  bne on_is_row_5
  @ input r0=4, set bit for row 4(P0.24) in OUT
  ldr r0, =0x50000000
  ldr r1, =0x504
  ldr r2, =24
  bl set_bit
  b end_of_set_bit_row_OUT

  on_is_row_5:
  @ input r0=5, set bit for row 5(P0.19) in OUT
  ldr r0, =0x50000000
  ldr r1, =0x504
  ldr r2, =19
  bl set_bit

  end_of_set_bit_row_OUT:
  pop {lr}
  bx lr


@ clear bit for the given row in OUT
@ input: r0: row number
clear_bit_row_OUT:
  push {lr}
  cmp r0, 1
  bne off_is_row_2
  @ input r0=1, clear bit for row 1(P0.21) in OUT
  ldr r0, =0x50000000
  ldr r1, =0x504
  ldr r2, =21
  bl clear_bit
  b end_of_clear_bit_row_OUT

  off_is_row_2:
  cmp r0, 2
  bne off_is_row_3
  @ input r0=2, clear bit for row 2(P0.22) in OUT
  ldr r0, =0x50000000
  ldr r1, =0x504
  ldr r2, =22
  bl clear_bit
  b end_of_clear_bit_row_OUT

  off_is_row_3:
  cmp r0, 3
  bne off_is_row_4
  @ input r0=3, clear bit for row 3(P0.15) in OUT
  ldr r0, =0x50000000
  ldr r1, =0x504
  ldr r2, =15
  bl clear_bit
  b end_of_clear_bit_row_OUT

  off_is_row_4:
  cmp r0, 4
  bne off_is_row_5
  @ input r0=4, clear bit for row 4(P0.24) in OUT
  ldr r0, =0x50000000
  ldr r1, =0x504
  ldr r2, =24
  bl clear_bit
  b end_of_clear_bit_row_OUT

  off_is_row_5:
  @ input r0=5, clear bit for row 5(P0.19) in OUT
  ldr r0, =0x50000000
  ldr r1, =0x504
  ldr r2, =19
  bl clear_bit

  end_of_clear_bit_row_OUT:
  pop {lr}
  bx lr


@ read the states of a column of lights,
@ and turn on all the lights in this column with the state of 1
@ input: r0: column number
turn_on_column:
  push {r4-r6, lr}
  mov r5, r0 @ store the column number into r5
  @ set bit for this column in DIR
  bl set_bit_column_DIR
  
  @ r5 = number added to memory address, initial value is column index
  sub r5, 1
  @ r6 = row number, initial value is 1
  mov r6, 1
  ldr r4, =light_states

  check_light_state_loop:
  @ check the state of light in row n(value in r6) and this column 
  ldrb r3, [r4, r5] @ load light state into r3
  cmp r3, 1 
  bne next_light @ if the state is 0, 
                 @ skip next two line to stop turning the light on
  @ if the state of this light is 1, 
  @ turn the light on by setting bit for this row in register OUT
  mov r0, r6
  bl set_bit_row_OUT

  next_light:
  cmp r6, 5 @ check if lights on all 5 rows have checked their states
  bgt end_of_turn_on_column @ end the loop after all 5 lights are checked
  @ memoery address of light on same column but next row is incresed by 5 bytes,
  @ so the number added to memory address needs to be increased by 5
  add r5, 5
  add r6, 1 @ row number ++
  b check_light_state_loop
  
  end_of_turn_on_column:
  pop {r4-r6, lr}
  bx lr


@ turn off all the lights on this column
@ input: r0: column number
turn_off_column:
  push {lr}

  @ clear bit for this column in DIR
  bl clear_bit_column_DIR

  @ clear bit for all rows in OUT
  mov r0, 1
  bl  clear_bit_row_OUT
  mov r0, 2
  bl  clear_bit_row_OUT
  mov r0, 3
  bl  clear_bit_row_OUT
  mov r0, 4
  bl  clear_bit_row_OUT
  mov r0, 5
  bl  clear_bit_row_OUT
  
  pop {lr}
  bx lr


@ all the functions below change the states of 25 lights stored in the memory
@ and then light the pattern depend on the inputs
@
@ they all have three inputs: r0, r1, r2
@ and all these inputs are working in the same way
@ r0: counter, how many times to loop over the pattern
@ r1: delay time when the lights are on in every column
@ r2: delay time when the lights are off in every column

@ display a small heart pattern, inputs: r0, r1, r2
small_heart:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form a small heart shape
  ldr r0, =0
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x01000001
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x00000101
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x00000100
  mov r1, 4
  bl change_four_lights
  ldr r0, =0
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn this small heart pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display a big heart pattern, inputs: r0, r1, r2
big_heart:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form a big heart shape
  ldr r0, =0x01000100
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x01000100
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x00010100
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x00010001
  mov r1, 4
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn this big heart pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display a dot pattern, inputs: r0, r1, r2
dot:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form a dot
  ldr r0, =0
  mov r1, 0
  bl change_four_lights
  ldr r0, =0
  mov r1, 1
  bl change_four_lights
  ldr r0, =0
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 3
  bl change_four_lights
  ldr r0, =0
  mov r1, 4
  bl change_four_lights
  ldr r0, =0
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn this dot on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display a small square pattern, inputs: r0, r1, r2
small_square:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form a small square
  ldr r0, =0
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x01010000
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x01000001
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x00000100
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x00010101
  mov r1, 4
  bl change_four_lights
  ldr r0, =0
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn this small square on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr
 
@ display a big square pattern, inputs: r0, r1, r2
big_square:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form a big square
  ldr r0, =0x01010101
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x00000101
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x00010100
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x01010000
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x01000000
  mov r1, 4
  bl change_four_lights
  ldr r0, =0x01010101
  mov r1, 5
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 6
  bl change_four_lights
  @ turn this big square on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display a small diamond pattern, inputs: r0, r1, r2
small_diamond:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form a small diamond
  ldr r0, =0
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x01000000
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x01000000
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x00000100
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x00000100
  mov r1, 4
  bl change_four_lights
  ldr r0, =0
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn this small diamond on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display a big diamond pattern, inputs: r0, r1, r2
big_diamond:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form a big diamond
  ldr r0, =0x00010000
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x00010001
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x00010001
  mov r1, 4
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn this big diamond on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display a small cross pattern, inputs: r0, r1, r2
small_cross:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form a small cross
  ldr r0, =0
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x00010001
  mov r1, 4
  bl change_four_lights
  ldr r0, =0
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn this small cross on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display a big cross pattern, inputs: r0, r1, r2 
big_cross:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form a big cross
  ldr r0, =0x1
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x00010001
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x00010001
  mov r1, 4
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 5
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 6
  bl change_four_lights
  @ turn this big cross on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display an arrow pointing top left, inputs: r0, r1, r2
arrow_1:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form the arrow pointing top left
  ldr r0, =0x00000101
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x00010100
  mov r1, 1
  bl change_four_lights
  ldr r0, =0
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 4
  bl change_four_lights
  ldr r0, =0
  mov r1, 5
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 6
  bl change_four_lights
  @ turn this arrow on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display an arrow pointing top right, inputs: r0, r1, r2
arrow_2:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form the arrow pointing top right
  ldr r0, =0x01000000
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x00000101
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 4
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn this arrow on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display an arrow pointing bottom right, inputs: r0, r1, r2
arrow_3:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form the arrow pointing bottom right
  ldr r0, =0x1
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 1
  bl change_four_lights
  ldr r0, =0
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x01010000
  mov r1, 4
  bl change_four_lights
  ldr r0, =0x01000000
  mov r1, 5
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 6
  bl change_four_lights
  @ turn this arrow on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display an arrow pointing bottom left, inputs: r0, r1, r2
arrow_4:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form the arrow pointing bottom left
  ldr r0, =0
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x01000001
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 4
  bl change_four_lights
  ldr r0, =0x00000101
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn this arrow on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the left side of a square pattern, inputs: r0, r1, r2
side_left:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form the left side
  ldr r0, =0x1
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x00000100
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x01000000
  mov r1, 3
  bl change_four_lights
  ldr r0, =0
  mov r1, 4
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn the left side on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the up side of a square pattern, inputs: r0, r1, r2
side_top:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form the up side
  ldr r0, =0x01010101
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 1
  bl change_four_lights
  ldr r0, =0
  mov r1, 2
  bl change_four_lights
  ldr r0, =0
  mov r1, 3
  bl change_four_lights
  ldr r0, =0
  mov r1, 4
  bl change_four_lights
  ldr r0, =0
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn the up side on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the right side of a square pattern, inputs: r0, r1, r2
side_right:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form the right side
  ldr r0, =0
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x00000100
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x01000000
  mov r1, 4
  bl change_four_lights
  ldr r0, =0
  mov r1, 5
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 6
  bl change_four_lights
  @ turn the right side on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the bottom side of a square pattern, inputs: r0, r1, r2
side_bottom:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form the bottom side
  ldr r0, =0
  mov r1, 0
  bl change_four_lights
  ldr r0, =0
  mov r1, 1
  bl change_four_lights
  ldr r0, =0
  mov r1, 2
  bl change_four_lights
  ldr r0, =0
  mov r1, 3
  bl change_four_lights
  ldr r0, =0
  mov r1, 4
  bl change_four_lights
  ldr r0, =0x01010101
  mov r1, 5
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 6
  bl change_four_lights
  @ turn the bottom side on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the first frame of a swirl pattern, inputs: r0, r1, r2
swirl_1:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ set lights' states in memory to form the first frame for swirl
  ldr r0, =0x01010101
  mov r1, 0
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 1
  bl change_four_lights
  ldr r0, =0
  mov r1, 2
  bl change_four_lights
  ldr r0, =0
  mov r1, 3
  bl change_four_lights
  ldr r0, =0
  mov r1, 4
  bl change_four_lights
  ldr r0, =0
  mov r1, 5
  bl change_four_lights
  ldr r0, =0
  mov r1, 6
  bl change_four_lights
  @ turn this pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the second frame of a swirl pattern, inputs: r0, r1, r2
swirl_2:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ change lights' states in memory to form the second frame for swirl
  ldr r0, =0x00000100
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x00010000
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x01000000
  mov r1, 4
  bl change_four_lights
  ldr r0, =0x1
  mov r1, 6
  bl change_four_lights
  @ turn this pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the third frame of a swirl pattern, inputs: r0, r1, r2
swirl_3:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ change lights' states in memory to form the third frame for swirl
  ldr r0, =0x01010101
  mov r1, 5
  bl change_four_lights
  @ turn this pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the fourth frame of a swirl pattern, inputs: r0, r1, r2
swirl_4:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ change lights' states in memory to form the fourth frame for swirl
  ldr r0, =0x00000101
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x00010100
  mov r1, 2
  bl change_four_lights
  ldr r0, =0x01010000
  mov r1, 3
  bl change_four_lights
  @ turn this pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the fifth frame of a swirl pattern, inputs: r0, r1, r2
swirl_5:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ change lights' states in memory to form the fifth frame for swirl
  ldr r0, =0x01010101
  mov r1, 1
  bl change_four_lights
  ldr r0, =0x00010101
  mov r1, 2
  bl change_four_lights
  @ turn this pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the sixth frame of a swirl pattern, inputs: r0, r1, r2
swirl_6:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ change lights' states in memory to form the sixth frame for swirl
  ldr r0, =0x01010100
  mov r1, 3
  bl change_four_lights
  ldr r0, =0x01010000
  mov r1, 4
  bl change_four_lights
  @ turn this pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the seventh frame of a swirl pattern, inputs: r0, r1, r2
swirl_7:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ change lights' states in memory to form the seventh frame for swirl
  ldr r0, =0x01010101
  mov r1, 4
  bl change_four_lights
  @ turn this pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the eighth frame of a swirl pattern, inputs: r0, r1, r2
swirl_8:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ change lights' states in memory to form the eighth frame for swirl
  ldr r0, =0x01010101
  mov r1, 2
  bl change_four_lights
  @ turn this pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

@ display the ninth frame of a swirl pattern, inputs: r0, r1, r2
swirl_9:
  push {r4-r6, lr}
  mov r4, r0
  mov r5, r1
  mov r6, r2
  @ change lights' states in memory to form the ninth frame for swirl
  ldr r0, =0x01010101
  mov r1, 3
  bl change_four_lights
  @ turn this pattern on
  mov r0, r4
  mov r1, r5
  mov r2, r6
  bl loop_over_pattern
  pop {r4-r6, lr}
  bx lr

.size main, .-main


.data
light_states:
.word 0, 0, 0, 0, 0, 0, 0