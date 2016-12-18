.PHONY: all with_parent
all: internal-create-pv internal-create-pvc 

include env
include functions.mk


with_parent:
	@echo "This is called on the current level: APP_NAME = $(APP_NAME)"
	$(call call_parent,parent,make all)

internal-create-%: $(pv pvc imagestream)
	$(call yml_oc_importer,$(subst internal-create-,,$@))

