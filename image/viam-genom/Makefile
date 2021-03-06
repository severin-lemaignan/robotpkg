# robotpkg Makefile for:	image/viam-genom
# Created:			Anthony Mallet on Fri, 14 Mar 2008
#

DISTNAME=		viam-genom-1.10
CATEGORIES=		image
MASTER_SITES=		${MASTER_SITE_OPENROBOTS:=viam-genom/}
MASTER_REPOSITORY=	${MASTER_REPOSITORY_OPENROBOTS_TRAC}viam-genom
CHECKOUT_OPTS=		-r viam-genom-1

MAINTAINER=		openrobots@laas.fr
HOMEPAGE=		http://www.laas.fr/~mallet
COMMENT=		Versatile Image Acquisition Module - GenoM component
LICENSE=		2-clause-bsd

NOT_FOR_PLATFORM=
GNU_CONFIGURE=		yes
GENOM_MODULE=		viam

INCLUDE_DIRS.libjpeg+=	include
LIBRARY_DIRS.libjpeg+=	lib
RPATH_DIRS.libjpeg+=	lib

# codels
define PKG_OPTION_UNSET.api
  include ../../image/opencv/depend.mk
  DEPEND_ABI.viam-libs+=viam-libs~opencv
endef

# option for image display using opencv
PKG_SUPPORTED_OPTIONS+=	display
PKG_SUGGESTED_OPTIONS+=	display

PKG_OPTION_DESCR.display=	Enable embedded image display facility.
define PKG_OPTION_SET.display
  CONFIGURE_ARGS+=--enable-display
  include ../../image/opencv/depend.mk
  DEPEND_ABI.opencv+=	opencv~gtk
endef
PKG_OPTION_UNSET.display:=	CONFIGURE_ARGS+=--disable-display

PKG_OPTIONS_OPTIONAL_GROUPS+=	incompatible
PKG_OPTIONS_GROUP.incompatible=	api display

include ../../architecture/genom/depend.mk
include ../../image/viam-libs/depend.mk
include ../../localization/pom-genom/depend.mk
include ../../mk/sysdep/libjpeg.mk
include ../../mk/language/c.mk

include ../../mk/robotpkg.mk
