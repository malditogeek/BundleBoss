BundleBoss
==========

BundleBoss does all the dirty Bundler work for you. Watches your projects' Gemfiles for changes and automatically updates your bundle.

It's meant to run with [rbenv](https://github.com/sstephenson/rbenv) on Mac OS X.

It Just Works™.

How?
----

Install BundleBoss:

    $> gem install bundle_boss

Generate your .bundle_boss settings file in your $HOME:

    # BundleBoss settings
    settings:
      # Show Growl notifications.
      notifications: true
      # Run 'bundle update' when required.
      update: true
    
    # Bundler settings. Can be any valid Bundler option.
    bundler:
      # Equivalent to: --binstubs
      binstubs: true
      # Equivalent to: --shebang ruby-local-exec
      shebang: ruby-local-exec
    
    # A list of your Bundler enabled projects.
    projects:
     - ~/src/omg
     - ~/src/wtf

Start BundleBoss:

    $> bundle_boss

License
-------

(The MIT license)

Copyright (c) 2011 Mauro Pompilio

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
