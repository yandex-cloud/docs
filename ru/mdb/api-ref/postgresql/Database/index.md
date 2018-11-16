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

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает новую базу данных PostgreSQL в указанном кластере.
[delete](delete.md) | Удаляет указанную базу данных PostgreSQL.
[get](get.md) | Возвращает указанный ресурс Database для PostgreSQL.
[list](list.md) | Получает список ресурсов Database для указанного кластера PostgreSQL.
[update](update.md) | Изменяет указанную базу данных PostgreSQL.