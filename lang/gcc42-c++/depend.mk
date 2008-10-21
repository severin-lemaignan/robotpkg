# $LAAS: depend.mk 2008/10/21 16:12:47 mallet $
#
# Copyright (c) 2008 LAAS/CNRS
# All rights reserved.
#
# Redistribution and use  in source  and binary  forms,  with or without
# modification, are permitted provided that the following conditions are
# met:
#
#   1. Redistributions of  source  code must retain the  above copyright
#      notice and this list of conditions.
#   2. Redistributions in binary form must reproduce the above copyright
#      notice and  this list of  conditions in the  documentation and/or
#      other materials provided with the distribution.
#
#                                      Anthony Mallet on Fri Oct 17 2008
#

DEPEND_DEPTH:=		${DEPEND_DEPTH}+
GCC42_C++_DEPEND_MK:=	${GCC42_C++_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=		gcc42-c++
endif

ifeq (+,$(GCC42_C++_DEPEND_MK)) # ------------------------------------

PREFER.gcc42-c++?=	system

DEPEND_USE+=		gcc42-c++

DEPEND_ABI.gcc42-c++?=	gcc42-c++>=4.2
DEPEND_DIR.gcc42-c++?=	../../lang/gcc42-c++

SYSTEM_SEARCH.gcc42-c++ =	\
	'bin/g++::% -dumpversion'	\
	'lib/libstdc++.so.6*'

GCC_REQD+=		4.2.0
USE_LANGUAGES+=		c++

endif # GCC42_C++_DEPEND_MK ------------------------------------------

DEPEND_DEPTH:=			${DEPEND_DEPTH:+=}
