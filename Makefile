# Webmake Makefile - Statically build websites using ReStructuredText
# :Author: Tom Wambold
# :Contact: tom5760@gmail.com

# The directory with your site files
#SRC_DIR = src

# (OPTIONAL) Set this if you want to change the rst2html template
#TEMPLATE = template.txt

# (OPTIONAL) Set this if you are using a customized stylesheet
#STYLESHEET = $(SRC_DIR)/style.css

# Additional optional global dependencies (add STYLESHEET and TEMPLATE here if
# you use them).  Each of your .rst files will be rebuilt if these change.
#MORE_DEPS = $(STYLESHEET)

################################################
# You shouldn't need to edit anything under here
################################################

RST_FILES = $(shell find $(SRC_DIR) -name "*.rst")
HTML_FILES = $(RST_FILES:.rst=.html)

# This is so we can remove the space in the "relative" function.  Make strips
# out whitespace everywhere, so you need to hack to get a literal space in the
# "subst" function.
space :=
space +=

# Creates a relative link to $(3) relative to $(1) from $(2)
relative = $(subst $(space),,$(foreach x,$(subst /,\ ,$(patsubst $(2)/%,%,$(dir $(1)))),../))$(notdir $(3))

.PHONY: all clean distclean 

all: $(HTML_FILES)

$(HTML_FILES): $(MORE_DEPS)

%.html: %.rst
	@echo $< "->" $@
	@webmake -ts --link-stylesheet \
		$(if $(STYLESHEET),--stylesheet=$(call relative,$<,$(SRC_DIR),$(STYLESHEET))) \
		$< $@

clean:

distclean: clean
	-rm $(HTML_FILES)
