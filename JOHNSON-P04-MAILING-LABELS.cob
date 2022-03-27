      ******************************************************************
      *PROGRAM : PROJECT 4   Mailing Labels                            *
      *AUTHOR  : JOHN STEPHEN JOHNSON                                                    *
      *DATE    : 02/01/2022                                            *
      *ABSTRACT: Use of UNSTRING and STRING                            *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. JOHNSON-P04-MAILING-LABELS.
      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUST-LIST  ASSIGN TO '..\p04-cust-list.csv'
                             ORGANIZATION IS LINE SEQUENTIAL.
           SELECT LABEL-FILE ASSIGN TO '..\p04-labels.txt'
                             ORGANIZATION IS LINE SEQUENTIAL.
      *-----------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.
       FD  CUST-LIST.
       01  CUST-REC                    PIC X(91).
                                       
       FD  LABEL-FILE.                  
       01  LABEL-REC                   PIC X(80).
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01  WS-CTR                      PIC 9(6)    VALUE ZERO.
       01  WS-FLAGS.
           03  WS-EOF-FLAG             PIC X       VALUE 'N'.
               88  EOF                             VALUE 'Y'.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       100-MAIN.
           OPEN INPUT  CUST-LIST.
           OPEN OUTPUT LABEL-FILE.
           
           PERFORM UNTIL EOF
               READ CUST-LIST
                   AT END
                       MOVE 'Y' TO WS-EOF-FLAG
                   NOT AT END
                       ADD 1 TO WS-CTR
                       PERFORM 200-PROCESS-RECORD
           END-PERFORM.
           
           DISPLAY SPACES.
           DISPLAY 'LABELS PRINTED: ', WS-CTR.
           CLOSE CUST-LIST
                 LABEL-FILE.
           STOP RUN.
      *-----------------------------------------------------------------
       200-PROCESS-RECORD.
           DISPLAY 'REC ', WS-CTR, ': ', CUST-REC.
      *-----------------------------------------------------------------
