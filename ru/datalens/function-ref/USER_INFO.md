---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/USER_INFO.md
---

# USER_INFO



#### Синтаксис {#syntax}


```
USER_INFO( user_id, user_info_type )
```

#### Описание {#description}
По идентификатору пользователя `user_id` возвращает размеченный текст для отображения его имени или email в зависимости от значения второго аргумента `user_info_type`:

* `email` — возвращает email;
* `name` — возвращает имя.

Если пользователь не найден, возвращается оригинальная строка из источника.

**Типы аргументов:**
- `user_id` — `Строка`
- `user_info_type` — `Строка`


**Возвращаемый тип**: `Разметка`

#### Примеры {#examples}

```
USER_INFO('b1ggmp8es27t********', 'name') = 'test_user'
```

```
USER_INFO([UserId], 'email') = 'test_user@example.com'
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
