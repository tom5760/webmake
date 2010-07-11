#!/usr/bin/env python

from docutils.parsers.rst import Directive
from docutils.parsers.rst.directives import register_directive

class Test(Directive):
    'Placeholder directive.'
    def run(self):
        print 'Hello world!'
        return []
register_directive('test', Test)
