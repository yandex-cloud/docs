В поле **{{ ui-key.yacloud.alb.label_fqmn }}** выберите одну из опций:

* `{{ ui-key.yacloud.alb.label_match-exact }}` — чтобы маршрутизировать запросы, FQMN которых идентичен FQMN, заданному в текстовом поле справа.
* `{{ ui-key.yacloud.alb.label_match-prefix }}` — чтобы маршрутизировать запросы, FQMN в которых начинается с префикса, заданного в текстовом поле справа. Например, вы можете указать первое слово в имени сервиса: `/helloworld`.
* `{{ ui-key.yacloud.alb.label_match-regex }}` — чтобы маршрутизировать запросы, FQMN в которых удовлетворяет [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax), заданному в текстовом поле справа.

{% include [fqmn-slash-warning](./fqmn-slash-warning.md) %}