# robotpkg Makefile for:	path/hpp-wholebody-step-corba
# Created:			Antonio El Khoury on Thu, 26 Sep 2013
#

PKGREVISION=		1
HPP_PACKAGE=		hpp-wholebody-step-corba
HPP_VERSION=		0.2
MASTER_REPOSITORY=	git git@github.com:laas/hpp-wholebody-step-corba

CATEGORIES=		path
HPP_COMMENT=		CORBA server and client for whole-body walk planning
LICENSE=		gnu-lgpl-v3

HPP_BUILD_SYSTEM=	cmake

include ../../meta-pkgs/hpp/Makefile.common

include ../../path/hpp-corbaserver/depend.mk
include ../../path/hpp-util/depend.mk
include ../../middleware/hpp-template-corba/depend.mk
include ../../path/hpp-wholebody-step-planner/depend.mk
include ../../mk/sysdep/assimp2.mk
include ../../mk/language/c.mk
include ../../mk/language/c++.mk
include ../../mk/robotpkg.mk
