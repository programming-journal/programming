# Setting up LyX to work with programming.cls

These instructions were written originally for a macOS machine.

On macOS:

    mkdir -p ~/Library/texmf/tex/latex/programming
    cp programming.cls ~/Library/texmf/tex/latex/programming/.

    mkdir -p ~/Library/Application\ Support/LyX-2.4/layouts
    cp programming.layout ~/Library/Application\ Support/LyX-2.4/layouts

On Linux (Debian):

    mkdir -p ~/texmf/tex/latex/programming
    cp programming.cls ~/texmf/tex/latex/programming/.

    mkdir -p ~/.lyx/layouts
    cp programming.layout ~/.lyx/layouts

Run Tools > Reconfigure from LyX.

Restart LyX.

Now "Programming" should show up in Document Settings > Document Class.

You probably want to choose "Use non-TeX fonts (via XeTeX/LuaTeX)" for each document that uses
this class, too.

## Use the LuaTeX renderer

You will need to build documents using the LyX "PDF (LuaTeX)" file format. You can either
select this each time from the menu or change the application-wide default.

To change the default, go to Preferences > File Handling > File Formats. Near the bottom of the
screen is a panel labelled "Default Output Formats".

By default, "With TeX fonts" is set to "PDF (pdflatex)", and "With non-TeX fonts" is set to
"PDF (XeTeX)".

It's fine to set both to "PDF (LuaTeX)".

Alternatively, change only the non-TeX one, and on a document-by-document basis, in Document
Settings > Fonts, choose "Use non-TeX fonts (via XeTeX/LuaTeX)".

## Bibliographies

It's probably best to switch Document Settings > Bibliography > Citation Style > Style format
to "Biblatex". Delete the text from the "Biblatex citation style" and "Biblatex bibliography
style" fields.
