#!/bin/bash
#getPCT.sh
# pipe the output of a log stats csv file (9 columns) to get Percentage of Success, Error, Timeout and Functional errors
awk '
BEGIN { FS="," ;  
        OFS=","; 
        print "Date", " Hour", " MLI", " Description", " Total", " Success", " Error", " Timeout", " Functional", "|", "PCT-Success", "PCT-Error", "PCT-Timeout", "PCT-Functional"
        }
        { 
        FS="," ;
        if ( $1=="Date " )
                { #skip header 
                }
        else
                {
                #avoid division by zero
                if ($5==0)
                        { print $0, "|", 0, 0, 0, 0 }
                else
                        { print $0, "|", $6/$5*100, $7/$5*100, $8/$5*100, $9/$5*100 } 
                }
        }
' | column -s "," -t
exit 0
