# :Author: Tom Wambold
# :Contact: tom5760@gmail.com
# 
# Makefile to build my website

# The directory with all of your .rst files
SRC_DIR = src
# Where to put the output
OUT_DIR = www
# Where static media files are (css, js, images, etc)
# This will be symlinked to your $(OUT_DIR)
MEDIA_DIR = media

# (OPTIONAL) Set this if you want to change the rst2html template
#TEMPLATE = $(MEDIA_DIR)/template.txt

# (OPTIONAL) Set this if you are using a customized stylesheet
STYLESHEET = $(MEDIA_DIR)/style.css

# Additional optional dependencies.  Add STYLESHEET and TEMPLATE here if you
# use them, or if you include a .rst file in other pages.
MORE_DEPS = $(STYLESHEET)

################################################
# You shouldn't need to edit anything under here
################################################

RST_FILES = $(shell find $(SRC_DIR) -name "*.rst")

# Generates the filenames for the output .html files 
HTML_FILES = $(patsubst $(SRC_DIR)%, $(OUT_DIR)%, $(addsuffix .html, $(basename $(RST_FILES))))

.PHONY: all clean distclean 

all: $(HTML_FILES) $(OUT_DIR)/$(MEDIA_DIR) $(OUT_DIR)/$(SRC_DIR)

# This target makes the symlink for the media and source directories
$(OUT_DIR)/$(MEDIA_DIR) $(OUT_DIR)/$(SRC_DIR): $(MEDIA_DIR) $(SRC_DIR)
	@if [[ ! -L $(abspath $@) || `readlink $@` != $(abspath $(patsubst $(OUT_DIR)/%,%,$@)) ]]; then\
		echo ln $(abspath $(patsubst $(OUT_DIR)/%,%,$@)) $(abspath $@);\
		rm $(abspath $@) &> /dev/null;\
		ln -sf $(abspath $(patsubst $(OUT_DIR)/%,%,$@)) $(abspath $@);\
	fi;

$(HTML_FILES): $(MORE_DEPS)

$(OUT_DIR)/%.html: $(SRC_DIR)/%.rst
	@# Create the target directory if it doesn't exist
	@if [[ ! -d $(dir $@) ]]; then\
		echo "mkdir -p $(dir $@)";\
		mkdir -p $(dir $@);\
	fi;
	@echo $< "->" $@
	@# The stuff in the --stylesheet flag creates a correct relative link for
	@# the depth of the source file.
	@./generate.py \
		-ts --link-stylesheet --cloak-email-addresses \
		--source-url=$(foreach v,$(subst /, ,$(patsubst $(SRC_DIR)/%,%,$(dir $<))),../)$< \
		$(if $(TEMPLATE),--template=$(TEMPLATE)) \
		$(if $(STYLESHEET),--stylesheet=$(foreach v,$(subst /, ,$(patsubst $(SRC_DIR)/%,%,$(dir $<))),../)$(STYLESHEET)) \
		$< $@

clean:

distclean: clean
	-rm -r $(OUT_DIR)
