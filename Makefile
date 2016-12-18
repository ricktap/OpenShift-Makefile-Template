.PHONY: all create-pv create-pvc
all: internal-create-pv internal-create-pvc 

include env
include functions.mk

internal-create-%: $(pv pvc imagestream)
	@$(call yml_oc_importer,$(subst internal-create-,,$@))

