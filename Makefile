.PHONY: all with_parent $(ENV_CREATE_TARGETS)
all: internal-create-pv internal-create-pvc 

include env
include functions.mk

pv_APP_DOMAIN = APP_DOMAIN
ENV_CREATE_TARGETS := $(addprefix internal-create-,pv pvc)

with_parent:
	@echo "This is called on the current level: APP_NAME = $(APP_NAME)"
	$(call call_parent,parent,all)

$(ENV_CREATE_TARGETS):
	$(call yml_oc_importer,$(subst internal-create-,,$@))

