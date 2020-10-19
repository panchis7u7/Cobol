000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. BaseDeDatos.
000300 AUTHOR. Sebastian Madrigal.
       DATE-WRITTEN. Oct 19 2020.
       DATE-COMPILED. Oct 19 2020.

000400 ENVIRONMENT DIVISION.
000500 CONFIGURATION SECTION.
       SOURCE-COMPUTER. PC LINUX.
       OBJECT-COMPUTER. PC LINUX.

000600 SPECIAL-NAMES.

000900 INPUT-OUTPUT SECTION.
001000 FILE-CONTROL.
      *    SELECT CustomerFile ASSIGN TO "Cusomer.dat" ORGANIZATION IS LINE 
      *    SEQUENTIAL.
      *    ACCESSO ALEATORIO EN VEZ DE SEQUENCIAL.
           SELECT CustomerFile ASSIGN TO "customer.txt" 
           ORGANIZATION IS INDEXED 
           ACCESS MODE IS RANDOM 
           RECORD KEY IS IDNum.

001100 DATA DIVISION.
001200 FILE SECTION.
001300     FD CustomerFile.
           01 CustomerData.
               02 IDNum PIC 99.
               02 FirstName PIC X(15).
               02 LastName PIC X(15).
           
001700 WORKING-STORAGE SECTION.
001800 01 Choice PIC 9.
       01 StayOpen PIC X VALUE 'Y'.
       01 CustExists PIC X.

001900 PROCEDURE DIVISION.
       StartPara.
           OPEN I-O CustomerFile.
           PERFORM UNTIL StayOpen = 'N'
               DISPLAY " "
               DISPLAY "---- Consumidores ----"
               DISPLAY "1: Anadir Cliente."
               DISPLAY "2: Eliminar Cliente."
               DISPLAY "3: Actualizar Cliente."
               DISPLAY "4: Buscar Cliente."
               DISPLAY "0: Salir."
               DISPLAY "----------------------"
               DISPLAY "Opcion: " WITH NO ADVANCING
               ACCEPT Choice
               EVALUATE Choice
                   WHEN 1 PERFORM AddCust
                   WHEN 2 PERFORM DeleteCust
                   WHEN 3 PERFORM UpdateCust
                   WHEN 4 PERFORM GetCust
                   WHEN OTHER MOVE 'N' TO StayOpen
               END-EVALUATE
           END-PERFORM.
           CLOSE CustomerFile.
           STOP RUN.

       AddCust.
           CALL 'SYSTEM' USING 'clear'
           DISPLAY " "
           DISPLAY "Ingrese id: " WITH NO ADVANCING.
           ACCEPT IDNum.
           DISPLAY "Ingrese el nombre: " WITH NO ADVANCING.
           ACCEPT FirstName.
           DISPLAY "Ingrese los apellidos: " WITH NO ADVANCING.
           ACCEPT LastName.
           DISPLAY " "
           WRITE CustomerData
               INVALID KEY DISPLAY "ID tomado."
           END-WRITE.

       DeleteCust. 
           CALL 'SYSTEM' USING 'clear'
           DISPLAY " "
           DISPLAY "Ingrese el ID para eliminar: " WITH NO ADVANCING.
           ACCEPT IDNum.
           DELETE CustomerFile
               INVALID KEY DISPLAY "Llave no existe!"
           END-DELETE.
          
       UpdateCust.
           CALL 'SYSTEM' USING 'clear'
           MOVE 'Y' TO CustExists.
           DISPLAY " "
           DISPLAY "Ingrese ID que se quiere actualizar: " WITH NO 
           ADVANCING.
           ACCEPT IDNum.
           READ CustomerFile 
               INVALID KEY MOVE 'N' TO CustExists
           END-READ
           IF CustExists = 'N'
               DISPLAY "El cliente no existe."
           ELSE
               DISPLAY "Ingrese el nombre: " WITH NO ADVANCING
               ACCEPT FirstName
               DISPLAY "Ingrese los apellidos: " WITH NO ADVANCING
               ACCEPT LastName
           END-IF.
           REWRITE CustomerData 
               INVALID KEY DISPLAY "Cliente no actualizado."
           END-REWRITE.

       GetCust.
           CALL 'SYSTEM' USING 'clear'
           MOVE 'Y' TO CustExists.
           DISPLAY " "
           DISPLAY "Ingrese el ID del cliente a encontrar: " WITH NO 
           ADVANCING.
           ACCEPT IDNum.
           READ CustomerFile
               INVALID KEY MOVE 'N' TO CustExists
           END-READ
           IF CustExists = 'N'
               DISPLAY "El cliente no existe."
           ELSE 
               DISPLAY " "
               DISPLAY "------ Resultado -----"
               DISPLAY "ID: " IDNum
               DISPLAY "Nombre: " FirstName
               DISPLAY "Apellidos: " LastName 
               DISPLAY "----------------------"
               DISPLAY " "
           END-IF.
