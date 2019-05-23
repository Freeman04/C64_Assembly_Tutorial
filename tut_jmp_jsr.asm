; 10 SYS (2304)

*=$0801

     BYTE $0E, $08, $0A, $00, $9E, $20, $28,  $32, $33, $30, $34, $29, $00, $00, $00

*=$0900

Load    lda #$01                ; deliberately putting the same value in
LoadX   ldx #$01                ; all three registers.
LoadY   ldy #$01

Main    jsr IncY                ; these add an address to the stack
        jsr IncX        

        sta $0400
        stx $0401
        sty $0402

        cmp $0401
        bne Quit

        jmp Main

IncX    inx
        jmp IncY                ; this does not add an address to the stack
;        jsr IncY               ; Chosing whether you use jmp or jsr the following 
        inx                     ; inx and rts may not fire.  Because the return address
        rts                     ; is only added to the stack in the jsr command,
                                ; and any return will return to it, regardless of 
                                ; of where it is in code.
                                
IncY    iny
        rts

Quit    rts
