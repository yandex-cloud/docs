---
sourcePath: ru/ydb/ydb-docs-core/ru/core/reference/ydb-sdk/example/_includes/steps/06_param_queries.md
---
## Параметризованные запросы {#param-queries}

Выполняется запрос к данным с использованием параметров. Этот вариант выполнения запросов является предпочтительным, так как позволяет серверу переиспользовать план исполнения запроса при последующих его вызовах, а также спасает от уязвимостей вида [SQL Injection](https://ru.wikipedia.org/wiki/Внедрение_SQL-кода).
