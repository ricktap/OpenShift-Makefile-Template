include ../functions.mk
include env

APP_NAME=blue

all:
	@echo "this is a call on the parent: APP_NAME = $(APP_NAME)"
	$(call yml_oc_importer,$(subst internal-create-,,pv))
