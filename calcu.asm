;--------------- DECLARACION DE MACROS ---------
include m_cal.asm

.model small
.stack 
.data
.386

hayfuncion dd 0

v_f_mes		db 	2 dup (48), '$'
v_f_dia		db 	2 dup (48), '$'
v_f_hr		db	2 dup (48), '$'
v_f_min		db 	2 dup (48), '$'
v_f_seg		db 	2 dup (48), '$'
v_num		db 	0, '$'

;-----------------------------------------------COEFICIENTES DE LA FUNCION ORIGINAL--------------------------------------------------
coeficiente0	db 43,48,'$'
coeficiente1	db 43,48,'$' ;45 negativo
coeficiente2	db 43,48,'$'
coeficiente3	db 43,48,'$'
coeficiente4	db 43,48,'$'

num0 			dd 0
num1 			dd 0
num2 			dd 0
num3 			dd 0
num4 			dd 0

numGrafica4		dd 0
numGrafica3		dd 0
numGrafica2		dd 0
numGrafica1		dd 0
numGrafica0		dd 0

signoGrafica4   db 43
signoGrafica3   db 43
signoGrafica2   db 43
signoGrafica1   db 43
signoGrafica0   db 43

f_original      db 50 dup('$')


;------------------------------------------------COEFICIENTES DE LA DERIVADA----------------------------------------------------------

coefDerivada1	db 43,48,'$'
coefDerivada2	db 43,48,'$'
coefDerivada3	db 43,48,'$'
coefDerivada0	db 43,48,'$'

numDerivada1	dd 0
numDerivada2	dd 0
numDerivada3	dd 0
numDerivada0	dd 0


;------------------------------------------------COEFICIENTES DE LA INTEGRAL----------------------------------------------------------

coefIntegral0	db 43,48,'/',48,'$'
coefIntegral1	db 43,48,'/',48,'$'
coefIntegral2	db 43,48,'/',48,'$'
coefIntegral3	db 43,48,'/',48,'$'
coefIntegral4	db 43,48,'/',48,'$'
coefIntegral5	db 43,48,'/',48,'$'

numIntegral0	dd 0
numIntegral1	dd 0
numIntegral2	dd 0
numIntegral3	dd 0
numIntegral4	dd 0
numIntegral5	dd 0


;------------------------------------------------MENSAJES DE USO GENERAL--------------------------------------------------------------

Encabezado1  	db 10,13,'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA','$'						;39
Encabezado2  	db 10,13,'FACULTAD DE INGENIERIA','$'								;25
Encabezado3  	db 10,13,'ESCUELA DE CIENCIAS Y SISTEMAS','$'						;33
Encabezado4  	db 10,13,'ARQUITECTURA DE COMPUTADORAS Y ENSAMBLADORES 1 "A"','$'	;53
Encabezado5	 	db 10,13,'PRIMER SEMESTRE 2020','$'							     	;24
Encabezado6	 	db 10,13,'JOSE DANIEL LOPEZ GONZALEZ','$'											;13
Encabezado7	 	db 10,13,'201503836','$'
Encabezado8	 	db 10,13,'QUINTA PRACTICA','$'											;13
saltolinea 		db 10,13,'$'

menu1 			db 10,13,'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'
menu2 			db 10,13,'|%%%%%%%%%| MENU PRINCIPAL |%%%%%%%%%|','$'
menu3 			db 10,13,'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'
menu4 			db 10,13,'|%%%|  1- Ingresar Funcion f(x)  |%%%|','$'
menu5 		    db 10,13,'|%%%|  2- Funcion en Memoria     |%%%|','$'
menu6 			db 10,13,'|%%%|  3- Derivada f', 39 ,'(x)         |%%%|','$'
menu7 			db 10,13,'|%%%|  4- Integral F(x)          |%%%|','$'
menu8 			db 10,13,'|%%%|  5- Graficar Funciones     |%%%|','$'
menu9 			db 10,13,'|%%%|  6- Reporte                |%%%|','$'
menu12          db 10,13,'|%%%|  7- Modo Calculadora       |%%%|','$'
menu10 			db 10,13,'|%%%|  8- Salir                  |%%%|','$'
menu11			db 10,13,'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'


opciones2   db 10,'| > Ingrese el nombre del archivo: ##eje.arq##',0Dh,0Ah,"$"
cadena_en   db 50 dup("$")
v_f_in		db 50 dup('$')
v_ruta      db 50 dup('$')
v_buffer    db 7000 dup('$')


msjingreso0		db 10,13,'| > Coeficiente de x^0: ','$'
msjingreso1		db 10,13,'| > Coeficiente de x^1: ','$'
msjingreso2		db 10,13,'| > Coeficiente de x^2: ','$'
msjingreso3		db 10,13,'| > Coeficiente de x^3: ','$'
msjingreso4		db 10,13,'| > Coeficiente de x^4: ','$'

msjfx			db 10,13,'f(x) = ','$'
msjfpx 			db 10,13,'f', 39 ,'(x) = ','$'
msjfix			db 10,13,'F(x) = ','$'

menugraficador1 db 10,13,'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'
menugraficador2 db 10,13,'|%%%%%%%%| MENU  GRAFICADOR |%%%%%%%%|','$'
menugraficador3 db 10,13,'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'
menugraficador4 db 10,13,'|%%%|  1- Graficar Original f(x) |%%%|','$'
menugraficador5 db 10,13,'|%%%|  2- Graficar Derivada f', 39 ,'(x)|%%%|','$'
menugraficador6 db 10,13,'|%%%|  3- Graficar Integral F(x) |%%%|','$'
menugraficador7 db 10,13,'|%%%|  4- Regresar               |%%%|','$'
menugraficador8	db 10,13,'|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|','$'

msjintervaloinicial	db 10,13,'| > Ingrese el valor incial del intervalo: ','$'
msjintervalofinal	db 10,13,'| > Ingrese el valor final del intervalo: ','$'

PedirOpcion 	db 10,13,'| > Ingrese una opcion: ','$'

exito 			db 10,13,'| > El proceso ha sido exitoso','$'

msjIngresoFallido   db 10,13,'| > Ingresar un numero valido con signo +x/-x/0','$'
msjregresar		    db 10,13,'| > Precione cualquier tecla...','$'
msjNohayFuncion     db 10,13,'| > Aun no se ha ingresado una funcion f(x)','$'

msjfmfx			db 'f(x) = ','$'
msjfmx5			db 'x^5','$'
msjfmx4			db 'x^4','$'
msjfmx3			db 'x^3','$'
msjfmx2			db 'x^2','$'
msjfmx1			db 'x','$'

constanteintergral  db '+ c','$'


reportepractica5    db 10,13,'REPORTE PRACTICA NO.3','$'
reportefecha        db 10,13,'Fecha: 00/00/2020','$'
reportehora         db 10,13,'Hora: 00:00:00','$'
funcionoriginal     db 10,13,'Funcion Original','$'
funcionderivada     db 10,13,'Funcion Derivada','$'
funcionintergral    db 10,13,'Funcion Integral','$'
reporteexitoso      db 10,13,'Reporte generado!','$'


espacio		    db ' ','$'

valor 			dd 0
numx			dd 0

x  				dd 0
y 				dd 0

nombre 			db 'REPORTE.txt',0
n_f_original    db 'ORIGINAL.TXT',0
n_f_derivada    db 'DERIVADA.TXT',0
n_f_integral    db 'INTEGRAL.TXT',0
maneja   		dw     ?
err_cad db "Error al ingresar el nombre del archivo, pruebe de nuevo", "$" 

