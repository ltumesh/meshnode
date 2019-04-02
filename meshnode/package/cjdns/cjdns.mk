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
	# The compilation fails when br_real is given an empty file name from
	# the Cjdns node_build scripts:
	# ```
	# Link time optimization not supported [arm-buildroot-linux-uclibcgnueabihf-gcc.br_real: error: : No such file or directory
	# arm-buildroot-linux-uclibcgnueabihf-gcc.br_real: error: : No such file or directory
	# arm-buildroot-linux-uclibcgnueabihf-gcc.br_real: error: : No such file or directory
	# arm-buildroot-linux-uclibcgnueabihf-gcc.br_real: error: : No such file or directory
	# arm-buildroot-linux-uclibcgnueabihf-gcc.br_real: error: : No such file or directory
	# arm-buildroot-linux-uclibcgnueabihf-gcc.br_real: error: : No such file or directory
	# arm-buildroot-linux-uclibcgnueabihf-gcc.br_real: error: : No such file or directory
	# arm-buildroot-linux-uclibcgnueabihf-gcc.br_real: error: : No such file or directory
	# ...
	# ```
	exit 1
endef

define CJDNS_BUILD_CMDS
	mkdir -p $(@D)/tmp
	(cd $(@D) && \
	PATH="$(PATH):$(HOST_DIR)/bin" \
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
	./do)
endef

$(eval $(generic-package))
