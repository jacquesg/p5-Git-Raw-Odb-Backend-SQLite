#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define NEED_sv_2pv_flags
#define NEED_sv_2pvbyte_GLOBAL
#define NEED_newRV_noinc_GLOBAL

#include "ppport.h"

#include <git2.h>

typedef git_odb_backend * Odb_Backend;

int git_odb_backend_sqlite(git_odb_backend **backend_out, const char *sqlite_db);

MODULE = Git::Raw::Odb::Backend::SQLite		PACKAGE = Git::Raw::Odb::Backend::SQLite

Odb_Backend
new(class, db)
	SV *class
	const char *db

	PREINIT:
		int rc;
		Odb_Backend backend;

	CODE:
		rc = git_odb_backend_sqlite(&backend, db);
		if (rc != GIT_OK)
			croak("Could not create SQLite backend");

		RETVAL = backend;

	OUTPUT: RETVAL

