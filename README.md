# xworld2016

A repo for my workshop at X World 2016 "Bash For Beginners"

It contains a bunch of example scripts and the Markdown source and
reveal.js slideshow for the presentation.

The reveal.js slideshow is created using [pandoc](http://pandoc.org).
The exact pandoc command can be found in `pandoc.sh`.

The `slides.pdf` file is generated by running the slideshow in  a
browser with the query `?print-pdf` and then saving to PDF from the
print dialog. As the background doesn't print properly in the normal
slideshow the special version `print.html` has been created with the
command line `pandoc-print.sh` that doesn't include the background. So
to create the PDF the URL is
`http://localhost:8000/print.html?print-pdf` if you run `python -m
SimpleHTTPServer` in this directory. The `slides_notes.pdf` file is
generated using `Marked 2` and `Export as, Save PDF`.

| File                 | Description                                |
| -------------------- | ------------------------------------------ |
| .empty               | An example dot file |
| Input-Font.zip       | The Input font - my favourite for Terminal |
| LaunchControl_1.27.tar.bz2 | Utility for LaunchAgents |
| OSX CLI Tools.tsv    | Cheat sheet of Mac specific command line tools |
| OSX CLI Tools.pdf    | PDF version of above cheat sheet. |
| README.md            | This file |
| XW16-Empty.jpg       | Background for slides |
| and.sh               | Example of `and` and `or` |
| alias.sh             | Example of `alias` |
| bash_profiles.sh     | Some parts of my .bash_profile file |
| com.honestpuck.test.plist | Example LaunchAgent  |
| case.sh              | Example case statement |
| dock_setup.sh        | Example entire script we use as LaunchAgent |
| efor.sh              | Example of C style for loop |
| expand.sh            | Example of variable expansion |
| for.sh               | Example for loop |
| func.sh              | Example of a function with aguments |
| if.sh                | Example of if. |
| index.html           | The presentation slides |
| local.job.plist      | Example LaunchAgent |
| pandoc.sh            | command line to run Pandoc and create slideshow |
| pandoc-print.sh      | command line to create `print.html` |
| print.html           | special edition of slides without background for creating PDF |
| prompt.sh            | Example of special shell variable | 
| reveal.js/*          | Slideshow software |
| solarized.zip        | My favourite theme for Terminal |
| slides.pdf           | a PDF of the presentation slides |
| slides_notes.pdf     | a PDF of the slides and my notes |
| weeks.sh             |  Example of maths using `expr` |
| weeks2.sh            | Pretty version of `weeks.sh` using `awk` |
| while.sh             | Example of using `while` |
| xworld2016-bash.md   | Markdown source for the slides |