msjpruega   db  10,13,'| > Creando algoritmo...','$'

    txt_error1	db	'| ** Error: [01]',13,10
				db	'| - Error al generar archivo',10,13,'$'
	txt_error2	db	'| ** Error: [02]',13,10
				db	'| - Error al cerrar archivo',10,13,'$'
	txt_error3	db	'| ** Error: [03]',13,10
				db	'| - Error al abrir archivo',10,13,'$'
	txt_error4	db	'| ** Error: [04]',13,10
				db	'| - Error al leer archivo',10,13,'$'
	txt_error5	db	'| ** Error: [05]',13,10
				db	'| - Error al crear archivo',10,13,'$'
    txt_error35	db	'| ** Error: [35]',13,10
				db	'| - Sintaxis incorrecta, falta ["#"]',10,13,'$'
	txt_error59	db	'| ** Error: [59]',13,10
				db	'| - Falta caracter de fin de linea [";"]',10,13,'$'
    txt_error	db	'| ** Error: [00]',13,10
				db	'| - Caracter invalido dentro del archivo: ','$'
    v_error     db  '48','$'

	v_num1		dw	0
	v_num2		dw 	0
	v_total		dw 	0
	v_operador	db	0
	v_op 		dw  0
	v_sp		dw 	0

.code

.startup
main proc

LimpiarPantalla
mov hayfuncion, 0

MenuInicial:
		LimpiarPantalla             ;macro limpiar la pantalla 
		call ImprimirMenuInicial    ; llamo al menu inicial

		return:
				ImprimirCadena PedirOpcion;macro imprimir cadena y mensaje de pedir opcion 
				CapturaTeclado ;macro para capturar el teclado

				cmp al,49 ;compara lo que capturo con la opcion1
				je IngresarFuncion;si se activa la bandera lo dirige

				cmp al,50 ;compara lo que capturo con la opcion2
				je FuncionEnMemoria ;si se activa la bandera lo dirige

				cmp al,51 ;compara lo que capturo con la opcion3
				je Derivada ;si se activa la bandera lo dirige

				cmp al,52;compara lo que capturo con la opcion4
				je Integral ;si se activa la bandera lo dirige

				cmp al,53;compara lo que capturo con la opcion5
				je GraficarFunciones ;si se activa la bandera lo dirige

				cmp al,54;compara lo que capturo con la opcion6
				je Reporte ;si se activa la bandera lo dirige

				cmp al,56;compara lo que capturo con la opcion7
				je Salir ;si se activa la bandera lo dirige

				cmp al,55;compara lo que capturo con la opcion8
				je cargararchivo;si se activa la bandera lo dirige
				
				jmp MenuInicial

Rutina1:
	mov ah, 01h			;asignar al reg AX
	int 21h
	ret

guardar_cad:
  call Rutina1
  mov cadena_en[si],al	;Lo que se registro en AL se pone por partes en el arreglo
  ADD SI, 2
  cmp al,0dh			;Mira si es enter
  ja guardar_cad
  jb guardar_cad
  ret
error_cadena:
	ImprimirCadena err_cad
	mov ah, 08h			;Entrada de caracter sin salida
	int 21h				
	jmp cargararchivo				

limpiar:
	mov ah, 00h
	mov al, 03h
	int 10h
	ret

cargararchivo:
    ;=====================================
    ; Cargar archivo con funciones aritmeticas
    ;=====================================

    ImprimirCadena opciones2
    M_LIMPIAR_VAR v_f_in
    M_LIMPIAR_VAR v_ruta

    M_OBTENER_RUTA v_f_in
    M_PASS_RUTA v_f_in, v_ruta

    ;ImprimirCadena v_ruta; muestra la ruta

    M_ABRIR_ARCHIVO v_ruta, maneja
    jc et_error_abrir_archivo

	mov maneja, ax

    M_LEER_ARCHIVO maneja, v_buffer, 100
    jc et_error_leer_archivo

    ImprimirCadena v_buffer

	M_CERRAR_ARCHIVO maneja

	;===========================
	;  Calcular
	;===========================

	xor si, si 					;Registro SI
	mov v_sp, sp

	Leer_buffer:
		mov al, v_buffer[si]	;Obtener dato en v_buffer[si]

		cmp al, 32	;Espacio
		je Avanzar
		cmp al, 43 	;Suma +
		je Ingresar_pila
		cmp al, 45 	;Resta -
		je Ingresar_pila
		cmp al, 42	;Multiplicación *
		mov v_operador, 49
		je Ingresar_pila
		cmp al, 47	;División /
		mov v_operador, 49
		je Ingresar_pila
		cmp al, 59	;Fin de linea ;
		je Reducir

		;Validar Decenas
		cmp al, 48	;0 -> 0
		je Digito_decena
		cmp al, 49	;1 -> 10
		je Digito_decena
		cmp al, 50	;2 -> 20
		je Digito_decena
		cmp al, 51	;3 -> 30
		je Digito_decena
		cmp al, 52	;4 -> 40
		je Digito_decena
		cmp al, 53	;5 -> 50
		je Digito_decena
		cmp al, 54	;6 -> 60
		je Digito_decena
		cmp al, 55	;7 -> 70
		je Digito_decena
		cmp al, 56	;8 -> 80
		je Digito_decena
		cmp al, 57	;9 -> 90
		je Digito_decena
		
		jne et_error_operar	;Caracter no valido

	Digito_decena:
		sub al, 48	; Restar 48 al registro AL
		mov ah, 10	; Asignar 10
		mul al		; Multiplicar AL x AH
		mov v_num1, ax	;Guardamos el valor de la decena

		inc si
		mov al, v_buffer[si]

		;Validar Unidad
		cmp al, 48	;0 
		je Digito_unidad
		cmp al, 49	;1
		je Digito_unidad
		cmp al, 50	;2 
		je Digito_unidad
		cmp al, 51	;3
		je Digito_unidad
		cmp al, 52	;4 
		je Digito_unidad
		cmp al, 53	;5 
		je Digito_unidad
		cmp al, 54	;6 
		je Digito_unidad
		cmp al, 55	;7
		je Digito_unidad
		cmp al, 56	;8 
		je Digito_unidad
		cmp al, 57	;9
		je Digito_unidad

		jne et_error_operar	;Caracter no valido

	Digito_unidad:
		sub al, 48
		mov ah, 0
		add v_num1, ax

		;Ingresear en pila
		mov cx, v_num1
		push cx

		mov al, v_operador	;Verificamos *,/
		cmp al, 49
		je Reducir
		jne Avanzar
	
	Ingresar_pila:
		mov cl, al
		push cx					;Guardar número en pila

		jmp Avanzar	

	Reducir:
		pop cx
		mov v_num2, cx
		pop cx
		mov v_op, cx 
		pop cx 
		mov v_num1, cx

		mov ax, v_op 
		cmp al, 43
		je op_suma
		cmp al, 45
		je op_resta
		cmp al, 42
		je op_mul
		jne op_div

	op_suma:
		mov ax, v_num2
		mov cx, v_num1

		add al, cl
		push ax	

		mov v_operador, 0

		jmp Avanzar

	op_resta:
		mov ax, v_num2
		mov cx, v_num1

		add cl, al
		push cx	

		mov v_operador, 0

		jmp Avanzar

	op_mul:
		mov ax, v_num2
		mov cx, v_num1
		mov ah, cl

		mul al
		push ax	

		mov v_operador, 0

		jmp Avanzar

	op_div:
		mov cx, v_num2
		mov ax, v_num1

		div cl
		push ax	

		mov v_operador, 0

		jmp Avanzar

	Avanzar:
		inc si
		jmp Leer_buffer

	Finalizar:

		jmp auxiliarCarga
	;===========================
	;  Fin Calcular
	;===========================
	et_error_operar:
		ImprimirCadena saltolinea
        ImprimirCadena txt_error
		mov v_error, al 
        ImprimirCadena v_error
        ImprimirCadena saltolinea
        jmp auxiliarCarga

    jmp auxiliarCarga

    et_error_abrir_archivo:
        ImprimirCadena saltolinea
        ImprimirCadena txt_error3
        jmp loop_cargarArchivo
    
    et_error_leer_archivo:
        ImprimirCadena saltolinea
        ImprimirCadena txt_error4
        jmp loop_cargarArchivo

    err_falta_fin_linea:
        ImprimirCadena saltolinea
        ImprimirCadena txt_error59
        jmp loop_cargarArchivo

	err_syntaxis:
		ImprimirCadena saltolinea
		ImprimirCadena txt_error35
		jmp loop_cargarArchivo

    err_caracter_invalido:
        ImprimirCadena saltolinea
        ImprimirCadena txt_error
		mov v_error, al 
        ImprimirCadena v_error
        ImprimirCadena saltolinea
        jmp loop_cargarArchivo

	loop_cargarArchivo:
		jmp cargararchivo ;saltamos al menu inicial 

	auxiliarCarga:
		ImprimirCadena msjregresar ;para regresar al menu principal
		CapturaTeclado ;capturamos el teclado
		jmp MenuInicial ;saltamos al menu inicial 


