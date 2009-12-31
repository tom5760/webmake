.. title:: Home - WebMake

WebMake
=======

.. contents::

About
-----

WebMake is a Makefile using ReStructuredText_ (RST) to statically generate a
website.  This method works well with simple websites without dynamic content.
A benefit of this is that you can keep your entire sources in a source control
system (like Git_).

.. _ReStructuredText: http://docutils.sourceforge.net/rst.html
.. _Git: http://git-scm.com/

Requirements
------------

* Python_ (Tested with 2.6.4)
* Docutils_ (Tested with 0.6)
* `GNU Make`_

.. _Python: http://python.org/
.. _Docutils: http://docutils.sourceforge.net/
.. _GNU Make: http://www.gnu.org/software/make/

Features
--------

* Small/Simple
    * Only one required file (the Makefile), if you don't want any
      customizations.
    * You can keep the files in your source control for your entire webpage,
      and only update when you want to.
* Extensible
    * Docutils is written in Python_, and the ReStructuredText_ parser is
      easily extended with new directives_ and roles_.
    * Just add your additions to a script and point the Makefile to it.
* Fast
    * The RST parser is fast, and the Makefile only regenerates pages that need
      to be updated.
    * Writing RST is easier than writing raw HTML, and is easily readable in
      plain text

.. _directives: http://docutils.sourceforge.net/docs/howto/rst-directives.html
.. _roles: http://docutils.sourceforge.net/docs/howto/rst-roles.html

Download
--------

All code can be found at `GitHub Project Page`_.

.. _GitHub Project Page: http://github.com/tom5760/webmake

Contact
-------

If you have any questions/comments feel free to contact me at tom5760@gmail.com.
