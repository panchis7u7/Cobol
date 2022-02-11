       *> ------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Prueba.
       AUTHOR. Carlos Sebastian Madrigal Rodriguez.
       INSTALLATION. GNU Cobol.
       DATE-WRITTEN. Feb 9 2022 (09/02/22).
       DATE-COMPILED. Feb 9 2022 (09/02/22).
       SECURITY. Non-Confidential.

       *> ------------------------------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. x64-Based-Linux-Kernel.
       OBJECT-COMPUTER. x64-Based-Linux-Kernel.
       SPECIAL-NAMES.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PruebaFile ASSIGN TO "prueba.txt"
           ORGANIZATION IS SEQUENTIAL.

       *> ------------------------------------------
       DATA DIVISION.
       FILE SECTION.
       FD PruebaFile.
       01 inputRecord.
           05 IDRec PIC 99.
           05 nombre PIC X(25).

       WORKING-STORAGE SECTION.
       01 VAR PIC 99.

       *> ------------------------------------------
       PROCEDURE DIVISION.
       MAIN-PROC.
           COMPUTE VAR = 6 / 3 END-COMPUTE.
           DISPLAY "Hola Mundo desde COBOL. El resultado de la "
           "computacion es: ", VAR
           END-DISPLAY.
           GOBACK.
       END PROGRAM Prueba.