IngresarFuncion:
	mov hayfuncion, 1
	xor si, si ; limpio el registro 
	LimpiarCoef:
		mov coeficiente4[ si ],0 ; movemos el registro
		mov coeficiente3[ si ],0 ; movemos el registro
		mov coeficiente2[ si ],0 ; movemos el registro
		mov coeficiente1[ si ],0 ; movemos el registro
		mov coeficiente0[ si ],0 ; movemos el registro 
		inc si
		cmp si, 2 ; comparamos el registro
		je con ; si es igual saltamos a la etiqueta con 
		jmp LimpiarCoef ; saltamos a la etiqueta para LimpiarCoef

		con:
            ;Solicitar coeficiente para x^4
            ;Leermos el signo o cero
			ImprimirCadena msjingreso4
			CapturaTeclado ; capturamos el teclado
			cmp al, 43 ;compara que sea un signo +
			je SaveCoeficiente4 ; si cumple lo redirigimos
			cmp al, 45 ;compara que sea un signo -
			je SaveCoeficiente4 ; si cumple lo redirigimos
			cmp al, 48 ;compara que sea un 0
			je cof40 ; se cumple se lo redirigimos
		    
            ImprimirCadena msjIngresoFallido
			jmp IngresarFuncion ;saltamos a ingresar funcion

			SaveCoeficiente4:
                ;Guardamos +,-,0
				mov coeficiente4[ 0 ], al ; movemos el coeficiente4 al registro al 
				CapturaTeclado ;capturamos le tecla

				;Leemos el numero
                cmp al, 48 ; comparamos si ingreso un 0
				je GuardarNumero4 ;saltamos a guardar el numero 
				cmp al, 49 ;comparamos si ingreso un 1
				je GuardarNumero4 ;saltamos a guardar el numero 
				cmp al, 50 ;comparamos si ingreso un 2
				je GuardarNumero4 ;saltamos a guardar el numero 
				cmp al, 51 ;comparamos si ingreso un 3
				je GuardarNumero4 ;saltamos a guardar el numero 
				cmp al, 52 ;comparamos si ingreso un 4
				je GuardarNumero4 ;saltamos a guardar el numero 
				cmp al, 53 ;comparamos si ingreso un 5
				je GuardarNumero4 ;saltamos a guardar el numero 
				cmp al, 54 ;comparamos si ingreso un 6
				je GuardarNumero4 ;saltamos a guardar el numero 
				cmp al, 55 ;comparamos si ingreso un 7 
				je GuardarNumero4 ;saltamos a guardar el numero 
				cmp al, 56 ;comparamos si ingreso un 8
				je GuardarNumero4 ;saltamos a guardar el numero 
				cmp al, 57 ;comparamos si ingreso un 9
				je GuardarNumero4 ;saltamos a guardar el numero 

				ImprimirCadena msjIngresoFallido ; si no se cumple tira mensaje de error 
				jmp IngresarFuncion ; procedemos a ingresar el numero junto si hay error

				GuardarNumero4:
                    ;guardamos el numero
					mov coeficiente4[ 1 ], al ; movemos al registro al
					sub EDX, EDX ; restamos el registro edx
					mov EAX, 0 ; movemos el registro 
					mov al, coeficiente4[ 1 ] ; movemos al registro al 
					sub EAX, 48 ; restamos al registro eax 
					mov num4, 0 ; movemos el registro 
					add num4, EAX ; sumamos al registro eax 
					jmp SaveCoeficiente3 ; saltamos a la etiqueta

					cof40:
						mov coeficiente4[ 1 ], al ; movemos el registro
						mov num4, 0 ; movemos el registrog
						jmp SaveCoeficiente3 ; saltamos 


			SaveCoeficiente3: 
				ImprimirCadena msjingreso3
				CapturaTeclado ; capturamos el teclado 
				cmp al, 43 ; comparamos si es +
				je cof3 ;si cumple saltamos a cof3
				cmp al, 45 ; compramos si es -
				je cof3 ; si cumple saltamos a cof3
				cmp al, 48 ; compramos si es 0
				je cof30 ; si cumple saltamos a cof30	

				ImprimirCadena msjIngresoFallido ; mensaje de error
				jmp SaveCoeficiente3 ; saaltamos a SaveCoeficiente3

				cof3: ; etiqueta cof3

					mov coeficiente3[ 0 ], al ; movemos  al registo al 
					CapturaTeclado ;capturamos le tecla
					cmp al, 48 ;comparamos si ingreso un 0
					je GuardarNumero3 ; si cumple saltamos a GuardarNumero3
					cmp al, 49 ;comparamos si ingreso un 0
					je GuardarNumero3 ; si cumple saltamos a GuardarNumero3
					cmp al, 50 ;comparamos si ingreso un 0
					je GuardarNumero3 ; si cumple saltamos a GuardarNumero3
					cmp al, 51 ;comparamos si ingreso un 0
					je GuardarNumero3 ; si cumple saltamos a GuardarNumero3
					cmp al, 52 ;comparamos si ingreso un 0
					je GuardarNumero3 ; si cumple saltamos a GuardarNumero3
					cmp al, 53 ;comparamos si ingreso un 0
					je GuardarNumero3 ; si cumple saltamos a GuardarNumero3
					cmp al, 54 ;comparamos si ingreso un 0
					je GuardarNumero3 ; si cumple saltamos a GuardarNumero3
					cmp al, 55 ;comparamos si ingreso un 0
					je GuardarNumero3 ; si cumple saltamos a GuardarNumero3
					cmp al, 56 ;comparamos si ingreso un 0
					je GuardarNumero3 ; si cumple saltamos a GuardarNumero3 
					cmp al, 57;comparamos si ingreso un 0 
					je GuardarNumero3; si cumple saltamos a GuardarNumero3 

					ImprimirCadena msjIngresoFallido ; si no se se cumple tira mensaje de error 
					jmp SaveCoeficiente3 ; saltamos a guardar el coeficiente 3

				GuardarNumero3: ;etiqueta GuardarNumero3

					mov coeficiente3[ 1 ], al ; movemos al registro al
					sub EDX, EDX ; restamos del registro edx
					mov EAX, 0 ; movemos 
					mov al, coeficiente3[ 1 ] ; movemos 
					sub EAX, 48 ; restamos 
					mov num3, 0 ; movemos
					add num3, EAX ; sumamos

					jmp SaveCoeficiente2 ; saltamos a SaveCoeficiente2

					cof30:
						mov coeficiente3[ 1 ], al
						mov num3, 0
						jmp SaveCoeficiente2

			SaveCoeficiente2:
				ImprimirCadena msjingreso2 ; imprimimos para el coeficiente2
				CapturaTeclado ; capturamos el teclado 
				cmp al, 43 ; comparams si es +
				je cof2 ; si cumple saltamos 
				cmp al, 45 ; compramos si es -
				je cof2 ; si cumple saltamos
				cmp al, 48 ; comparamos  si es 0
				je cof20 ; si cumple saltamos 

				ImprimirCadena msjIngresoFallido ; si no cumple mensaje de error
				jmp SaveCoeficiente2 ; saltamos a SaveCoeficiente2

				cof2: ; etiqueta cof2

					mov coeficiente2[ 0 ], al ; movemos al registro al
					CapturaTeclado ; capturamos el teclado 
					cmp al, 48 ;comparamos si ingreso un 0
					je GuardarNumero2 ; si cumple saltamos a GuardarNumero2
					cmp al, 49 ;comparamos si ingreso un 1
					je GuardarNumero2 ; si cumple saltamos a GuardarNumero2
					cmp al, 50 ;comparamos si ingreso un 2
					je GuardarNumero2 ; si cumple saltamos a GuardarNumero2
					cmp al, 51;comparamos si ingreso un 3
					je GuardarNumero2 ; si cumple saltamos a GuardarNumero2
					cmp al, 52 ;comparamos si ingreso un 4
					je GuardarNumero2 ; si cumple saltamos a GuardarNumero2
					cmp al, 53 ;comparamos si ingreso un 5
					je GuardarNumero2 ; si cumple saltamos a GuardarNumero2
					cmp al, 54 ;comparamos si ingreso un 6
					je GuardarNumero2 ; si cumple saltamos a GuardarNumero2
					cmp al, 55 ;comparamos si ingreso un 7
					je GuardarNumero2 ; si cumple saltamos a GuardarNumero2
					cmp al, 56 ;comparamos si ingreso un 8
					je GuardarNumero2 ; si cumple saltamos a GuardarNumero2
					cmp al, 57 ;comparamos si ingreso un 9
					je GuardarNumero2 ; si cumple saltamos a GuardarNumero2

					ImprimirCadena msjIngresoFallido ; si no se cumple mensaje de error 
					jmp SaveCoeficiente2 ; saltamos a SaveCoeficiente2

					GuardarNumero2: ; etiqueta GuardarNumero2 

						mov coeficiente2[ 1 ], al 
						sub EDX, EDX
						mov EAX, 0
						mov al, coeficiente2[ 1 ]
						sub EAX, 48
						mov num2, 0
						add num2, EAX

						jmp SaveCoeficiente1

					cof20:
						mov coeficiente2[ 1 ], al
						mov num2, 0
						jmp SaveCoeficiente1
						

				SaveCoeficiente1:
					ImprimirCadena msjingreso1
					CapturaTeclado
					cmp al, 43 ; comparamos que sea el +
					je cof1 ; si cumple saltamos 
					cmp al, 45 ; compramos que  sea el -
					je cof1 ; si cumple saltamos
					cmp al, 48 ; compramos que sea el 0
					je cof10 ; si cumple saltamos 

					ImprimirCadena msjIngresoFallido ; ; imprimir cadena 

					jmp SaveCoeficiente1 ; saltamos a SaveCoeficiente1

					cof1:

						mov coeficiente1[ 0 ], al ;movemos al registro al
						CapturaTeclado ; capturamos el teclado
						cmp al, 48 ; compra que sea 0
						je GuardarNumero1 ; si cumple saltamos 
						cmp al, 49 ; compra que sea 0
						je GuardarNumero1 ; si cumple saltamos 
						cmp al, 50 ; compra que sea 0
						je GuardarNumero1 ; si cumple saltamos 
						cmp al, 51 ; compra que sea 0
						je GuardarNumero1 ; si cumple saltamos 
						cmp al, 52 ; compra que sea 0
						je GuardarNumero1 ; si cumple saltamos 
						cmp al, 53 ; compra que sea 0
						je GuardarNumero1 ; si cumple saltamos 
						cmp al, 54 ; compra que sea 0
						je GuardarNumero1 ; si cumple saltamos 
						cmp al, 55 ; compra que sea 0
						je GuardarNumero1 ; si cumple saltamos 
						cmp al, 56 ; compra que sea 0
						je GuardarNumero1 ; si cumple saltamos 
						cmp al, 57 ; compra que sea 0
						je GuardarNumero1 ; si cumple saltamos 
 
						ImprimirCadena msjIngresoFallido ; imprimimos mensaje de error 

						jmp SaveCoeficiente1 ; saltamos a SaveCoeficiente1

						GuardarNumero1:				
							mov coeficiente1[ 1 ], al
							sub EDX, EDX
							mov EAX, 0
							mov al, coeficiente1[ 1 ]
							sub EAX, 48
							mov num1, 0
							add num1, EAX
							jmp SaveCoeficiente0

					cof10:
						mov coeficiente1[ 1 ], al
						mov num1, 0
						jmp SaveCoeficiente0


				SaveCoeficiente0:
					ImprimirCadena msjingreso0
					CapturaTeclado
					cmp al, 43 ; compramos que  sea +
					je cof0 ; si cumple saltamos
					cmp al, 45 ; compara que sea - 
					je cof0 ; si cumple saltamos
					cmp al, 48 ; compra que sea 0
					je cof00 ; si cumple saltamos 

					ImprimirCadena msjIngresoFallido ; mensaje de error 

					jmp SaveCoeficiente0 ; saltamos a SaveCoeficiente0

					cof0:

						mov coeficiente0[ 0 ], al
						CapturaTeclado
						cmp al, 48 ; compramos que sea 0 
						je GuardarNumero0 ; si cumple saltamos
						cmp al, 49 ; compramos que sea 1
						je GuardarNumero0 ; si cumple saltamos
						cmp al, 50 ; compramos que sea 2 
						je GuardarNumero0 ; si cumple saltamos 
						cmp al, 51 ; compramos que sea 3 
						je GuardarNumero0 ; si cumple saltamos 
						cmp al, 52 ; compramos que sea 4 
						je GuardarNumero0 ; si cumple saltamos
						cmp al, 53 ; compramos que sea 5 
						je GuardarNumero0 ; si cumple saltamos
						cmp al, 54 ; compramos que sea 6 
						je GuardarNumero0 ; si cumple saltamos
						cmp al, 55 ; compramos que sea 7 
						je GuardarNumero0 ; si cumple saltamos
						cmp al, 56 ; compramos que sea 8 
						je GuardarNumero0 ; si cumple saltamos 
						cmp al, 57 ; compramos que sea 9 
						je GuardarNumero0 ; si cumple saltamos 

						ImprimirCadena msjIngresoFallido ; mensaje de error 

						jmp SaveCoeficiente0 ; saltamos 

						GuardarNumero0:		
							mov coeficiente0[ 1 ], al
							sub EDX, EDX
							mov EAX, 0
							mov al, coeficiente0[ 1 ]
							sub EAX, 48
							mov num0, 0
							add num0, EAX
							jmp FinIngresoCoeficientes

					cof00:
						mov coeficiente0[ 1 ], al ; movemos al registro
						mov num0, 0
						jmp FinIngresoCoeficientes ; saltamos a la etiqueta FinIngresoCoeficientes

				FinIngresoCoeficientes: ; etiqueta FinIngresoCoeficientes
					ImprimirCadena exito ; imprimimos que fue exitoso
					ImprimirCadena msjregresar ; se imprime para regresar al menu 
					CapturaTeclado ; capturamos el teclado para poder regresar
					jmp MenuInicial; saltamos al menu inicial 
				jmp Salir

