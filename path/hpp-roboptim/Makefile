# robotpkg Makefile for:	path/hpp-roboptim
# Created:			Antonio El Khoury on Thu, 26 Sep 2013
#

PKGREVISION=		1
HPP_PACKAGE=		hpp-roboptim
HPP_VERSION=		1.0.1
MASTER_REPOSITORY=	git git@github.com:laas/hpp-roboptim

CATEGORIES=		path
HPP_COMMENT=		Link between planning and optimization packages
LICENSE=		gnu-lgpl-v3

HPP_BUILD_SYSTEM=	cmake

include ../../meta-pkgs/hpp/Makefile.common

include ../../path/hpp-model/depend.mk
include ../../path/hpp-util/depend.mk
include ../../optimization/roboptim-trajectory/depend.mk
include ../../mk/sysdep/assimp2.mk
include ../../mk/language/c.mk
include ../../mk/language/c++.mk
include ../../mk/robotpkg.mk
