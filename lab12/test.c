/* Processed by ecpg (11.5 (Debian 11.5-1+deb10u1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "test.sqc"
#include <stdlib.h>

/* exec sql begin declare section */
     
     
     
     
     
     
     

#line 4 "test.sqc"
 char db [ 15 ] ;
 
#line 5 "test.sqc"
 char usr [ 15 ] ;
 
#line 6 "test.sqc"
 char pas [ 15 ] ;
 
#line 7 "test.sqc"
 char dbname [ 1024 ] ;
 
#line 8 "test.sqc"
 int id ;
 
#line 9 "test.sqc"
 char fname [ 20 ] ;
 
#line 10 "test.sqc"
 char lname [ 20 ] ;
/* exec sql end declare section */
#line 11 "test.sqc"




#line 1 "/usr/include/postgresql/sqlca.h"
#ifndef POSTGRES_SQLCA_H
#define POSTGRES_SQLCA_H

#ifndef PGDLLIMPORT
#if  defined(WIN32) || defined(__CYGWIN__)
#define PGDLLIMPORT __declspec (dllimport)
#else
#define PGDLLIMPORT
#endif							/* __CYGWIN__ */
#endif							/* PGDLLIMPORT */

#define SQLERRMC_LEN	150

#ifdef __cplusplus
extern "C"
{
#endif

struct sqlca_t
{
	char		sqlcaid[8];
	long		sqlabc;
	long		sqlcode;
	struct
	{
		int			sqlerrml;
		char		sqlerrmc[SQLERRMC_LEN];
	}			sqlerrm;
	char		sqlerrp[8];
	long		sqlerrd[6];
	/* Element 0: empty						*/
	/* 1: OID of processed tuple if applicable			*/
	/* 2: number of rows processed				*/
	/* after an INSERT, UPDATE or				*/
	/* DELETE statement					*/
	/* 3: empty						*/
	/* 4: empty						*/
	/* 5: empty						*/
	char		sqlwarn[8];
	/* Element 0: set to 'W' if at least one other is 'W'	*/
	/* 1: if 'W' at least one character string		*/
	/* value was truncated when it was			*/
	/* stored into a host variable.             */

	/*
	 * 2: if 'W' a (hopefully) non-fatal notice occurred
	 */	/* 3: empty */
	/* 4: empty						*/
	/* 5: empty						*/
	/* 6: empty						*/
	/* 7: empty						*/

	char		sqlstate[5];
};

struct sqlca_t *ECPGget_sqlca(void);

#ifndef POSTGRES_ECPG_INTERNAL
#define sqlca (*ECPGget_sqlca())
#endif

#ifdef __cplusplus
}
#endif

#endif

#line 14 "test.sqc"

main() {
    { ECPGconnect(__LINE__, 0, "tcp:postgresql://pascal:5432/u7rajchel" , "u7rajchel" , "u7rajchel" , NULL, 1); }
#line 16 "test.sqc"

    { ECPGtrans(__LINE__, NULL, "begin work");}
#line 17 "test.sqc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "update student set imie = 'Tomasz' where nazwisko = 'Kowalski'", ECPGt_EOIT, ECPGt_EORT);}
#line 18 "test.sqc"

    { ECPGtrans(__LINE__, NULL, "commit work");}
#line 19 "test.sqc"

    { ECPGdisconnect(__LINE__, "ALL");}
#line 20 "test.sqc"

    return EXIT_SUCCESS;
}