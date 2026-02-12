(Опционально) В поле **{{ ui-key.yacloud.trino.label_rbac-catalog-access }}** укажите, на какие каталоги распространяется правило:
* **{{ ui-key.yacloud.trino.rbac-catalog-match-by-id }}** — выберите идентификаторы каталогов. Можно выбрать только те каталоги, которые есть в кластере.
* **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name }}** — выберите имена каталогов. Можно выбрать только те каталоги, которые есть в кластере.
* **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name-regexp }}** — введите регулярное выражение. Правило распространяется на каталоги, имена которых соответствуют регулярному выражению.
* **{{ ui-key.yacloud.trino.rbac-catalog-match-by-empty }}** — правило распространяется на все каталоги кластера.
