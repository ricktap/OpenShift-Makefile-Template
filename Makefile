.PHONY: all with_parent
all: internal-create-pv internal-create-pvc 

include env
include functions.mk

pv_APP_DOMAIN = APP_DOMAIN

with_parent:
	@echo "This is called on the current level: APP_NAME = $(APP_NAME)"
	$(call call_parent,parent,all)

internal-create-%: 
	$(call yml_oc_importer,$(subst internal-create-,,$@))

