---
title: "Design Proposal"
author: Ting Tang
email: u7228238@anu.edu.au
---

<!-- write your design proposal here -->

First part of my light show will display constantly changing irregular patterns. 
To set an LED on, use “load-twiddle-store pattern”. 
To get an irregular pattern, I will set some LEDs on at random locations by 
generating random numbers for port and pin numbers. 
I will set all LEDs to be off for a randomly amount of time after each pattern. 
This can be achieved by running “delay” code for a random number of loops. 
And then it will loop over for displaying another random pattern and 
turn off all LEDs. 
This part will be round 10 seconds.

I will display a birthday message for the second part by showing 4 numbers and 4 letters one by one. Each pattern will be achieved by setting specific LEDs on 
for roughly 2 seconds.

For the third part, it will display a constantly changing heart pattern for 
around 10 seconds. 
The heart is bouncing up and down by changing between two patterns, and I will 
use a loop around two patterns to keep displaying the same bouncing heart. 
The upper heart pattern will glow brighter by leaving it on longer. 
The heart will also bounce synchronised with the speaker.
 