FuncionEnMemoria:
   
	cmp hayfuncion, 0 ;compara si hay funcion 
	je NoHayFuncion ; si no hay funcion mensaje de que no hay funcin 

    ;Mostrar funcion y generar archivo
    mov    ah, 3ch
    mov    cx, 00
    lea    dx, n_f_original
    int    21h
    jc     salir
    mov    maneja,ax

    ;Imprimir funcion	
    ImprimirCadena saltolinea ; un salto de linea 
	ImprimirCadena msjfmfx ; imprime  para la funcion 

    ; Escribir titulo en archivo
    EscribirArchivo funcionoriginal, maneja
    EscribirArchivo saltolinea, maneja 

	cmp coeficiente4[ 1 ], 48 ; comprar el coeficiente4 
	je cont3 ; si hay salta a cont3 	
	ImprimirCadena coeficiente4 ; imprime el coeficiente4
	ImprimirCadena msjfmx4 ; 
	ImprimirCadena espacio ; deja un espacio

    EscribirArchivo coeficiente4, maneja 
	EscribirArchivo msjfmx4, maneja 
	EscribirArchivo espacio, maneja

	cont3:
		cmp coeficiente3[ 1 ], 48 ; compra si hay coeficiente3 
		je cont2 ; si hay salta a cont2
		ImprimirCadena coeficiente3 ; irmprime el coeficiente3
		ImprimirCadena msjfmx3 
		ImprimirCadena espacio; deja un salto de linea 

        EscribirArchivo coeficiente3, maneja
		EscribirArchivo msjfmx3, maneja
		EscribirArchivo espacio, maneja

	cont2:; 
		cmp coeficiente2[ 1 ], 48;compara si hay coeficiente 2 
		je cont1 ; si lo hay salta a cont1
		ImprimirCadena coeficiente2 ; imprime el coeficiente2
		ImprimirCadena msjfmx2 
		ImprimirCadena espacio ; deja un salto de linea 

        EscribirArchivo coeficiente2, maneja
		EscribirArchivo msjfmx2, maneja
		EscribirArchivo espacio, maneja

	cont1: 
		cmp coeficiente1[ 1 ], 48 ; compra si hay coeficiente1
		je cont0 ; si lo hay salta a cont0
		ImprimirCadena coeficiente1 ; imprime el coeficiente1
		ImprimirCadena msjfmx1
		ImprimirCadena espacio ; deja un salto de linea 

        EscribirArchivo coeficiente1, maneja
		EscribirArchivo msjfmx1, maneja
		EscribirArchivo espacio, maneja

	cont0:				
		cmp coeficiente0[ 1 ], 48
		je return
		ImprimirCadena coeficiente0
		ImprimirCadena espacio

        EscribirArchivo coeficiente0, maneja
		EscribirArchivo espacio, maneja

        ;Cerrar archivo
        mov    ah,3eh
        mov    bx,maneja
        int    21h

		jmp return

