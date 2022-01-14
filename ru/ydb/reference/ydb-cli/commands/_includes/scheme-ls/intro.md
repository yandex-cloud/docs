---
sourcePath: core/reference/ydb-cli/commands/_includes/scheme-ls/intro.md
---
# Листинг объектов

Чтобы получить листинг объектов, используйте подкоманду `scheme ls <Путь>`. Если путь не указан, то будет выведен листинг корня базы данных:

```bash
ydb scheme ls
```

Результат:

```text
episodes seasons  series .sys
```

Чтобы посмотреть подробную информацию об объектах, добавьте флаг `-l`:

```bash
ydb scheme ls -l
```
