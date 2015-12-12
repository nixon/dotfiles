" errorformat from
" http://users.cis.fiu.edu/~prabakar/resource/Linux/vimtips.txt #280
setlocal makeprg=nosetests
setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