Derivada:
	cmp hayfuncion, 0
	je NoHayFuncion
	call HacerDerivada

    ;Mostrar derivada en pantalla y archivo
    mov    ah, 3ch
    mov    cx, 00
    lea    dx, n_f_derivada
    int    21h
    jc     salir
    mov    maneja, ax
    EscribirArchivo funcionderivada, maneja
	EscribirArchivo msjfpx, maneja


	ImprimirCadena saltolinea
	ImprimirCadena msjfpx

	cmp coefDerivada3[ 1 ], 0
	je contder2
	ImprimirCadena coefDerivada3
	ImprimirCadena msjfmx3
	ImprimirCadena espacio

    EscribirArchivo coefDerivada3, maneja
	EscribirArchivo msjfmx3, maneja
	EscribirArchivo espacio, maneja

	contder2:
	    cmp coefDerivada2[ 1 ], 0
		je contder1
		ImprimirCadena coefDerivada2
		ImprimirCadena msjfmx2
		ImprimirCadena espacio

        EscribirArchivo coefDerivada2, maneja
		EscribirArchivo msjfmx2, maneja
		EscribirArchivo espacio, maneja

	contder1:
		cmp coefDerivada1[ 1 ], 0
		je contder0
		ImprimirCadena coefDerivada1
		ImprimirCadena msjfmx1
		ImprimirCadena espacio

        EscribirArchivo coefDerivada1, maneja
		EscribirArchivo msjfmx1, maneja
		EscribirArchivo espacio, maneja

	contder0:
		cmp coefDerivada0[ 1 ], 0
		je return
		ImprimirCadena coefDerivada0

        EscribirArchivo coefDerivada0, maneja
        mov ah, 3eh
        mov bx, maneja
        int 21h

        jmp return
    


	jmp Salir

Integral:
		cmp hayfuncion, 0
		je NoHayFuncion

		call HacerIntegral

        ;Crear archivo
        mov ah, 3ch
        mov cx, 00
        lea dx, n_f_integral
        int 21h
        jc salir
        mov maneja, ax
        EscribirArchivo funcionintergral, maneja
		EscribirArchivo msjfix, maneja

		ImprimirCadena saltolinea
		ImprimirCadena msjfix

		cmp coefIntegral5[ 1 ],0
		je contint4
		ImprimirCadena coefIntegral5
		ImprimirCadena msjfmx5
		ImprimirCadena espacio

        EscribirArchivo coefIntegral5, maneja
		EscribirArchivo msjfmx5, maneja
		EscribirArchivo espacio, maneja

		contint4:
		cmp coefIntegral4[ 1 ],0
		je contint3
		ImprimirCadena coefIntegral4
		ImprimirCadena msjfmx4
		ImprimirCadena espacio

        EscribirArchivo coefIntegral4, maneja
		EscribirArchivo msjfmx4, maneja
		EscribirArchivo espacio, maneja

		contint3:
		cmp coefIntegral3[ 1 ],0
		je contint2
		ImprimirCadena coefIntegral3
		ImprimirCadena msjfmx3
		ImprimirCadena espacio

        EscribirArchivo coefIntegral3, maneja
		EscribirArchivo msjfmx3, maneja
		EscribirArchivo espacio, maneja

		contint2:
		cmp coefIntegral2[ 1 ],0
		je contint1
		ImprimirCadena coefIntegral2
		ImprimirCadena msjfmx2
		ImprimirCadena espacio

        EscribirArchivo coefIntegral2, maneja
	    EscribirArchivo msjfmx2, maneja
		EscribirArchivo espacio, maneja

		contint1:
		cmp coefIntegral1[ 1 ],0
		je contint0
		ImprimirCadena coefIntegral1
		ImprimirCadena msjfmx1
		ImprimirCadena espacio

        EscribirArchivo coefIntegral1, maneja
		EscribirArchivo msjfmx1, maneja
		EscribirArchivo espacio, maneja

		contint0:
		ImprimirCadena constanteintergral
		ImprimirCadena espacio

        EscribirArchivo constanteintergral, maneja
		EscribirArchivo espacio, maneja

        mov ah, 3eh
        mov bx, maneja
        int 21h

		jmp return

