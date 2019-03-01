################################################################################
#
# cjdns
#
################################################################################

CJDNS_VERSION = cjdns-v20.2
CJDNS_SITE = $(call github,cjdelisle,cjdns,$(CJDNS_VERSION))
CJDNS_LICENSE = GPL-3.0
CJDNS_LICENSE_FILES = LICENSE
CJDNS_INSTALL_STAGING = YES

define CJDNS_CONFIGURE_CMDS
endef

ifneq ($(BR2_LINUX_KERNEL_SECCOMP_FILTER),y)
CJDNS_DO_VARS+= Seccomp_NO=1
endif

ifneq ($(BR2_TOOLCHAIN_USES_UCLIBC),)
CJDNS_DO_VARS+= UCLIBC=1
endif

define CJDNS_BUILD_CMDS
	echo $(TARGET_ARCH)
	mkdir -p $(@D)/tmp
	(cd $(@D) && \
	CROSS="true" \
	CC="$(TARGET_CC)" \
	AR="$(TARGET_AR)" \
	RANLIB="$(TARGET_RANLIB)" \
	CFLAGS="$(TARGET_CFLAGS) -U_FORTIFY_SOURCE" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	SYSTEM="linux" \
	TARGET_ARCH="$(BR2_ARCH)" \
	SSP_SUPPORT="$(BR2_TOOLCHAIN_BUILDROOT_USE_SSP)" \
	CJDNS_BUILD_TMPDIR="$(@D)/tmp" \
	$(CJDNS_DO_VARS) \
	exec ./do)
endef

$(eval $(generic-package))
