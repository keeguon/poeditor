# PO Editor

PO Editor is a small Rails and Backbone.js app to import and review PO files and automatically export changes almost in real time. Basically all translations are imported via a rake tasks in a sqlite database (for ease of export) and they can be then reviewed and edited through the webapp. Each time a translation is edited a request to regenerate a new PO file is made and is then handled via DelayedJob.

## Requirements

* Rails 3.0.x
* SQLite 3
* MySQL (for DelayedJob)

## Technical details

The webapp uses Rails 3.0.x for the moment due to some contraints while making the app it'll be upgraded later this year. Also you need two backends because due to other constraints I had to make locales exportable so I stored them in SQLite and the rest is handled in MySQL, due to this fact migrations can be quirky but I used <https://github.com/jystewart/multi-database-migrations> to overcome this problem so I strongly recommend reading the associated doc to perform migrations.

Concerning the PO import they can be made through the `locales:import[locale,/path/to/po/file.po]` rake task.

## License

Copyright (c) 2012 Félix Bellanger <felix.bellanger@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.