GraficarFunciones:
	cmp hayfuncion, 0
	je NoHayFuncion


	retrunGraficas:
		LimpiarPantalla
		call ImprimirMenuGraficas

	MenuGraficas:
		ImprimirCadena PedirOpcion
		CapturaTeclado

		cmp al,49 
		je GraficarOriginal

		cmp al,50 
		je GraficarDerivada

		cmp al,51 
		je GraficarIntegral

		cmp al,52
		je MenuInicial

		jmp MenuGraficas

		GraficarOriginal:
			;Iniciacion de modo video  
			mov ax, 0013h  
			int 10h 

 			call DibujarEjes

 			mov numx, 100
 				

 			ValuarFuncion: ;Prueba de -25 a 25
 					;parte negativa
 					
 				Negativa:
 					mov valor, 0
 					mulx4:
 					    cmp num4, 0
 					    je mulx3

 					Elevar4:
 						mov EAX, numx
 						mov EBX, numx

 						mul EBX
 						mul EBX
 						mul EBX

 						mov EBX, num4

 						mul EBX

 						cmp coeficiente4[ 0 ], 43
 						jne sumar4

 						add valor, EAX
 						jmp mulx3

 						sumar4:
 						    sub valor, EAX



 						mulx3:
 							cmp num3, 0
							je mulx2
 							Elevar3:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX

 								mov EBX, num3

 								mul EBX

 								cmp coeficiente3[ 0 ], 43
 								jne restar3

 								sub valor, EAX
 								jmp mulx2

 								restar3:
 								add valor, EAX

 						mulx2:
 							cmp num2, 0
 							je mulx1
 							Elevar2:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX

 								mov EBX, EAX
 								mov EAX, num2

 								mul EBX

 								cmp coeficiente2[ 0 ], 43
 								jne restar2

 								add valor, EAX
 								jmp mulx1

 								restar2:
 								sub valor, EAX


 						mulx1:
 							cmp num1, 0
 							je SumarConstante

 								mov EAX, numx
 								mov EBX, num1

 								mul EBX

 								cmp coeficiente1[ 0 ], 43
 								jne sumar1

 								sub valor, EAX
 								jmp SumarConstante

 								sumar1: 

 								add valor, EAX


 						SumarConstante:
 								cmp num0, 0
 								je continuargraf

 								mov EAX, num0

 								cmp coeficiente0[ 0 ], 43
 								jne restarc

 								add valor, EAX
 								jmp continuargraf

 								restarc:
 								sub valor, EAX

 						continuargraf:
 								mov EAX,0
 								mov EBX,0
 								mov ECX,0
 								mov EDX,0

 								mov ECX, 100
 								mov EBX, numx
 								sub ECX, EBX
 								mov EAX, 1
 								mul ECX
 								mov x, EAX

 								cmp valor, 0
 								ja	grafpos		;positivo
 								jb 	grafneg		;negativo
 								je  co

 								grafpos:

 									
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp co

 								grafneg:
 									not valor
 									add valor, 1
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp co


 								co:
 								cmp y,0
 								jb	nocon
 								je gr
 								cmp y,200
 								ja nocon

 								gr:
 								add x, 60

 								pixel x, y, 15

 								nocon:

 								dec numx
 								cmp numx, 0
 								jne Negativa


 					mov numx, 1
 					mov EAX,0
 					mov EBX,0
 					mov ECX,0
 					mov EDX,0
 					Positiva:
 						mov valor, 0
 						mulx4p:
 							cmp num4, 0
 							je mulx3p

 							Elevar4p:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX
 								mul EBX

 								mov EBX, num4

 								mul EBX

 								cmp coeficiente4[ 0 ], 43
 								jne sumar4p

 								add valor, EAX
 								jmp mulx3p

 								sumar4p:
 								sub valor, EAX



 						mulx3p:
 							cmp num3, 0
							je mulx2p
 							Elevar3p:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX

 								mov EBX, num3

 								mul EBX

 								cmp coeficiente3[ 0 ], 43
 								jne restar3p

 								add valor, EAX
 								jmp mulx2p

 								restar3p:
 								sub valor, EAX

 						mulx2p:
 							cmp num2, 0
 							je mulx1p
 							Elevar2p:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX

 								mov EBX, EAX
 								mov EAX, num2

 								mul EBX

 								cmp coeficiente2[ 0 ], 43
 								jne restar2p

 								add valor, EAX
 								jmp mulx1p

 								restar2p:
 								sub valor, EAX


 						mulx1p:
 							cmp num1, 0
 							je SumarConstantep

 								mov EAX, numx
 								mov EBX, num1

 								mul EBX

 								cmp coeficiente1[ 0 ], 43
 								jne sumar1p

 								add valor, EAX
 								jmp SumarConstantep

 								sumar1p: 

 								sub valor, EAX


 						SumarConstantep:
 								cmp num0, 0
 								je continuargrafp

 								mov EAX, num0

 								cmp coeficiente0[ 0 ], 43
 								jne restarcp

 								add valor, EAX
 								jmp continuargrafp

 								restarcp:
 								sub valor, EAX

 						continuargrafp:
 								mov EAX,0
 								mov EBX,0
 								mov ECX,0
 								mov EDX,0

 								mov ECX, 100
 								mov EBX, numx
 								add ECX, EBX
 								mov EAX, 1
 								mul ECX
 								mov x, EAX

 								cmp valor, 0
 								ja	grafposp		;positivo
 								jb 	grafnegp		;negativo
 								je  cop

 								grafposp:

 									
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp cop

 								grafnegp:
 									
 									not valor
 									add valor, 1
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp cop


 								cop:
 								cmp y,0
 								jb	noconp
 								je grp
 								cmp y,200
 								ja noconp

 								grp:
 								add x, 60

 								pixel x, y, 15

 								noconp:

 								inc numx
 								cmp numx, 100
 								jne Positiva




 				auxiliar:
 				;Presiona una tecla para salir    
 				mov ah,10h    
 				int 16h  
 
 				;Regresar a modo texto  
 				mov ax,0003h    
 				int 10h 
 
 				;Salir del programa  mov ah,4ch  int 21h
				jmp retrunGraficas

			GraficarDerivada:
				call HacerDerivada
				mov ax, 0013h  
				int 10h 

 				call DibujarEjes

 				mov numx, 100
 				mov EAX,0
 				mov EBX,0
 				mov ECX,0
 				mov EDX,0

 				ValuarFuncionD: ;Prueba de -25 a 25
 					;parte negativa
 					

 					NegativaD:
 						mov valor, 0
 						
 						mulx3D:
 							cmp numDerivada3, 0
							je mulx2D
 							Elevar3D:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX

 								mov EBX, numDerivada3

 								mul EBX

 								cmp coefDerivada3[ 0 ], 43
 								jne restar3D

 								sub valor, EAX
 								jmp mulx2D

 								restar3D:
 								add valor, EAX

 						mulx2D:
 							cmp numDerivada2, 0
 							je mulx1D
 							Elevar2D:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX

 								mov EBX, EAX
 								mov EAX, numDerivada2

 								mul EBX

 								cmp coefDerivada2[ 0 ], 43
 								jne restar2D

 								add valor, EAX
 								jmp mulx1D

 								restar2D:
 								sub valor, EAX


 						mulx1D:
 							cmp numDerivada1, 0
 							je SumarConstanteD

 								mov EAX, numx
 								mov EBX, numDerivada1

 								mul EBX

 								cmp coefDerivada1[ 0 ], 43
 								jne sumar1D

 								sub valor, EAX
 								jmp SumarConstanteD

 								sumar1D: 

 								add valor, EAX


 						SumarConstanteD:
 								cmp numDerivada0, 0
 								je continuargrafD

 								mov EAX, numDerivada0

 								cmp coefDerivada0[ 0 ], 43
 								jne restarcD

 								add valor, EAX
 								jmp continuargrafD

 								restarcD:
 								sub valor, EAX

 						continuargrafD:
 								mov EAX,0
 								mov EBX,0
 								mov ECX,0
 								mov EDX,0

 								mov ECX, 100
 								mov EBX, numx
 								sub ECX, EBX
 								mov EAX, 1
 								mul ECX
 								mov x, EAX

 								cmp valor, 0
 								ja	grafposD		;positivo
 								jb 	grafnegD		;negativo
 								je  coD

 								grafposD:

 									
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp coD

 								grafnegD:
 									not valor
 									add valor, 1
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp coD


 								coD:
 								cmp y,0
 								jb	noconD
 								je grD
 								cmp y,200
 								ja noconD

 								grD:
 								add x, 60

 								pixel x, y, 15

 								noconD:

 								dec numx
 								cmp numx, 0
 								jne NegativaD


 					mov numx, 1
 					mov EAX,0
 					mov EBX,0
 					mov ECX,0
 					mov EDX,0
 					PositivaD:
 						mov valor, 0
 						
 						mulx3pD:
 							cmp numDerivada3, 0
							je mulx2pD
 							Elevar3pD:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX

 								mov EBX, numDerivada3

 								mul EBX

 								cmp coefDerivada3[ 0 ], 43
 								jne restar3pD

 								add valor, EAX
 								jmp mulx2pD

 								restar3pD:
 								sub valor, EAX

 						mulx2pD:
 							cmp numDerivada2, 0
 							je mulx1pD
 							Elevar2pD:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX

 								mov EBX, EAX
 								mov EAX, numDerivada2

 								mul EBX

 								cmp coefDerivada2[ 0 ], 43
 								jne restar2pD

 								add valor, EAX
 								jmp mulx1pD

 								restar2pD:
 								sub valor, EAX


 						mulx1pD:
 							cmp numDerivada1, 0
 							je SumarConstantepD

 								mov EAX, numx
 								mov EBX, numDerivada1

 								mul EBX

 								cmp coefDerivada1[ 0 ], 43
 								jne sumar1pD

 								add valor, EAX
 								jmp SumarConstantepD

 								sumar1pD: 

 								sub valor, EAX


 						SumarConstantepD:
 								cmp numDerivada0, 0
 								je continuargrafpD

 								mov EAX, numDerivada0

 								cmp coefDerivada0[ 0 ], 43
 								jne restarcpD

 								add valor, EAX
 								jmp continuargrafpD

 								restarcpD:
 								sub valor, EAX

 						continuargrafpD:
 								mov EAX,0
 								mov EBX,0
 								mov ECX,0
 								mov EDX,0

 								mov ECX, 100
 								mov EBX, numx
 								add ECX, EBX
 								mov EAX, 1
 								mul ECX
 								mov x, EAX

 								cmp valor, 0
 								ja	grafpospD		;positivo
 								jb 	grafnegpD		;negativo
 								je  copD

 								grafpospD:

 									
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp copD

 								grafnegpD:
 									
 									not valor
 									add valor, 1
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp copD


 								copD:
 								cmp y,0
 								jb	noconpD
 								je grpD
 								cmp y,200
 								ja noconpD

 								grpD:
 								add x, 60

 								pixel x, y, 15

 								noconpD:

 								inc numx
 								cmp numx, 100
 								jne PositivaD


 				auxiliarD:
 				;Presiona una tecla para salir    
 				mov ah,10h    
 				int 16h  
 
 				;Regresar a modo texto  
 				mov ax,0003h    
 				int 10h 

				jmp retrunGraficas

			GraficarIntegral:
                ImprimirCadena msjpruega
				jmp retrunGraficas
                 
				jmp Salir

