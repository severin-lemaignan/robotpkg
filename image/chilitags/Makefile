# robotpkg Makefile for:	image/chilitags
# Created:			Séverin Lemaignan on Fri, 13 Dec 2013
#

VERSION=	1.3.1
DISTNAME=	chilitags-${VERSION}
MASTER_SITES=	${MASTER_SITE_GITHUB:=chili-epfl/chilitags/archive/${VERSION}${EXTRACT_SUFX}?f=}
MASTER_REPOSITORY=	${MASTER_REPOSITORY_GITHUB}/chili-epfl/chilitags

CATEGORIES=		image
MAINTAINER=		severin.lemaignan@epfl.ch
LICENSE=		gnu-lgpl-v3
HOMEPAGE=		https://github.com/chili-epfl/chilitags
COMMENT=		Robust Fiducial Markers for Augmented Reality

CMAKE_ARGS+=	-DWITH_CREATOR=ON
CMAKE_ARGS+=	-DWITH_DETECTOR=ON
CMAKE_ARGS+=	-DWITH_SAMPLES=ON

DEPEND_ABI.opencv =	opencv>=2.4
DEPEND_ABI.g++ =	g++>=4.7
DEPEND_ABI.clang++ =	clang++>=3.1

include ../../image/opencv/depend.mk
include ../../mk/language/c++.mk
include ../../mk/sysdep/cmake.mk
include ../../mk/robotpkg.mk
