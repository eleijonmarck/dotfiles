"color inkpot

" --- Syntax ---------------------------------------------------------------

" constants and macros
syntax match MACRO /\w\@<!\u[A-Z_]\+\w\@!/
" _t convention
syntax match cType /\w\+_t\w\@!/
" typeof
syntax match Keyword /\w\@<!typeof\w\@!/

" class types
syntax match cType /\w\@<!\u\w\+[A-Z]\@<!\w\@!/

" --------------------------------------------------------------------------

set nosmartindent
set shiftwidth=4 tabstop=4
set cin cinoptions=>4
set path=.,/usr/include,/usr/local/include,,

color 256-jungle