Reporte:
    ;Obtener fecha
	mov ah, 2ah
	int 21h
	mov v_num, dh
	M_OBTENER_NUMERO v_f_mes, v_num
	mov v_num, dl
	M_OBTENER_NUMERO v_f_dia, v_num
    ;Colocar fecha reportefecha
    mov al, v_f_dia[0]
	mov reportefecha[9], al
    mov al, v_f_dia[1]
	mov reportefecha[10], al

    mov al, v_f_mes[0]
	mov reportefecha[12], al
	mov al, v_f_mes[1]
	mov reportefecha[13], al

	;Obtener hora
	mov ah, 2ch
	int 21h
	mov v_num, ch
	M_OBTENER_NUMERO v_f_hr, v_num
	mov v_num, cl 
	M_OBTENER_NUMERO v_f_min, v_num
	mov v_num, dh
	M_OBTENER_NUMERO v_f_seg, v_num
    ;Colocar hora reportehora
    mov al, v_f_hr[0]
	mov reportehora[8], al
	mov al, v_f_hr[1]
	mov reportehora[9], al

	mov al, v_f_min[0]
    mov reportehora[11], al
	mov al, v_f_min[1]
	mov reportehora[12], al

	mov al, v_f_seg[0]
	mov reportehora[14], al
	mov al, v_f_seg[1]
	mov reportehora[15], al


	cmp hayfuncion, 0 ; compara si hay funcion
	je NoHayFuncion ; salta si no hay funcion 

	mov    ax,@data
    mov    ds,ax
    mov    ah,3ch
    mov    cx,00
    lea    dx,nombre
    int    21h
    jc     salir
    mov    maneja,ax

    EscribirArchivo Encabezado1, maneja ;escribe el Encabezado1 
    EscribirArchivo Encabezado2, maneja ; escribe el Encabezado2
    EscribirArchivo Encabezado3, maneja ;escribe el Encabezado3
    EscribirArchivo Encabezado4, maneja ; escribe el Encabezado4
    EscribirArchivo Encabezado5, maneja ; escribe el Encabezado5
    EscribirArchivo Encabezado6, maneja ; escribe el Encabezado6
    EscribirArchivo Encabezado7, maneja ; escribe el Encabezado7
    ;EscribirArchivo Encabezado8, maneja ; escribe el Encabezado8

    EscribirArchivo saltolinea, maneja  ; deja un salto de linea

    EscribirArchivo reportepractica5, maneja ;escribe el nombre del trabajo

    EscribirArchivo saltolinea, maneja 
    EscribirArchivo reportefecha, maneja
    EscribirArchivo reportehora, maneja
    EscribirArchivo saltolinea, maneja
;================
    EscribirArchivo funcionoriginal, maneja ; escribe la funcion Original 

    EscribirArchivo msjfx, maneja ; escribe msjfx para las funciones

    			cmp coeficiente4[ 1 ], 48 ; compara el coeficiente4
				je cont3r ; salta a  la etiqueta cont3r
				EscribirArchivo coeficiente4, maneja ; escribe lo que se encuetra en coeficiente4
				EscribirArchivo msjfmx4, maneja ; escribe  mensaje
				EscribirArchivo espacio, maneja ; deja un espacio para seguir escribiendo

				cont3r:
				cmp coeficiente3[ 1 ], 48
				je cont2r
				EscribirArchivo coeficiente3, maneja
				EscribirArchivo msjfmx3, maneja
				EscribirArchivo espacio, maneja

				cont2r:
				cmp coeficiente2[ 1 ], 48
				je cont1r
				EscribirArchivo coeficiente2, maneja
				EscribirArchivo msjfmx2, maneja
				EscribirArchivo espacio, maneja

				cont1r:
				cmp coeficiente1[ 1 ], 48
				je cont0r
				EscribirArchivo coeficiente1, maneja
				EscribirArchivo msjfmx1, maneja
				EscribirArchivo espacio, maneja

				cont0r:				
				cmp coeficiente0[ 1 ], 48
				je repcontder
				EscribirArchivo coeficiente0, maneja
				EscribirArchivo espacio, maneja

		repcontder:

		EscribirArchivo saltolinea, maneja

		EscribirArchivo funcionderivada, maneja
		EscribirArchivo msjfpx, maneja

				call HacerDerivada

				cmp coefDerivada3[ 1 ], 0
				je contder2r
				EscribirArchivo coefDerivada3, maneja
				EscribirArchivo msjfmx3, maneja
				EscribirArchivo espacio, maneja

				contder2r:
				cmp coefDerivada2[ 1 ], 0
				je contder1r
				EscribirArchivo coefDerivada2, maneja
				EscribirArchivo msjfmx2, maneja
				EscribirArchivo espacio, maneja

				contder1r:
				cmp coefDerivada1[ 1 ], 0
				je contder0r
				EscribirArchivo coefDerivada1, maneja
				EscribirArchivo msjfmx1, maneja
				EscribirArchivo espacio, maneja

				contder0r:
				cmp coefDerivada0[ 1 ], 0
				je repcontinter
				EscribirArchivo coefDerivada0, maneja

		repcontinter:

		EscribirArchivo saltolinea, maneja

		EscribirArchivo funcionintergral, maneja
		EscribirArchivo msjfix, maneja

				call HacerIntegral

				cmp coefIntegral5[ 1 ],0
				je contint4r
				EscribirArchivo coefIntegral5, maneja
				EscribirArchivo msjfmx5, maneja
				EscribirArchivo espacio, maneja

				contint4r:
				cmp coefIntegral4[ 1 ],0
				je contint3r
				EscribirArchivo coefIntegral4, maneja
				EscribirArchivo msjfmx4, maneja
				EscribirArchivo espacio, maneja


				contint3r:
				cmp coefIntegral3[ 1 ],0
				je contint2r
				EscribirArchivo coefIntegral3, maneja
				EscribirArchivo msjfmx3, maneja
				EscribirArchivo espacio, maneja

				contint2r:
				cmp coefIntegral2[ 1 ],0
				je contint1r
				EscribirArchivo coefIntegral2, maneja
				EscribirArchivo msjfmx2, maneja
				EscribirArchivo espacio, maneja

				contint1r:
				cmp coefIntegral1[ 1 ],0
				je contint0r
				EscribirArchivo coefIntegral1, maneja
				EscribirArchivo msjfmx1, maneja
				EscribirArchivo espacio, maneja

				contint0r:
				EscribirArchivo constanteintergral, maneja
				EscribirArchivo espacio, maneja




    mov    ah,3eh
    mov    bx,maneja
    int    21h

    ImprimirCadena reporteexitoso
    CapturaTeclado
	jmp return

