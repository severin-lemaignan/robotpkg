# robotpkg Makefile for:	path/hpp-corbaserver
# Created:			Anthony Mallet on Mon, 27 Aug 2007
#

PKGREVISION=
HPP_PACKAGE=	hpp-corbaserver
HPP_VERSION=	2.5
HPP_COMMENT=	Corba server for Humanoid Path Planner

CATEGORIES=	path
MASTER_REPOSITORY=	git git@github.com:laas/hpp-corbaserver.git

LICENSE=	gnu-lgpl-v3

MAKE_JOBS_SAFE= no
HPP_BUILD_SYSTEM=	cmake

include ../../path/hpp-util/depend.mk
include ../../meta-pkgs/hpp/Makefile.common
include ../../middleware/omniORB/depend.mk
include ../../path/hpp-core/depend.mk
include ../../path/hpp-model-urdf/depend.mk
include ../../pkgtools/pkg-config/depend.mk
include ../../mk/language/c.mk
include ../../mk/language/c++.mk
include ../../mk/sysdep/doxygen.mk
include ../../mk/sysdep/python.mk
include ../../mk/robotpkg.mk
