# robotpkg Makefile for:	path/hpp-dynamic-obstacle
# Created:			Anthony Mallet on Thu, 9 Apr 2009
#

PKGVERSION=	1.0
DISTNAME=	hppdynamicobstacle-${PKGVERSION_NOREV}
PKGNAME=	hpp-dynamic-obstacle-${PKGVERSION}
CATEGORIES=	path
MASTER_SITES=	${MASTER_SITE_OPENROBOTS:=hpp-dynamic-obstacle/}

MAINTAINER=	openrobots@laas.fr
#HOMEPAGE=	ftp://softs.laas.fr/pub/openrobots/hpp-dynamic-obstacle/
COMMENT=	Path planning for environments with moving obstacles

GNU_CONFIGURE=	yes

DOXYGEN_PLIST_DIR+=	share/doc/hppDynamicObstacle

include ../../path/hpp-kwsplus/depend.mk
include ../../path/hpp-core/depend.mk
include ../../mk/sysdep/kineoworks.mk
include ../../pkgtools/libtool/depend.mk
include ../../pkgtools/pkg-config/depend.mk
include ../../mk/sysdep/doxygen.mk
include ../../mk/language/c++.mk
include ../../mk/robotpkg.mk
