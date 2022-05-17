SHELL := /bin/bash
SCRIPTS_PATH      := scripts

.PHONY: build-installer
build-installer:
	@$(SCRIPTS_PATH)/build_installer.sh ${NETWORK_TYPE} ${OS_TYPE} ${ARCH_TYPE} ${RELEASE_VERSION}