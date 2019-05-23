*=$0801

     BYTE $0E, $08, $0A, $00, $9E, $20, $28,  $32, $33, $30, $34, $29, $00, $00, $00

*=$0900

; ------------------------------------
; Declarations
; ------------------------------------

screen = $400

; ------------------------------------
; Main Loop
; ------------------------------------

                lda     #$00
                sta     counter                 ; Set Counter to zero

;                lda     #<screen                ; store screen bytes in the
;                sta     modify+1                ; modify variable.
;                lda     #>screen                ; This is not necessairy
;                sta     modify+2                ; but good for demonstration.
        
                                                ; Note:  It WOULD be needed if
                                                ; this code was going to be called
                                                ; multiple times.

loop            ldx     #$00                    
                lda     #$01                    ; set character to A

modify          sta     screen,x                ; draw A to the screen
                                                ; and start the modify loop
                                                ; The modify +1 and +2 is actually 
                                                ; rewriting this line!

                inx                             ; move to the next spot on the screen

                cpx     #250                    ; see if we've hit the 250th position
                bne     modify                  ; if not, go to next spot.


                                                ; NOTE:  250 is the minimum number
                                                ; needed to fill the screen, 
                                                ; because 40*25 = 1000.
                                                ;
                                                ; Smaller numbers don't break the
                                                ; code, but won't fill the screen
                                                ;
                                                ; NOTE:  I lowered it here, and bellow
                                                ; in my real code to 40, so I could just
                                                ; add a line on the monitor.
                                                          

                inc     counter                 ; add 1 to counter

                clc                             ; clear the carry
    
                lda     #250                    ; by overwriting the modify variable
                adc     modify+1                ; we change how the code operates.
                sta     modify+1                ; you can loop through correctly here,
                lda     #00                     ; because you're changing the code 
                adc     modify+2                ; stored at Modify.  The +1 and +2 
                sta     modify+2                ; are to change bytes on that line.
                                                ; those bytes happen to line up with
                                                ; the memory address to which we're 
                                                ; writing.

                                                ; Note:  on the 'adc' By clearing LDA
                                                ; and not the carry (clc)it is only 
                                                ; passing the carry on to the next 
                                                ; byte.  You probably don't need to 
                                                ; do the carry like this, and could 
                                                ; just inc the byte taken for granted
                                                ; but I can see the good practice here.

                lda     counter                 ; we know it takes 4 passes to
                cmp     #4                      ; fill the screen
                bne     loop                    ; if not #4, go back.

                rts                             ; end subroutine

counter         byte    0                       ; Create a counter variable

