# robotpkg Makefile for:	middleware/ace
# Created:			Anthony Mallet on Wed, 23 Jan 2008
#

PKGREVISION=		1
ACE_VERSION=		6.0.4
DISTNAME=		ACE-${ACE_VERSION}
PKGNAME=		ace-${ACE_VERSION}
CATEGORIES=		middleware
MASTER_SITES=		http://download.dre.vanderbilt.edu/previous_versions/

MAINTAINER=		openrobots@laas.fr
HOMEPAGE=		http://www.cs.wustl.edu/~schmidt/ACE.html
COMMENT=		The ADAPTATIVE Communication Environment ACE(tm)
LICENSE=		doc

WRKSRC=			${WRKDIR}/ACE_wrappers

GNU_CONFIGURE=		yes
CONFIGURE_DIRS=		build
CONFIGURE_SCRIPT=	../configure
CONFIGURE_ARGS+=	--disable-ssl #		 we don't use ssl right now
CONFIGURE_ARGS+=	--disable-ace-tests
CONFIGURE_ARGS+=	--disable-ace-examples

# Disable ACE optimization and let robotpkg pass the correct flags according to
# user selection.
CONFIGURE_ARGS+=	--disable-optimize

# Disable runtime test enabling or not fast_memcpy(), this is for sure not
# reproducible and may break the public interface. On supported systems, there
# is no reason not to use system's memcpy() anyway.
CONFIGURE_ARGS+=	ace_cv_memcpy_loop_unroll=no

OVERRIDE_DIRDEPTH.pkg-config=	3

BUILD_DIRS=		build

include ../../pkgtools/pkg-config/depend.mk
include ../../mk/language/c.mk
include ../../mk/language/c++.mk
include ../../mk/robotpkg.mk

# create the build directory
pre-configure: ace-build-dir

.PHONY: ace-build-dir
ace-build-dir:
	${MKDIR} ${WRKSRC}/build
