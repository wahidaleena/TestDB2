       IDENTIFICATION DIVISION.
       PROGRAM-ID.    TESTDB2.
      *SECURITY.      OPERACTION, REVISION, AND DISTRIBUTION
      *            OF THIS PROGRAM BY WRITTEN AUTHORIZATION
      *            OF THE ABOVE INSTALLACTION ONLY.
      *DATE-WRITTEN.  09/12/19.
      *DATE-COMPLETED.
      **************************CC109**********************************

       PROCEDURE DIVISION.

       0000-INITIALIZE-PARA.


        EXEC SQL
            SELECT   RETAIL_SECT,
                     RING
            INTO    :X-RETAIL-SECT,
                    :X-RING-TYPE
            FROM     TBX  X
            WHERE    X.ROG            = :X-ROG
               AND   X.CORP_ITEM_CD   = :X-CORP-ITEM-CD
               AND   X.UPC_COUNTRY    = 0
               AND   X.UPC_SYSTEM     = 4
            ORDER BY PRIMARY_UPC_SW DESC
            FETCH FIRST ROW ONLY
            QUERYNO 3676

        END-EXEC.

       1000-INITIALIZE-PARA.
       EXEC SQL
            SELECT   STATUS_RUPC
            INTO    :X-STATUS-RUPC
            FROM     X
            WHERE   (ROG = :X-ROG
               AND   CORP_ITEM_CD = :X-CORP-ITEM-CD
               AND   STATUS_RUPC ¬= 'D'
               AND   STATUS_RUPC ¬= 'X')
            FETCH FIRST ROW ONLY
            QUERYNO 29


           END-EXEC.

       2000-INITIALIZE-PARA.
       EXEC SQL
            FETCH    COPYUPC_SSCOUPON
            INTO    :CPN_ROG,
                    :CPN_CPN_ADJ_IND

            END-EXEC.



      ******************************************************************
      * TABLE INSERT                                                   *
      ******************************************************************
       4000-INSERT-TABLE.

       EXEC SQL
        UPDATE   X
            SET
                     PRIMARY_UPC_SW=:X-PRIMARY-UPC-SW,
                     PACK_RETAIL=:X-PACK-RETAIL,
                     LABEL_SIZE=:X-LABEL-SIZE,
                     LABEL_NUMBERS=:X-LABEL-NUMBERS,
                     PRT_SIGN_IND=:X-PRT-SIGN-IND,
                     ITEM_SELECTION=:X-ITEM-SELECTION,
                     RING=:X-RING
            WHERE   (ROG = :X-ROG
               AND   CORP_ITEM_CD = :X-CORP-ITEM-CD
               AND   UPC_MANUF = :X-UPC-MANUF
               AND   UPC_SALES = :X-UPC-SALES
               AND   UPC_COUNTRY = :X-UPC-COUNTRY
               AND   UPC_SYSTEM = :X-UPC-SYSTEM
               AND   UNIT_TYPE = :X-UNIT-TYPE)
            QUERYNO 35

       END-EXEC.

       6000-FINAL-COUNT.
        CLOSE INFILE
              OUT.
        DISPLAY "-----------------------------------------------------".




