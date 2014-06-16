# robotpkg depend.mk for:	image/ros-depthimage-to-laserscan
# Created:			Séverin Lemaignan on Mon, 16 Jun 2014
#

DEPEND_DEPTH:=			${DEPEND_DEPTH}+
ROS_DEPTHIMAGE_TO_LASERSCAN_DEPEND_MK:=	${ROS_DEPTHIMAGE_TO_LASERSCAN_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=			ros-depthimage-to-laserscan
endif

ifeq (+,$(ROS_DEPTHIMAGE_TO_LASERSCAN_DEPEND_MK)) # -----------------------------------

include ../../meta-pkgs/ros-base/depend.common
PREFER.ros-depthimage-to-laserscan?=		${PREFER.ros-base}
SYSTEM_PREFIX.ros-depthimage-to-laserscan?=	${SYSTEM_PREFIX.ros-base}

DEPEND_USE+=			ros-depthimage-to-laserscan
ROS_DEPEND_USE+=		ros-depthimage-to-laserscan

DEPEND_ABI.ros-depthimage-to-laserscan?=	ros-depthimage-to-laserscan>=1.8
DEPEND_DIR.ros-depthimage-to-laserscan?=	../../image/ros-depthimage-to-laserscan

DEPEND_ABI.ros-depthimage-to-laserscan.groovy?=	ros-depthimage-to-laserscan>=1.0.1<1.0.6
DEPEND_ABI.ros-depthimage-to-laserscan.hydro?=	ros-depthimage-to-laserscan>=1.0.6<1.1
DEPEND_ABI.ros-depthimage-to-laserscan.indigo?=	ros-depthimage-to-laserscan>=1.0.6<1.1

SYSTEM_SEARCH.ros-depthimage-to-laserscan=\
  'include/depthimage_to_laserscan/DepthConfig.h'				\
  'include/depthimage_to_laserscan/DepthImageToLaserScan.h'				\
  'lib/libDepthImageToLaserScan.so'						\
  'lib/libDepthImageToLaserScanNodelet.so'						\
  'share/depthimage_to_laserscan/${ROS_STACKAGE}:/<version>/s/[^0-9.]//gp'	\
  '${PYTHON_SYSLIBSEARCH}/depthimage_to_laserscan/__init__.py'			\
  'lib/pkgconfig/depthimage_to_laserscan.pc:/Version/s/[^0-9.]//gp'

include ../../mk/sysdep/python.mk

endif # ROS_DEPTHIMAGE_TO_LASERSCAN_DEPEND_MK -----------------------------------------

DEPEND_DEPTH:=			${DEPEND_DEPTH:+=}
