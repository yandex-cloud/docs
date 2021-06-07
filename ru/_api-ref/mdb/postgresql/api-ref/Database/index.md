---
editable: false
---

# Database
Набор методов для управления ресурсами Database для PostgreSQL.
## JSON-представление {#representation}
```json 
{
  "name": "string",
  "clusterId": "string",
  "owner": "string",
  "lcCollate": "string",
  "lcCtype": "string",
  "extensions": [
    {
      "name": "string",
      "version": "string"
    }
  ]
}
```
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя базы данных.</p> 
clusterId | **string**<br><p>Идентификатор кластера PostgreSQL, к которому принадлежит база данных.</p> 
owner | **string**<br><p>Имя пользователя, назначенного владельцем базы данных.</p> 
lcCollate | **string**<br><p>POSIX-локаль для порядка сортировки строк. Может быть установлен только во время создания.</p> 
lcCtype | **string**<br><p>POSIX-локаль для классификации символов. Может быть установлена только во время создания.</p> 
extensions[] | **object**<br><p>Расширения PostgreSQL, включенные для базы данных.</p> 
extensions[].<br>name | **string**<br><p>Имя расширения, например ``pg_trgm`` или ``pg_btree``. Расширения, которые поддерживает Managed Service for PostgreSQL, <a href="/docs/managed-postgresql/operations/cluster-extensions">перечислены в документации</a>.</p> 
extensions[].<br>version | **string**<br><p>Версия расширения.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает новую базу данных PostgreSQL в указанном кластере.
[delete](delete.md) | Удаляет указанную базу данных PostgreSQL.
[get](get.md) | Возвращает указанный ресурс Database для PostgreSQL.
[list](list.md) | Получает список ресурсов Database для указанного кластера PostgreSQL.
[update](update.md) | Изменяет указанную базу данных PostgreSQL.