#
# Copyright (c) 2006-2010 LAAS/CNRS
# Copyright (c) 1994-2006 The NetBSD Foundation, Inc.
# All rights reserved.
#
# This project includes software developed by the NetBSD Foundation, Inc.
# and its contributors. It is derived from the 'pkgsrc' project
# (http://www.pkgsrc.org).
#
# Redistribution  and  use in source   and binary forms,  with or without
# modification, are permitted provided that  the following conditions are
# met:
#
#   1. Redistributions  of  source code must  retain  the above copyright
#      notice, this list of conditions and the following disclaimer.
#   2. Redistributions in binary form must  reproduce the above copyright
#      notice,  this list of  conditions and  the following disclaimer in
#      the  documentation   and/or  other  materials   provided with  the
#      distribution.
#   3. All  advertising  materials  mentioning   features  or use of this
#      software must display the following acknowledgement:
#        This product includes software developed by the NetBSD
#        Foundation, Inc. and its contributors.
#   4. Neither the  name  of The NetBSD Foundation  nor the names  of its
#      contributors  may be  used to endorse or promote  products derived
#      from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS ``AS IS'' AND
# ANY  EXPRESS OR IMPLIED WARRANTIES, INCLUDING,  BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES   OF MERCHANTABILITY AND  FITNESS  FOR  A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO  EVENT SHALL THE AUTHOR OR  CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT,  INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING,  BUT  NOT LIMITED TO, PROCUREMENT  OF
# SUBSTITUTE  GOODS OR SERVICES;  LOSS   OF  USE,  DATA, OR PROFITS;   OR
# BUSINESS  INTERRUPTION) HOWEVER CAUSED AND  ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE  USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# From $NetBSD: bsd.pkg.update.mk,v 1.7 2006/10/05 12:56:27 rillig Exp $
#
#                                       Anthony Mallet on Thu Dec  7 2006
#

# This Makefile fragment contains the targets and variables for
# "make update".
#

$(call require, ${ROBOTPKG_DIR}/mk/internal/barrier.mk)
$(call require, ${ROBOTPKG_DIR}/mk/pkg/pkg-vars.mk)
$(call require, ${ROBOTPKG_DIR}/mk/depends/depends-vars.mk)

# --- update (PUBLIC) ------------------------------------------------------

# The 'update' target is a public target to update a package and all
# currently installed packages that depend upon this package.
#
_UPDATE_TARGETS=	update-message
_UPDATE_TARGETS+=	update-create-dlist
ifneq (yes,$(call exists,${_UPDATE_DIRS}))
  ifeq (,$(filter replace,${UPDATE_TARGET}))
    _UPDATE_TARGETS+=	update-deinstall-dlist
  endif
endif
_UPDATE_TARGETS+=	do-update
_UPDATE_TARGETS+=	update-clean
_UPDATE_TARGETS+=	update-done-message

# run after the 'depends' barrier
_UPDATE_TARGETS:=$(call barrier, depends, ${_UPDATE_TARGETS})

ifeq (yes,$(call only-for,update,yes))	     # if we are asking for an update
  ifneq (yes,$(call exists,${_UPDATE_DIRS})) # not resuming a previous one
    ifneq (yes,$(call for-unsafe-pkg,yes))   # and the package is unsafe
      _UPDATE_TARGETS:= update-up-to-date    # let us do nothing
    endif
  endif
endif

.PHONY: update
update: ${_UPDATE_TARGETS}


# --- do-update ------------------------------------------------------------

