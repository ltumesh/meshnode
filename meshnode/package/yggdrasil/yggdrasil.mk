################################################################################
#
# yggdrasil
#
################################################################################

YGGDRASIL_VERSION = 0.3.3
YGGDRASIL_SITE = $(call github,yggdrasil-network,yggdrasil-go,v$(YGGDRASIL_VERSION))
YGGDRASIL_LICENSE = LGPL-3.0
YGGDRASIL_LICENSE_FILES = LICENSE

YGGDRASIL_LDFLAGS=-X $(YGGDRASIL_SRC_SUBDIR)/src/yggdrasil.buildName=yggdrasil \
		  -X $(YGGDRASIL_SRC_SUBDIR)/src/yggdrasil.buildVersion=$(YGGDRASIL_VERSION) \
		  -s -w

YGGDRASIL_BUILD_TARGETS = cmd/yggdrasil cmd/yggdrasilctl
YGGDRASIL_INSTALL_BINS = yggdrasil yggdrasilctl

HOST_GO_TARGET_ENV += GO111MODULE=on
HOST_GO_MAKE_ENV += GO111MODULE=on

define YGGDRASIL_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 \
		$(YGGDRASIL_PKGDIR)/files/yggdrasil.init \
		$(TARGET_DIR)/etc/init.d/S42yggdrasil
endef

$(eval $(golang-package))
