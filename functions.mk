#################################################################################
# collects all template yml files
#
# @params: Object Class: e.g. pv, pvc, etc..
#################################################################################
yml_template_files = $(wildcard *$1-*template.yml)

#################################################################################
# converts a string to it's uppercase version
#
# @params: any String
#################################################################################
uc = $(shell echo $(1) | tr a-z A-Z)

#################################################################################
# generates the oc clients parameters, that are prefixed with
# the object classes name (e.g. pv_, pvc_ or imagestream_)
#
# @params: Object Class: e.g. pv, pvc, etc..
#################################################################################
oc_params = $(foreach param,\
            $(filter $1_%,$(.VARIABLES)),\
            -v $(subst $1_,,$(param))=$($(param)))

#################################################################################
# processes and creates the objects of a file, that is matched
# by the yml_template_files wildcard.
# Uses the oc_params function, to pass all prefixed variables
#
# @params: Object Class: e.g. pv, pvc, etc..
#
# @see: yml_template_files
# @see: oc_params
# @see: uc
#################################################################################
yml_oc_importer = $(foreach V,\
                  $(call yml_template_files,$1),\
                  @echo "--> Creating $(call uc,$1)s from $(V):"; \
									$(call echoed_call,oc process -f $V $(call oc_params,$1));)

#################################################################################
# calls the parent image if its folder exists
#
# @params: - Parents Folder, 
# 			   - Parents Makefile Call in a seperate shell call, to 
# 			     separate it's environment
#################################################################################
call_parent = $(if $(realpath $1), @(/bin/bash -c "make -C $1 $2"))

#################################################################################
# Prints out the command befire executing it
#
# @params: command to be executed and echoed
#################################################################################
echoed_call = (echo "----> $1"; $1)