# Perform the update target; can be overriden.
#
do%update: .FORCE
	${_OVERRIDE_TARGET}
	${RUN}${RECURSIVE_MAKE} ${UPDATE_TARGET}			\
		DEPENDS_TARGET=${DEPENDS_TARGET}
	${RUN}${TEST} \! -f ${_UPDATE_DIRS} || while read dir <&9; do	\
	  if cd "${ROBOTPKG_DIR}/$${dir}"; then				\
	    ${RECURSIVE_MAKE} $(filter-out confirm,${UPDATE_TARGET})	\
		DEPENDS_TARGET=${DEPENDS_TARGET} || {			\
		${ERROR_MSG} ${hline};					\
		${ERROR_MSG} "$${bf}'${MAKE} ${UPDATE_TARGET}' failed"	\
			"in $${dir}$${rm}";				\
		${ERROR_MSG} "";					\
		${ERROR_MSG} "Fix the problem, then re-run"		\
			"'${MAKE} ${MAKECMDGOALS}' in ${PKGPATH}";	\
		${ERROR_MSG} ${hline};					\
		exit 2;							\
	    };								\
	  else								\
	    ${PHASE_MSG} "Skipping nonexistent directory $${dir}"; 	\
	  fi;								\
	done 9<${_UPDATE_DIRS}


.PHONY: update-message
update-message:
ifeq (yes,$(call exists,${_UPDATE_DIRS}))
	@${PHASE_MSG} "Resuming update for ${PKGNAME}"
else
	@${PHASE_MSG} "Updating for ${PKGNAME}"
endif

.PHONY: update-up-to-date
update-up-to-date: update-message
	@${ECHO_MSG} "${PKGNAME} is already installed and up-to-date."
	@${ECHO_MSG} "Use '${MAKE} ${MAKECMDGOALS} confirm' to force updating."

.PHONY: update-done-message
update-done-message:
	@${PHASE_MSG} "Done \`update' for ${PKGNAME}"


# clean update files
.PHONY: update-clean
update-clean:
	${RUN}${TEST} \! -f ${_UPDATE_DIRS} || while read dir <&9; do	\
	  if cd "${ROBOTPKG_DIR}/$${dir}"; then				\
	    ${RECURSIVE_MAKE} clean || noclean=$$noclean" "$$dir;	\
	  else								\
	    ${PHASE_MSG} "Skipping nonexistent directory $${dep}"; 	\
	  fi;								\
	done 9<${_UPDATE_DIRS};						\
	cd ${CURDIR};							\
	${RM} -f ${_UPDATE_DIRS} ${_UPDATE_LIST};			\
	if ${TEST} "$(call isyes,${UPDATE_CLEAN})"; then		\
	  ${RECURSIVE_MAKE} clean || noclean=$$noclean" "${PKGPATH};	\
	fi;								\
	if ${TEST} -n "$$noclean"; then					\
	    ${WARNING_MSG} ${hline};					\
	    ${WARNING_MSG} "Unable to clean for:";			\
	    for pkg in $$noclean; do					\
	      ${WARNING_MSG} "		$$pkg";				\
	    done;							\
	    ${WARNING_MSG} ${hline};					\
	fi


# compute the list of packages to update
.PHONY: update-create-dlist
update-create-dlist: ${_UPDATE_DIRS}

${_UPDATE_DIRS}: ${_UPDATE_LIST}
	${RUN}pkgs=`${CAT} ${_UPDATE_LIST}`;				\
	if ${TEST} "$$pkgs"; then					\
	  ${PKG_INFO} -Q PKGPATH $$pkgs >$@;				\
	fi

${_UPDATE_LIST}:
	${RUN}${MKDIR} ${WRKDIR} && >$@;				\
	if ${PKG_INFO} -qe "${PKGWILDCARD}"; then 			\
	  ${PKG_INFO} -qr "${PKGWILDCARD}" >$@;				\
	fi

# deinstall existing packages
.PHONY: update-deinstall-dlist
update-deinstall-dlist:
	${RUN}if ${PKG_INFO} -qe ${PKGBASE}; then			\
	  if ${TEST} -s ${_UPDATE_DIRS}; then				\
	    ${ECHO_MSG} "The following packages are going to be"	\
		"removed and reinstalled:";				\
	    while read p; do						\
		${ECHO_MSG} "	$$p";					\
	    done <${_UPDATE_DIRS};					\
	  fi;								\
	  ${RECURSIVE_MAKE} deinstall					\
		_UPDATE_INPROGRESS=yes DEINSTALLDEPENDS=yes;		\
	fi
