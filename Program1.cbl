       identification division.
       program-id. T2-02-P1.
       author. Kaifkhan Vakil.
       date-written. 2021-04-13.
      *Program Description:
      *This program will create a report file which will read the data 
      *from input file then it will display it on the report file with 
      *specific errors
       environment division.
       input-output section.
       file-control.
      *Input file position

           select in-file
           	   assign "../../../../T2-01-P1.dat"
               organization is line sequential.
      *Output file position
           select print-file
               assign "../../../../T2-01-P1.out"
               organization is line sequential.
      *
       data division.
       file section.
      *File division

       fd in-file
           data record is in-rec
           record contains 20 characters.
      *Defnining input file

       01 in-rec.
         05 in-number                  pic xxx.
         05 in-name                    pic x(10).
         05 in-shift-code              pic x.
           88 valid-shift                          value 'D', 'N'.
         05 in-job-class               pic x.
           88 valid-job-class                      value '1', '2'.
         05 in-salary                  pic 99999.
      *File division

       fd print-file
           record contains 132 characters
           data record is print-line.
      *
       01 print-line                   pic x(132).

      *Working storage section
       working-storage section.
      *Heading section
       01 ws-heading1.
         05 filler                     pic x(30)   value 
         "     Name            Errors   ".
      *               ----+----1----+----2----+----3

      *Constant for end of file
       01 ws-eof-flag                  pic x       value 'n'.

      *Detail line output section
       01 ws-detail-line.
         05 filler                     pic x(5).
         05 ws-dl-nam                  pic x(10).
         05 filler                     pic x(5).
         05 ws-dl-error1               pic x(20).
         05 filler                     pic x(5).
         05 ws-dl-error2               pic x(20).
         05 filler                     pic x(5).
         05 ws-dl-error3               pic x(20).
         05 filler                     pic x(5).
         05 filler                     pic x(37).

      *  Storing error messages
       01 ws-error-txt-cnst.
         05 ws-error-txt-1             pic x(20)   value 
         "Number Invalid".
         05 ws-error-txt-2             pic x(20)   value 
         "Shift Code Invalid".
         05 ws-error-txt-3             pic x(20)   value 
         "Job Class Invalid".
      *
       procedure division.
      *
       000-main.
      *Open the files
           open input in-file,
             output print-file.
      *Reading from the file
           read in-file
               at end
                   move 'y'            to ws-eof-flag.
      *Printing headings
           write print-line            from ws-heading1
             after advancing 2 lines.
      *Perform loop to process lines of input file
           perform 100-process-logic
             until ws-eof-flag = 'y'.
      *Closing the files.
           close in-file,
             print-file.
      *
           stop run.
      *
       100-process-logic.
      *    
           move spaces                 to ws-dl-error1.
           move spaces                 to ws-dl-error2.
           move spaces                 to ws-dl-error3.
           if in-number is not numeric 
               move ws-error-txt-1     to ws-dl-error1
           end-if.
           if not (valid-shift)
               if ws-dl-error1 is equal spaces
                   move ws-error-txt-2 to ws-dl-error1
               else
                   move ws-error-txt-2 to ws-dl-error2
               end-if
           end-if.

           if not valid-job-class 
               if ws-dl-error2 is equal spaces
                   if ws-dl-error1 is equal spaces
                       move ws-error-txt-3
                                       to ws-dl-error1
                   else
                       move ws-error-txt-3
                                       to ws-dl-error2
                   end-if
               else
                   move ws-error-txt-3 to ws-dl-error3

               end-if
           end-if.

           if(in-number is not numeric) or (not valid-shift) or (not 
           valid-job-class)
               move in-name            to ws-dl-nam
               write print-line        from ws-detail-line
                 after advancing 2 lines
           end-if.
           
      *
           read in-file
               at end
                   move 'y'            to ws-eof-flag.
      *

      
       end program T2-02-P1.
