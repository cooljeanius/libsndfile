# extra_pkg.m4 - Macros to locate and utilise pkg-config.   -*- Autoconf -*-
#
# Copyright (c) 2008-2012 Erik de Castro Lopo <erikd@mega-nerd.com>
# Copyright (c) 2004 Scott James Remnant <scott@netsplit.com>.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# As a special exception to the GNU General Public License, if you
# distribute this file as part of a program that contains a
# configuration script generated by Autoconf, you may include it under
# the same distribution terms that you use for the rest of that program.

# --------------------------------------------------------------
# PKG_CHECK_MOD_VERSION(VARIABLE-PREFIX, MODULES, [ACTION-IF-FOUND],
# [ACTION-IF-NOT-FOUND])
#
# This is a very slight modification to the macro PKG_CHECK_MODULES that
# is in the original pkg.m4 file. It prints the versions in the checking
# message (erikd@mega-nerd.com).

AC_DEFUN([PKG_CHECK_MOD_VERSION],
[AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
AC_ARG_VAR([$1][_CFLAGS], [C compiler flags for $1, overriding pkg-config])dnl
AC_ARG_VAR([$1][_LIBS], [linker flags for $1, overriding pkg-config])dnl

pkg_failed=no
AC_MSG_CHECKING([for $2 ])

_PKG_CONFIG([$1][_CFLAGS], [cflags], [$2])
_PKG_CONFIG([$1][_LIBS], [libs], [$2])

pkg_link_saved_CFLAGS=$CFLAGS
pkg_link_saved_LIBS=$LIBS

eval "pkg_CFLAGS=\${pkg_cv_[]$1[]_CFLAGS}"
eval "pkg_LIBS=\${pkg_cv_[]$1[]_LIBS}"

CFLAGS="$CFLAGS $pkg_CFLAGS"
LIBS="$LIBS $pkg_LIBS"

AC_LINK_IFELSE([AC_LANG_PROGRAM([[]], [[puts ("");]])],[pkg_link=yes],[pkg_link=no])

CFLAGS=$pkg_link_saved_CFLAGS
LIBS=$pkg_link_saved_LIBS

if test $pkg_link = no ; then
	AS_ECHO_N(["link failed ... "])
	pkg_failed=yes
	fi

m4_define([_PKG_TEXT], [Alternatively, you may set the environment variables $1[]_CFLAGS
and $1[]_LIBS to avoid the need to call pkg-config.
See the pkg-config man page for more details.])

if test $pkg_failed = yes; then
        _PKG_SHORT_ERRORS_SUPPORTED
        if test $_pkg_short_errors_supported = yes; then
	        $1[]_PKG_ERRORS=`$PKG_CONFIG --short-errors --errors-to-stdout --print-errors "$2"`
        else
	        $1[]_PKG_ERRORS=`$PKG_CONFIG --errors-to-stdout --print-errors "$2"`
        fi
	# Put the nasty error message in config.log where it belongs
	echo "$$1[]_PKG_ERRORS" >&AS_MESSAGE_LOG_FD

	ifelse([$4], , [AC_MSG_ERROR(dnl
[Package requirements ($2) were not met:

$$1_PKG_ERRORS

Consider adjusting the PKG_CONFIG_PATH environment variable if you
installed software in a non-standard prefix.

_PKG_TEXT
])],
		[AC_MSG_RESULT([no])
                $4])
elif test $pkg_failed = untried; then
	ifelse([$4], , [AC_MSG_FAILURE(dnl
[The pkg-config script could not be found or is too old.  Make sure it
is in your PATH or set the PKG_CONFIG environment variable to the full
path to pkg-config.

_PKG_TEXT

To get pkg-config, see <http://pkg-config.freedesktop.org/>.])],
		[$4])
else
	$1[]_CFLAGS=$pkg_cv_[]$1[]_CFLAGS
	$1[]_LIBS=$pkg_cv_[]$1[]_LIBS
        AC_MSG_RESULT([yes])
	ifelse([$3], , :, [$3])
fi[]dnl
])# PKG_CHECK_MOD_VERSION
