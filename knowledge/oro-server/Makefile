# robotpkg Makefile for:	knowledge/oro-server
# Created:			Séverin Lemaignan on Mon, 6 Jul 2009
#

DISTNAME=		oro-server-0.8.1
MASTER_SITES=		${MASTER_SITE_OPENROBOTS:=oro-server/}
MASTER_REPOSITORY=	${MASTER_REPOSITORY_OPENROBOTS_TRAC}oro-server
EXTRACT_SUFX=		.tar.bz2

CATEGORIES=	knowledge
LICENSE=	isc
MAINTAINER=	severin.lemaignan@laas.fr
HOMEPAGE=	http://homepages.laas.fr/slemaign/oro-server
COMMENT=	Cognitive kernel for robotics

NO_CONFIGURE=	yes
BUILD_TARGET=	oro-server
INSTALL_TARGET=	install

MAKE_ENV+=	JAVAC="${JAVAC} -encoding UTF8"

# doc option
PKG_SUPPORTED_OPTIONS+=	doc
PKG_SUGGESTED_OPTIONS+=	doc
PKG_OPTION_DESCR.doc?=	Install ${PKGBASE} documentation

define PKG_OPTION_SET.doc
  DYNAMIC_PLIST_DIRS+=	share/doc/${PKGBASE}
  INSTALL_TARGET+=	install-doc
endef


include ../../knowledge/jena/depend.mk
include ../../knowledge/pellet/depend.mk
include ../../mk/language/java.mk
include ../../mk/language/c.mk
include ../../mk/robotpkg.mk
