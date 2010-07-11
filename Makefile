# Makefile - Statically build websites using Webmake
# :Author: Tom Wambold
# :Contact: tom5760@gmail.com

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
	@$(WEBMAKE_DIR)/webmake -ts --link-stylesheet \
		$(foreach x, $(EXTENSIONS), --extension $(x)) \
		$(if $(STYLESHEET),--stylesheet=$(call relative,$<,$(SRC_DIR),$(STYLESHEET))) \
		$< $@

clean:

distclean: clean
	-rm $(HTML_FILES)
