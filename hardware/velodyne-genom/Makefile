# robotpkg Makefile for:	hardware/velodyne-genom
# Created:			Anthony Mallet on Wed, 25 Aug 2010
#

DISTNAME=		velodyne-genom-1.5
CATEGORIES=		hardware

MASTER_SITES=		${MASTER_SITE_OPENROBOTS:=velodyne/}
MASTER_REPOSITORY=	git ssh://trac.laas.fr/git/robots/velodyne-genom

MAINTAINER=		mallet@laas.fr
COMMENT=		GenoM module for Velodyne-HDL{32,64} LiDAR data acquisition
LICENSE=		2-clause-bsd

GENOM_MODULE=		velodyne

define PKG_OPTION_UNSET.api
  include ../../hardware/velodyne-libs/depend.mk
  include ../../image/libimages3d/depend.mk
  include ../../math/t3d/depend.mk
endef

include ../../interfaces/genPos-genom/depend.mk
include ../../localization/pom-genom/depend.mk
include ../../architecture/genom/depend.mk
include ../../mk/language/c.mk
include ../../mk/robotpkg.mk
