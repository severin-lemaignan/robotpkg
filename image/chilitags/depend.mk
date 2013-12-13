# robotpkg depend.mk for:	image/chilitags
# Created:					Séverin Lemaignan on Fri, 13 Dec 2013
#

DEPEND_DEPTH:=		${DEPEND_DEPTH}+
CHILITAGS_DEPEND_MK:=	${CHILITAGS_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=		chilitags
endif

ifeq (+,$(CHILITAGS_DEPEND_MK)) # ---------------------------------------------

PREFER.chilitags?=		robotpkg

SYSTEM_SEARCH.chilitags=\
	include/chilitags/DetectChilitags.hpp	\
	include/chilitags/Objects.hpp			\
	bin/chilitags-detect					\
	lib/libchilitags.so						\
	'lib/pkgconfig/chilitags.pc:/Version/s/[^0-9.]//gp'

DEPEND_USE+=		chilitags

DEPEND_ABI.chilitags?=	chilitags>=1.3
DEPEND_DIR.chilitags?=	../../image/chilitags

endif # CHILITAGS_DEPEND_MK ---------------------------------------------------

DEPEND_DEPTH:=		${DEPEND_DEPTH:+=}
