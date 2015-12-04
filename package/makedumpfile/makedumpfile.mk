################################################################################
#
# makedumpfile
#
################################################################################

MAKEDUMPFILE_VERSION = 1.5.9
MAKEDUMPFILE_SOURCE = makedumpfile-$(MAKEDUMPFILE_VERSION).tar.gz
MAKEDUMPFILE_SITE = http://downloads.sourceforge.net/project/makedumpfile/makedumpfile/$(MAKEDUMPFILE_VERSION)
MAKEDUMPFILE_LICENSE = GPLv2
MAKEDUMPFILE_LICENSE_FILES = COPYING
MAKEDUMPFILE_DEPENDENCIES = elfutils bzip2 zlib

ifeq ($(BR2_STATIC_LIBS),y)
MAKEDUMPFILE_LINKTYPE = static
else
MAKEDUMPFILE_LINKTYPE = dynamic
endif
define MAKEDUMPFILE_REMOVE_LIB_TOOLS
	rm -rf $(TARGET_DIR)/usr/lib/makedumpfile
endef

define MAKEDUMPFILE_BUILD_CMDS
        $(MAKE) -C $(@D) TARGET=$(TARGET) CC="$(TARGET_CC)" \
			LINKTYPE=$(MAKEDUMPFILE_LINKTYPE) LDFLAGS="$(TARGET_LDFLAGS)" 
endef

define MAKEDUMPFILE_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D)  install DESTDIR=$(TARGET_DIR)
endef

MAKEDUMPFILE_POST_INSTALL_TARGET_HOOKS += MAKEDUMPFILE_REMOVE_LIB_TOOLS

$(eval $(generic-package))