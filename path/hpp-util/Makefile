# robotpkg Makefile for:	path/hpp-util
# Created:			Thomas Moulard on Wed, 8 Sep 2010
#

HPP_PACKAGE=	        hpp-util
HPP_VERSION=		0.8.0
PKGREVISION=

MASTER_REPOSITORY=	${MASTER_REPOSITORY_GITHUB}/laas/${HPP_PACKAGE}

CATEGORIES=		path
HPP_COMMENT=		utility tools
LICENSE=		gnu-gpl-v3

HPP_BUILD_SYSTEM=	cmake
include ../../meta-pkgs/hpp/Makefile.common

# boost-1.47.0 has -Wconversion warnings in date_time/posix_time/posix_time.hpp
CMAKE_ARGS+=		-DCXX_DISABLE_WERROR=yes

include ../../mk/language/c.mk
include ../../mk/robotpkg.mk
