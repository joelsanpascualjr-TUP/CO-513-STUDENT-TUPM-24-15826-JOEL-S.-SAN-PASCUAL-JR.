# CO-513-STUDENT-TUPM-24-15826-JOEL-S.-SAN-PASCUAL-JR.
Assignments Number 1 in CO 513
videos link: https://www.youtube.com/watch?v=rH5QF11dPWg
             https://www.youtube.com/watch?v=ntTUP7UAG8U
             https://www.youtube.com/watch?v=KQvAQCgNvis
             https://www.youtube.com/watch?v=kK-bQMWlpek
             https://www.youtube.com/watch?v=CTkt69jChGQ
Assignment Number 2
videos link: youtube.com/watch?v=sS3BB3Aq-qs

  In embedded systems, debouncing is essential because mechanical pushbuttons don't make clean electrical transitions they physically bounce between contact points when          pressed, creating multiple rapid on/off signals that the processor would interpret as several presses instead of one. Without debouncing, my counter would behave               erratically, toggling multiple times from a single button press and making the system unreliable for users.

  For my implementation, I used a simple yet effective software debouncing method with a delay constant of 50,000 cycles. I chose this approach because it's straightforward to   implement in assembly language and sufficiently reliable for this application. The method works by having me detect an initial button press, then wait through the delay        period to allow the mechanical bouncing to settle, and finally verify the button is still pressed before registering the input. The 50,000 cycle delay gives approximately 5-   10 milliseconds of stabilization time, which is adequate for most mechanical switches while remaining responsive enough for user interaction.

  I used software debouncing to handle button presses reliably. When I detect a button press, I wait 5-10ms for the mechanical bouncing to settle, then verify the button is      still pressed before registering the input. This ensures each physical button press counts as only one logical press.
