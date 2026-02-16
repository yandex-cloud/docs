### Не удается обработать имя объекта {#unable-to-parse-obj}

Текст ошибки:

```text
failed to list and filter tables in source:
filter failed: unable to filter transfer objects:
unable to parse obj: <имя.какого-либо.объекта>:
identifier '<имя.какого-либо.объекта>' contains 3 parts instead of maximum two
```

Ошибка возникает, если в списке объектов для переноса есть имя, разделенное двумя или более точками.

**Решение:** возьмите имя объекта в двойные кавычки — `"<имя.какого-либо.объекта>"`.