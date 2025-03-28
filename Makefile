#!/bin/env make -f

PACKAGE = starship-prompt
VERSION = $(shell cat VERSION)

MAINTAINER = $(shell git config user.name) <$(shell git config user.email)>

INSTALL = systemd, bash (>= 4.4)
BUILD = debhelper, make (>= 4.1), dpkg-dev, dpkg-changelog

HOMEPAGE = https:\/\/github.com\/MichaelSchaecher\/$(PACKAGE)

ARCH = amd64

PACKAGE_DIR = package

export PACKAGE_DIR

# Phony targets
.PHONY: all debian clean help

# Default target
all: debian

debian:

	@cp help/control $(PACKAGE_DIR)/DEBIAN/control

	@echo "Building package $(PACKAGE) version $(VERSION)"

	@sed -i "s/Version:/Version: $(VERSION)/" $(PACKAGE_DIR)/DEBIAN/control
	@sed -i "s/Maintainer:/Maintainer: $(MAINTAINER)/" $(PACKAGE_DIR)/DEBIAN/control
	@sed -i "s/Homepage:/Homepage: $(HOMEPAGE)/" $(PACKAGE_DIR)/DEBIAN/control

	@sed -i "s/Depends:/Depends: $(INSTALL)/" $(PACKAGE_DIR)/DEBIAN/control
	@sed -i "s/Build-Depends:/Build-Depends: $(BUILD)/" $(PACKAGE_DIR)/DEBIAN/control

# For some reason the INSTALL variable is being added to BUILD variable at the beginning of the line
# so we need to remove the that part of the line
	@sed -i "s/Build-Depends: $(BUILD) $(INSTALL)/Build-Depends: $(BUILD)/" $(PACKAGE_DIR)/DEBIAN/control

	@help/size

	@git-changelog $(PACKAGE_DIR)/DEBIAN/changelog
	@gzip -d $(PACKAGE_DIR)/DEBIAN/changelog.gz
	@git-changelog $(PACKAGE_DIR)/usr/share/doc/$(PACKAGE)/changelog

	@dpkg-deb --root-owner-group --build $(PACKAGE_DIR) $(PACKAGE)_$(VERSION)_$(ARCH).deb

install:

	@dpkg -i package/$(PACKAGE)_$(VERSION)_$(ARCH).deb

clean:
	@rm -Rvf $(PACKAGE)_$(VERSION)_$(ARCH).deb
help:
	@echo "Usage: make [target] <variables>"
	@echo ""
	@echo "Targets:"
	@echo "  all       - Build the debian package and install it"
	@echo "  debian    - Build the debian package"
	@echo "  install   - Install the debian package"
	@echo "  clean     - Clean up build files"
	@echo "  help      - Display this help message"
	@echo ""
