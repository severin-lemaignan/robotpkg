# robotpkg Makefile for:	path/hpp-core
# Created:			Anthony Mallet on Fri, 13 Jul 2007
#

HPP_PACKAGE=		hpp-core
HPP_VERSION=		2.7.3
PKGREVISION=		
MASTER_REPOSITORY=	git git@github.com:laas/hpp-core

CATEGORIES=	path
HPP_COMMENT=	interface with KineoWorks(tm)
LICENSE=	gnu-lgpl-v2

HPP_BUILD_SYSTEM=	cmake
include ../../meta-pkgs/hpp/Makefile.common

include ../../path/hpp-model/depend.mk
include ../../path/hpp-util/depend.mk
include ../../path/hpp-kwsplus/depend.mk
include ../../mk/language/c.mk
include ../../mk/language/c++.mk
include ../../mk/robotpkg.mk
