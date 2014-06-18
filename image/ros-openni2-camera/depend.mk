# robotpkg depend.mk for:	image/ros-openni2-camera
# Created:			Séverin Lemaignan on Mon, 16 Jun 2014
#

DEPEND_DEPTH:=			${DEPEND_DEPTH}+
ROS_OPENNI2_CAMERA_DEPEND_MK:=	${ROS_OPENNI2_CAMERA_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=			ros-openni2-camera
endif

ifeq (+,$(ROS_OPENNI2_CAMERA_DEPEND_MK)) # ----------------------------------

include ../../meta-pkgs/ros-base/depend.common
PREFER.ros-openni2-camera?=		${PREFER.ros-base}
SYSTEM_PREFIX.ros-openni2-camera?=	${SYSTEM_PREFIX.ros-base}

DEPEND_USE+=			ros-openni2-camera
ROS_DEPEND_USE+=		ros-openni2-camera

DEPEND_ABI.ros-openni2-camera?=	ros-openni2-camera>=1.8
DEPEND_DIR.ros-openni2-camera?=	../../image/ros-openni2-camera

DEPEND_ABI.ros-openni2-camera.groovy?=	ros-openni2-camera>=1.8<1.9
DEPEND_ABI.ros-openni2-camera.hydro?=	ros-openni2-camera>=1.9<1.10

SYSTEM_SEARCH.ros-openni2-camera=\
	include/openni2_camera/OpenNIConfig.h					\
	include/openni2_camera/openni2_image.h					\
	lib/libopenni2_driver.so									\
	lib/libopenni2_nodelet.so								\
	lib/openni2_camera/openni2_node							\
	lib/libimage_geometry.so								\
	'share/openni2_camera/${ROS_STACKAGE}:/<version>/s/[^0-9.]//gp'	\
	'${PYTHON_SYSLIBSEARCH}/openni2_camera/__init__.py'			\
	'lib/pkgconfig/openni2_camera.pc:/Version/s/[^0-9.]//gp'

include ../../mk/sysdep/python.mk

endif # ROS_OPENNI2_CAMERA_DEPEND_MK ----------------------------------------

DEPEND_DEPTH:=			${DEPEND_DEPTH:+=}
