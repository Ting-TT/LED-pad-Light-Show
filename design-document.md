---
title: "COMP2300 Assignment 1 Design Document"
author: Ting Tang
email: u7228238@anu.edu.au
---

<!-- write your design document here -->
# Design Document for Light Show


## _what_ my design is
My light show **contains sounds**, and it has 5 changing patterns which will last for around 50 seconds. It keeps **repeating over these 5 changing patterns non-stop**.

**The first pattern** is a spinning swirl. Swirls speed up and then slow down while it gets dimmer.
**The second pattern** is called “growth”. A dot will be stretched out, become a square, and then drew back to the dot; then to a diamond; lastly to a cross. Its speed increases over time.
**The third pattern** is hearts. A small heart and then a big heart, they will blink three times. Then both hearts display together forming a solid heart.
**The fourth pattern** is a spinning arrow. It speeds up while getting brighter.
**The fifth pattern** is circling four sides of a square. Each side has a different brightness, and it slows down over time to connect to the first pattern smoothly.

The length of the **sound** follows with the speed of a pattern.


## _How_ have I implemented my design
 
Under `.data` , I have 7 `.words` of 0 **stored in the memory**. They represent the **states of lights, 0 for off, 1 for on**. 25 lights are divided into 7 groups, 6 groups of four lights, 1 group of last light. Each light takes 1 byte, so this takes the first 25 bytes starting from 0x20000000 in memory.
Function **`change_four_light`** stores the states for a group of lights into the memory.

I set bits for all rows in DIR register at start, and they’ll never be cleared.
**A pattern is turned on** by `loop_over_pattern` which loops over all five columns of lights one by one quickly and keep looping for some time, longer the time, longer the pattern will be displayed, lower the **speed** of the changing pattern.

**For each column,** I use `turn_on_column`, `delay`, `turn_off_column`, `delay`.

**`turn_on_column`** sets bit for this column in DIR; reads the memory of 5 lights; sets bit for their rows in OUT if their state is on, then these lights are turned on.
**`turn_off_column`** turns off all lights by clear bits for this column in DIR and all rows in OUT.
Functions for setting/clearing bits in DIR/OUT for a row/column need to `cmp` with numbers (1~5) first to find which case it is and then use **`set_bit`** or **`clear_bit`** with its corresponding port, pin and register as inputs.

**Increasing delay time after `turn_on_column`** will make the pattern **brighter**. 
**Increasing delay time after `turn_off_column`** will make the pattern **dimmer**.

Every time before looping over all five columns, I add the sound by looping for **`sound_loop`** for a very small amount of time. So **`loop_over_pattern` displays the pattern and sound at the same time**, and length of sound will change corresponding to pattern’s display time.


## _Why_ is my implementation correct and appropriate for my task

I **use memory to store states** which enables changing all lights’ states easily and turning on all lights in a column by reading the memory.

I **store the state of one light using 1 byte** because when `turn_on_column` reads the memory, 1 byte can be easily loaded and used to determine turn on this light or not.

However, since `ldr` only loads 4 bytes, so for every new pattern, I have to write 7 `change_four_light` functions to set all 25 lights’ states, which is not efficient. This can be improved by **storing every light’s state using one bit**.

**Overall, my implements can successfully turn on the lights I want to perform changing patterns. And I am able to control the speed and brightness for every pattern. It can also perform sounds.**