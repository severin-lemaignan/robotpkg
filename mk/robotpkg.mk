#
# Copyright (c) 2006-2013 LAAS/CNRS
# All rights reserved.
#
# This project includes software developed by the NetBSD Foundation, Inc.
# and its contributors. It is derived from the 'pkgsrc' project
# (http://www.pkgsrc.org).
#
# Redistribution and use  in source  and binary  forms,  with or without
# modification, are permitted provided that the following conditions are
# met:
#
#   1. Redistributions of  source  code must retain the  above copyright
#      notice, this list of conditions and the following disclaimer.
#   2. Redistributions in binary form must reproduce the above copyright
#      notice,  this list of  conditions and the following disclaimer in
#      the  documentation  and/or  other   materials provided  with  the
#      distribution.
#
# THIS  SOFTWARE IS PROVIDED BY  THE  COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND  ANY  EXPRESS OR IMPLIED  WARRANTIES,  INCLUDING,  BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES  OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR  PURPOSE ARE DISCLAIMED. IN  NO EVENT SHALL THE COPYRIGHT
# HOLDERS OR      CONTRIBUTORS  BE LIABLE FOR   ANY    DIRECT, INDIRECT,
# INCIDENTAL,  SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF  SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
# USE   OF THIS SOFTWARE, EVEN   IF ADVISED OF   THE POSSIBILITY OF SUCH
# DAMAGE.
#
# From $NetBSD: bsd.pkg.mk,v 1.1892 2006/10/23 14:40:14 rillig Exp $
#
#                                      Anthony Mallet on Wed Nov  8 2006
#

# Please see the robotpkg/doc/robotpkg manual for details on the variables used
# in this Makefile template.

# Make sure the default target is "all", which is an alias for "build".
# The default target does the following:
#    bootstrap-depends depends fetch checksum extract patch configure build
#
.DEFAULT_GOAL:=build
ifeq (,${MAKECMDGOALS})
  MAKECMDGOALS:=${.DEFAULT_GOAL}
endif

.PHONY: all
all: build

# We are definitely not -j aware
.NOTPARALLEL:

# Include any preferences, if not already included, and default definitions.
ifndef MK_ROBOTPKG_PREFS
  include ../../mk/robotpkg.prefs.mk
endif

ifndef ROBOTPKG_TRUSTED_ENV # ==============================================

  include ${ROBOTPKG_DIR}/mk/internal/trusted.mk

else # =====================================================================

# apply local settings defined by parent make invocations
$(call require, ${ROBOTPKG_DIR}/mk/internal/env.mk)

# User build options processing
$(call require, ${ROBOTPKG_DIR}/mk/robotpkg.options.mk)

# Helper definitions
$(call require,${ROBOTPKG_DIR}/mk/internal/utils.mk)

# Locking
$(call require, ${ROBOTPKG_DIR}/mk/internal/locking.mk)


# --- core functionality ---------------------------------------------------

# Clean
$(call require-for, clean cleaner su-do-clean,				\
	${ROBOTPKG_DIR}/mk/clean.mk)

# Fetch
$(call require-for, fetch fetch-all,					\
	${ROBOTPKG_DIR}/mk/fetch/fetch.mk)
$(call require-for, mirror-distfiles,					\
	${ROBOTPKG_DIR}/mk/fetch/mirror.mk)

# Checksum
$(call require-for, checksum mdi distinfo,				\
	${ROBOTPKG_DIR}/mk/checksum/checksum-vars.mk)

# Extract
$(call require-for, extract,						\
	${ROBOTPKG_DIR}/mk/extract/extract.mk)

# Checkout
$(call require-for, checkout,						\
	${ROBOTPKG_DIR}/mk/extract/checkout.mk)

# Patch
$(call require-for, patch,						\
	${ROBOTPKG_DIR}/mk/patch/patch-vars.mk)

# Configure
$(call require-for, configure,						\
	${ROBOTPKG_DIR}/mk/configure/configure.mk)

# Build
$(call require-for, all build,						\
	${ROBOTPKG_DIR}/mk/build/build.mk)

# Install
$(call require-for, install install-failsafe su-install-all		\
	deinstall su-deinstall replace su-replace bootstrap-register,	\
	${ROBOTPKG_DIR}/mk/install/install-vars.mk)

# Package
$(call require-for, package tarup,					\
	${ROBOTPKG_DIR}/mk/package/package-vars.mk)

# Dependencies
$(call require-for, bootstrap-depends sys-bootstrap-depends		\
	depends sys-depends,						\
	${ROBOTPKG_DIR}/mk/depends/depends-vars.mk)

# Update
$(call require-for, update,						\
	${ROBOTPKG_DIR}/mk/update/update-vars.mk			\
	${ROBOTPKG_DIR}/mk/update/update.mk)

# Bulk
$(call require-for, bulk su-bulk-%,					\
	${ROBOTPKG_DIR}/mk/bulk/bulk.mk)


# --- users's convenience targets ------------------------------------------

# packages sets
$(call require, ${ROBOTPKG_DIR}/mk/sets/sets-vars.mk)

# informational show-% and print-% targets
$(call require-for, show-%, ${ROBOTPKG_DIR}/mk/internal/show.mk)
$(call require-for, print-%, ${ROBOTPKG_DIR}/mk/internal/print.mk)

# semi-automatic PLIST generation
$(call require-for, print-PLIST, ${ROBOTPKG_DIR}/mk/plist/plist-vars.mk)

# index.html generation code.
$(call require-for, index print-summary-data,				\
	${ROBOTPKG_DIR}/mk/internal/index.mk)

# headings generation code.
$(call require-for, headings, ${ROBOTPKG_DIR}/mk/internal/headings.mk)


# --- Files included after this line must be included as late as possible --
#
# These files must appear near the end of the robotpkg.mk file because they do
# immediate expansions on variables set before.

# In-place files substitutions
ifdef SUBST_CLASSES
  $(call require, ${ROBOTPKG_DIR}/mk/internal/subst.mk)
endif

# Just-in-time sudo
ifdef _SU_TARGETS
  $(call require, ${ROBOTPKG_DIR}/mk/internal/su-target.mk)
endif

# Resolve all dependencies into the adequate variable depending on the type of
# dependency.
$(call require, ${ROBOTPKG_DIR}/mk/depends/resolve.mk)

# Checks whether a package can be built in the current robotpkg.
$(call require, ${ROBOTPKG_DIR}/mk/internal/can-be-built-here.mk)

endif # ROBOTPKG_TRUSTED_ENV ===============================================

# Tell 'make' not to try to rebuild any Makefile by specifing a target with no
# dependencies and no commands, execpt for those that do have recipes.
#
$(filter-out ${_MAKEFILE_WITH_RECIPES},$(sort ${MAKEFILE_LIST})):;