slinea:
		mov    cx,1

		n:
			push   cx
         	mov    ah,40h
        	mov    bx,maneja
        	mov    cx,2
         	lea    dx,saltolinea
         	int    21h
         	pop    cx
         	loop   n
		ret

Salir:
				finalizar
	
ImprimirMenuInicial:

				ImprimirCadena Encabezado1
				ImprimirCadena Encabezado2
				ImprimirCadena Encabezado3
				ImprimirCadena Encabezado4
				ImprimirCadena Encabezado5
				ImprimirCadena Encabezado6
				ImprimirCadena Encabezado7
				ImprimirCadena Encabezado8
				ImprimirCadena saltolinea
				ImprimirCadena menu1
				ImprimirCadena menu2
				ImprimirCadena menu3
				ImprimirCadena menu4
				ImprimirCadena menu5
				ImprimirCadena menu6
				ImprimirCadena menu7
				ImprimirCadena menu8
				ImprimirCadena menu9
				ImprimirCadena menu12
				ImprimirCadena menu10
				ImprimirCadena menu11
				
				ImprimirCadena saltolinea
				ret 

ImprimirMenuGraficas:
	ImprimirCadena menugraficador1
	ImprimirCadena menugraficador2
	ImprimirCadena menugraficador3
	ImprimirCadena menugraficador4
	ImprimirCadena menugraficador5
	ImprimirCadena menugraficador6
	ImprimirCadena menugraficador7
	ImprimirCadena menugraficador8
	ImprimirCadena saltolinea
	ret
;======================================
;  DERIVAR FUNCION ORIGINAL
;======================================
HacerDerivada:
		mov coefDerivada3[ 0 ],43
		mov coefDerivada2[ 0 ],43
		mov coefDerivada1[ 0 ],43
		mov coefDerivada0[ 0 ],43

		mov coefDerivada3[ 1 ],0
		mov coefDerivada2[ 1 ],0
		mov coefDerivada1[ 1 ],0
		mov coefDerivada0[ 1 ],0

		mov numDerivada3, 0
		mov numDerivada2, 0
		mov numDerivada1, 0
		mov numDerivada0, 0


		Derivar4:
			cmp num4, 0
			je Derivar3
			mov EAX, num4
			mov EBX, 4
			mul EBX

			mov numDerivada3, EAX
			add EAX, 48
			mov coefDerivada3[ 1 ], al
			mov al, coeficiente4[ 0 ]
			mov coefDerivada3[ 0 ], al

		Derivar3:
			cmp num3, 0
			je Derivar2

			mov EAX, num3
			mov EBX, 3
			mul EBX

			mov numDerivada2, EAX
			add EAX, 48
			mov coefDerivada2[ 1 ], al
			mov al, coeficiente3[ 0 ]
			mov coefDerivada2[ 0 ], al

		Derivar2:
			cmp num2, 0
			je Derivar1

			mov EAX, num2
			mov EBX, 2
			mul EBX

			mov numDerivada1, EAX
			add EAX, 48
			mov coefDerivada1[ 1 ], al
			mov al, coeficiente2[ 0 ]
			mov coefDerivada1[ 0 ], al

		Derivar1:
			cmp num1, 0
			je FinDrivacion

			mov EAX, num1
			mov EBX, 1
			mul EBX

			mov numDerivada0, EAX
			add EAX, 48
			mov coefDerivada0[ 1 ], al
			mov al, coeficiente1[ 0 ]
			mov coefDerivada0[ 0 ], al

		FinDrivacion:
			ret 

;======================================
;  INTEGRAR FUNCION ORIGINAL
;======================================
HacerIntegral:
		mov coefIntegral5[ 0 ], 43
		mov coefIntegral4[ 0 ], 43
		mov coefIntegral3[ 0 ], 43
		mov coefIntegral2[ 0 ], 43
		mov coefIntegral1[ 0 ], 43
		mov coefIntegral0[ 0 ], 43

		mov coefIntegral5[ 1 ], 0
		mov coefIntegral4[ 1 ], 0
		mov coefIntegral3[ 1 ], 0
		mov coefIntegral2[ 1 ], 0
		mov coefIntegral1[ 1 ], 0
		mov coefIntegral0[ 1 ], 0

		mov coefIntegral5[ 3 ], 0
		mov coefIntegral4[ 3 ], 0
		mov coefIntegral3[ 3 ], 0
		mov coefIntegral2[ 3 ], 0
		mov coefIntegral1[ 3 ], 0
		mov coefIntegral0[ 3 ], 0

		mov numIntegral5, 0
		mov numIntegral4, 0
		mov numIntegral3, 0
		mov numIntegral2, 0
		mov numIntegral1, 0
		mov numIntegral0, 0

		Integrar4:
			cmp num4,0
			je Integrar3

			mov al,coeficiente4[ 0 ]
			mov coefIntegral5[ 0 ], al

			mov al,coeficiente4[ 1 ]
			mov coefIntegral5[ 1 ],al
			mov coefIntegral5[ 3 ],53

		Integrar3:
			cmp num3,0
			je Integrar2

			mov al,coeficiente3[ 0 ]
			mov coefIntegral4[ 0 ], al

			mov al,coeficiente3[ 1 ]
			mov coefIntegral4[ 1 ],al
			mov coefIntegral4[ 3 ],52

		Integrar2:
			cmp num2,0
			je Integrar1

			mov al,coeficiente2[ 0 ]
			mov coefIntegral3[ 0 ], al

			mov al,coeficiente2[ 1 ]
			mov coefIntegral3[ 1 ],al
			mov coefIntegral3[ 3 ],51

		Integrar1:
			cmp num1,0
			je Integrar0

			mov al,coeficiente1[ 0 ]
			mov coefIntegral2[ 0 ], al

			mov al,coeficiente1[ 1 ]
			mov coefIntegral2[ 1 ],al
			mov coefIntegral2[ 3 ],50

		Integrar0:
			cmp num0,0
			je FinIntegracion

			mov al,coeficiente0[ 0 ]
			mov coefIntegral1[ 0 ], al

			mov al,coeficiente0[ 1 ]
			mov coefIntegral1[ 1 ],al
			mov coefIntegral1[ 3 ],49


		FinIntegracion:

		ret

;======================================
;  DIBUJAR EJES
;======================================
DibujarEjes:
	mov ecx, 0
	mov edx, 100

	ejex:
        ;pixel x, y, color
		pixel ecx, edx, 48h ;color para los ejes 
		inc ecx
		cmp ecx, 320 ; posicion inicio
		jne ejex

	mov ecx, 160
	mov edx, 0

	ejey:
		pixel ecx, edx, 48h ; color para los ejes 
		inc edx
		cmp edx, 200 ; posicion inicio
		jne ejey


 	ret
;======================================
;  nO HAY FUNCION
;======================================
NoHayFuncion:
		ImprimirCadena msjNohayFuncion
		jmp return

main endp 
end