# robotpkg depend.mk for:	sysutils/console-bridge
# Created:			Anthony Mallet on Thu,  4 Jul 2013
#

DEPEND_DEPTH:=			${DEPEND_DEPTH}+
CONSOLE_BRIDGE_DEPEND_MK:=	${CONSOLE_BRIDGE_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=			console-bridge
endif

ifeq (+,$(CONSOLE_BRIDGE_DEPEND_MK)) # -------------------------------------

include ../../meta-pkgs/ros-base/depend.common
PREFER.console-bridge?=		${PREFER.ros-base}
SYSTEM_PREFIX.console-bridge?=	${SYSTEM_PREFIX.ros-base}

DEPEND_USE+=			console-bridge

DEPEND_ABI.console-bridge?=	console-bridge>=0.1
DEPEND_DIR.console-bridge?=	../../sysutils/console-bridge

SYSTEM_SEARCH.console-bridge=\
  'include/console_bridge/console.h'				\
  'lib/libconsole_bridge.so'					\
  'lib/pkgconfig/console_bridge.pc:/Version/s/[^0-9.]//gp'

endif # CONSOLE_BRIDGE_DEPEND_MK -------------------------------------------

DEPEND_DEPTH:=		${DEPEND_DEPTH:+=}
