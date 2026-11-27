---
editable: false
alternate:
  - href: ru/datalens/function-ref/TREE.md
    type: text/markdown
    title: Markdown version
---

# TREE



#### Синтаксис {#syntax}


```
TREE( array )
```

#### Описание {#description}
Переводит выражение `array` в формат `Дерево строк`. Используется для создания [древовидных иерархий](../dataset/data-types.md#tree-hierarchy).

**Типы аргументов:**
- `array` — `Массив строк`


**Возвращаемый тип**: `Любой`

#### Пример {#examples}

```
TREE(ARRAY([Country], [Region], [City]))
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `PostgreSQL 9.3`, `Trino`, `Яндекс Документы`.
