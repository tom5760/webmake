#!/usr/bin/python
# Customizations to rst2html by Tom Wambold <tom5760@gmail.com>
# Original by David Goodger <goodger@python.org>
# Copyright: This module has been placed in the public domain.

'''
A minimal front end to the Docutils Publisher, producing HTML.
'''

try:
    import locale
    locale.setlocale(locale.LC_ALL, '')
except:
    pass

import os

from docutils import nodes
from docutils.core import publish_cmdline, default_description
from docutils.parsers.rst import Directive
from docutils.parsers.rst.directives import register_directive
from docutils.parsers.rst.directives.misc import Include

# WOOO GLOBALS!  Please forgive me.
include_depth = 0

class RelativeLink(Directive):
    required_arguments = 2
    final_argument_whitespace = True

    def run(self):
        url = ['..' for x in range(include_depth)]
        url.append(self.arguments[0])
        url = '/'.join(url)
        target = self.state.make_target([url], '', self.lineno, self.arguments[1])
        return [target]
register_directive('relative_link', RelativeLink)

class NavInclude(Include):
    def run(self):
        # SORRY!
        global include_depth
        include_depth = self.arguments[0].split('/').count('..')
        return super(NavInclude, self).run()
register_directive('nav_include', NavInclude)

class MakeIndex(Directive):
    optional_arguments = 1
    final_argument_whitespace = True

    def run(self):
        path = os.path.dirname(self.state.document.attributes['source'])
        if self.arguments:
            path = os.path.join(path, self.arguments[0])
        path = os.path.relpath(path)

        list = nodes.bullet_list()
        for file in [f for f in os.listdir(path) if f.endswith('.rst')]:
            list.append(nodes.list_item(None, nodes.paragraph(None, nodes.Text(file))))
        return [list]
register_directive('make_index', MakeIndex)

description = ('Generates (X)HTML documents from standalone reStructuredText '
               'sources.  ' + default_description)
publish_cmdline(writer_name='html', description=description)
#publish_cmdline()
