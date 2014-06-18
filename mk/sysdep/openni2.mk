# robotpkg sysdep/openni2.mk
# Created:			Séverin Lemaignan, Tue 17 Jun 2014
#
DEPEND_DEPTH:=		${DEPEND_DEPTH}+
OPENNI2_DEPEND_MK:=	${OPENNI2_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=		openni2
endif

ifeq (+,$(OPENNI2_DEPEND_MK)) # ------------------------------------------------

PREFER.openni2?=	system
DEPEND_USE+=		openni2
DEPEND_ABI.openni2?=	openni2>=2.0

_openni_v=→·/define[ ]*XN_\(MAJOR\|MINOR\|MAINT\|BUILD\)/{s/$$/./;H;};
_openni_v+=→$${g;s/[^0-9.]//g;s/[.]$$//p}

SYSTEM_SEARCH.openni2=\
	include/openni2/OpenNI.h \
	'include/openni2/OniVersion.h:${_openni_v}' \
	lib/libOpenNI2.so

SYSTEM_PKG.Debian.openni2=	libopenni2-dev

endif # SDL_DEPEND_MK ------------------------------------------------------

DEPEND_DEPTH:=		${DEPEND_DEPTH:+=}
