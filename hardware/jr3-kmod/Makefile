# robotpkg Makefile for:	hardware/jr3-kmod
# Created:			Matthieu Herrb on Mon, 22 Dec 2008
#

DISTNAME=	jr3-kmod-1.0
PKGREVISION=	1
CATEGORIES=	hardware
MASTER_SITES=	${MASTER_SITE_OPENROBOTS:=linux/}

MAINTAINER=	openrobots@laas.fr
COMMENT=	Kernel driver for the JR3 force sensor PCI acquisition card

ONLY_FOR_PLATFORM=	Linux-%
NOT_FOR_PLATFORM=	Fedora-18-% Fedora-19-%
NOT_FOR_PLATFORM+=	Ubuntu-13.04-%

KMOD_DIR=	lib/modules/${OS_KERNEL_VERSION}/kernel/drivers/char
KMOD=		jr3.ko
INSTALLATION_DIRS+=${KMOD_DIR}
MAKE_FLAGS+=	KMOD_DIR=${KMOD_DIR}

MESSAGE_SUBST+=	CP=${CP}
MESSAGE_SUBST+=	KMOD_DIR=${KMOD_DIR}
MESSAGE_SUBST+=	KMOD=${KMOD}

KDIR=$(realpath $(dir $(filter %/utsrelease.h,${SYSTEM_FILES.kernel}))/../..)
MAKE_FLAGS+=	KDIR=${KDIR} IDIR=${KDIR}/kernel/drivers/char

include ../../mk/sysdep/kernel.mk
include ../../mk/sysdep/sudo.mk
include ../../mk/language/c.mk
include ../../mk/robotpkg.mk
