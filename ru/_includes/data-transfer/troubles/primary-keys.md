### Ошибка трансфера при переносе таблиц без первичных ключей {#primary-keys}

Текст ошибки:

```text
Primary key check failed: 14 Tables errors: Table no key columns found
```

Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ таблицы без первичных ключей не переносятся.

**Решение:** подготовьте источник в соответствии с разделом [Подготовка к трансферу](../../../data-transfer/operations/prepare.md).
