# Подсветка синтаксиса

## vim {#vim}
Для [ya vim](https://wiki.yandex-team.ru/yatool/vim/):
``` sh
$ echo "let g:ya_vim#highlight_syntax#yql = 'yes'" >> ${HOME}/.vimrc
```

В остальных случаях:
``` sh
$ mkdir -p $HOME/.vim/syntax
$ curl https://yql.yandex.net/download/syntax_highlight/yql.vim > ${HOME}/.vim/syntax/yql.vim
$ echo "let g:sql_type_default = 'yql'" >> ${HOME}/.vimrc
```

## emacs {#emacs}
``` sh
$ curl https://yql.yandex.net/download/syntax_highlight/EmacsYqlMode.lisp >> ~/.emacs
```