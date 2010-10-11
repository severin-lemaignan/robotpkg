#
# Copyright (c) 2010 LAAS/CNRS
# All rights reserved.
#
# Redistribution  and  use  in  source  and binary  forms,  with  or  without
# modification, are permitted provided that the following conditions are met:
#
#   1. Redistributions of  source  code must retain the  above copyright
#      notice and this list of conditions.
#   2. Redistributions in binary form must reproduce the above copyright
#      notice and  this list of  conditions in the  documentation and/or
#      other materials provided with the distribution.
#
# THE SOFTWARE  IS PROVIDED "AS IS"  AND THE AUTHOR  DISCLAIMS ALL WARRANTIES
# WITH  REGARD   TO  THIS  SOFTWARE  INCLUDING  ALL   IMPLIED  WARRANTIES  OF
# MERCHANTABILITY AND  FITNESS.  IN NO EVENT  SHALL THE AUTHOR  BE LIABLE FOR
# ANY  SPECIAL, DIRECT,  INDIRECT, OR  CONSEQUENTIAL DAMAGES  OR  ANY DAMAGES
# WHATSOEVER  RESULTING FROM  LOSS OF  USE, DATA  OR PROFITS,  WHETHER  IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR  OTHER TORTIOUS ACTION, ARISING OUT OF OR
# IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
#                                           Anthony Mallet on Thu Aug 26 2010
#

# This Makefile fragment implements the 'sets' targets, specified as
# <target>-<set>, where <target> is a regular robotpkg target, and <set> the
# name of a package set defined by a robotpkg.conf variable PKGSET.<set>.
#
# Configuration variables: PKGSET_FAILSAFE, PKGSET_STRICT (see
# robotpkg.default.conf)
#
PKGSET_PATTERN?=	PKGSET.%
PKGSET_FAILSAFE?=	no
PKGSET_STRICT?=		no


# names of existing sets in robotpkg.conf, plus special 'installed' set, sorted
# for unicity
_pkgset_names= $(sort installed \
  $(patsubst ${PKGSET_PATTERN},%, $(filter ${PKGSET_PATTERN},${.VARIABLES})))

# targets that are 'set'-aware
_pkgset_targets=\
	clean clean-depends fetch extract install replace update

# list of available sets targets (_pkgset_targets x _pkgset_names).
_pkgset_avail=\
  $(sort $(foreach _t,${_pkgset_targets},$(addprefix ${_t}-,${_pkgset_names})))

# list of targets actually required
_pkgset_goals= $(filter ${MAKECMDGOALS},${_pkgset_avail})

# compute PKGSET.installed if needed
ifneq (,$(filter %-installed,${_pkgset_goals}))
  ifndef PKGSET.installed
    $(call require, ${ROBOTPKG_DIR}/mk/pkg/pkg-vars.mk)
    export PKGSET.installed=$(shell ${PKG_INFO} -qu -Q PKGPATH 2>/dev/null)
  endif
endif

# --- <target>-<set> (PUBLIC) ----------------------------------------------

# Implementation of the <target>-<set> target.
#
ifneq (,${_pkgset_goals})
  $(call require,${ROBOTPKG_DIR}/mk/sets/sets.mk)

  .PHONY: ${_pkgset_goals}
  ${_pkgset_goals}: %: set-%

  # error message printed for non-existent packages in a set
  override define PKGSET_NONEXISTENTPKG_ERR
    $(if $(call isyes,${PKGSET_FAILSAFE}),			\
	:;							\
    ,	${ERROR_MSG} ${hline};					\
	${ERROR_MSG} "Package $1 in set '$2' does not exist.";	\
	${ERROR_MSG} ${hline};					\
	exit 2;							\
    )
  endef

  # error message printed when recursion in a set fails
  override define PKGSET_RECURSIVE_ERR
    $(if $(call isyes,${PKGSET_FAILSAFE}),			\
	:;							\
    ,	${ERROR_MSG} ${hline};					\
	${ERROR_MSG} "$${bf}An error occured in $1.$${rm}";	\
	${ERROR_MSG} "Fix the problem, then re-run"		\
		"'${MAKE} ${MAKECMDGOALS}'";			\
	${ERROR_MSG} ${hline};					\
	exit 2;							\
    )
  endef

endif # _pkgset_goals