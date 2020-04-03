;--------------- DECLARACION DE MACROS ---------
;=== Macro - Limpiar pantalla ===
LimpiarPantalla macro 																					
	mov ah,0    ;Establecer modo Video
	mov al,3h   ;Resolucion de 80x25 16 colores texto
	int 10h
endm
;=== Fin Macro ===

;=== Macro - Imprimir cadena ===
ImprimirCadena macro cadena	
	mov dx, offset cadena ;mandamos el texto que esta de entrada en la macro
	mov ah, 09;mandamos el hexadecimal 09h al registro ah para lanzar la interrupcion
	int 21h
endm
;=== Fin Macro ===

;=== Macro - Finalizar programa ===
finalizar macro
	mov ax, 4c00h ; numero de funcion para finalizar el programa
	int 21h
endm
;=== Fin Macro ===

;=== Macro - Capturar letra ===
CapturaTeclado macro
	mov ah, 01h     ;mandamos el hexadecimal 01h al registro ah para lanzar la interrupcion
	int 21h
endm
;=== Fin Macro ===

;=== Macro - Pintar pixel ===
;pintar pixel grafico 
pixel macro x, y, color  
	mov ecx, x ; movemos el registro
	mov edx, y ; movemos el registo
	mov ah, 0ch   ; mandamos el exadecimal 0ch al registro ah para lanzar la interrupcion
	mov al, color
	int 10h
endm 
;=== Fin Macro ===

EscribirArchivo macro cadena, man
	LOCAL tamanocadena
	LOCAL escr
	LOCAL nuevo

	xor si, si ;limpia el valor del registro
	inc si
	tamanocadena:
			cmp cadena[ si ],36
			je escr
			inc si
			jmp tamanocadena

	escr:
			mov    cx,1
	nuevo:   
			push   cx ;guarda el registro cx en el stack
         	mov    ah,40h ; lo que va a guardar
        	mov    bx,man
        	mov    cx,si
         	lea    dx,cadena ; lo que va a escribir
         	int    21h
         	pop    cx ;saco el registro que tenia guardado
         	loop   nuevo
endm

;=== Macro - Abrir archivo
M_ABRIR_ARCHIVO macro nombre, handle
    xor ax, ax
    mov ah, 3dh             ;Funcion Abrir Archivo
    mov al, 00h             ;Modo de Escritura
    lea dx, nombre
    ;mov dx, offset nombre   ;Nombre del archivo a abrir
    int 21h
   
    ;mov handle, ax

endm
;=== Fin Macro ===

;=== Macro - Cerrar archivo
M_CERRAR_ARCHIVO macro handle
    xor ax, ax
    mov ah, 3eh
    mov bx, handle
    int 21h

endm
;=== Fin Macro ===


;=== Macro - Leer archivo
M_LEER_ARCHIVO macro handle, buffer, num
    xor ax, ax
    mov ah, 3fh
    mov bx, handle
    mov cx, num
    mov dx, offset buffer
    int 21h
    
endm
;=== Fin Macro ===



;=== Macro - Obtener fecha
M_OBTENER_NUMERO macro numero, x
    mov al, x
    aam 
    add al, 48
    mov numero[1], al
    
    mov al, ah
    aam
    add al, 48
    mov numero[0], al
endm
;=== Fin Macro

;=== Macro - Obtener ruta
M_OBTENER_RUTA macro buffer
local et_obtener_char, et_salir
    xor si, si              ;Limpiar Registro SI 
    et_obtener_char:
        mov ah, 01h         ;Funcion de lectura
        int 21h

        cmp al,13           ;Comparamos CR = 13
        je et_salir
        mov buffer[si], al  ;Insertar caracter en vector
        inc si              ;SI + 1
        jmp et_obtener_char

    et_salir:
        mov al, 0           ;Insertar NULL = 0
        mov buffer[si], al  ;Insertar fin de lectura
endm
;=== Fin Macro ===


;=== Macro - Obtener ruta
M_PASS_RUTA macro txt, ruta
local ciclo, fin_lectura, salir
    xor si, si
    xor bx, bx
    
        mov al, txt[si]
        cmp al, 35          ;Comparamos # = 35
        jne err_syntaxis

        inc si              ;SI ++
        
        mov al, txt[si]     ;Comprarmos # = 35
        cmp al, 35
        jne err_syntaxis

        inc si              ;SI ++

        ciclo:
            mov al, txt[si]
            cmp al, 35      ;Comparamos # = 35
            je fin_lectura
            cmp al, 0       ;Comparamos NULL = 0
            je err_caracter_invalido
            cmp al, 36      ;Comparamos $ = 36
            je err_caracter_invalido

            mov ruta[bx], al;Mover el caracter a ruta[]
            inc bx
            inc si
            jmp ciclo

        fin_lectura:
            mov al, 0       ;Insertar NULL = 0
            mov ruta[bx], al;Insertar fin de lectura

            inc si          ;SI ++

            mov al, txt[si]
            cmp al, 35      ;Comparamos # = 35
            jne err_syntaxis

            inc si          ;SI++

            mov al, txt[si] 
            cmp al, 0       ;Comparamos NULL = 0
            je salir
            jne err_syntaxis
            cmp al, 36      ;Comparamos $ = 36
            je salir
            jne err_syntaxis
    
    salir:
endm
;=== Fin Macro ===

;=== Macro - Obtener ruta
M_LIMPIAR_VAR macro var
local ciclo, salir
    xor si, si
    ciclo:
        mov var[si], 36
        cmp si, 48
        je salir

        inc si
        jmp ciclo
    
    salir:
endm
;=== Fin Macro ===