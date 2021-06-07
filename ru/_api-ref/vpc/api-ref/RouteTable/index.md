---
editable: false
---

# RouteTable
Набор методов для управления таблицами маршрутизации.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "staticRoutes": [
    {
      "destinationPrefix": "string",
      "nextHopAddress": "string"
    }
  ]
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор таблицы маршрутизации.</p> 
folderId | **string**<br><p>Идентификатор каталога, к которому принадлежит таблица маршрутизации.</p> 
createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> .</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя таблицы маршрутизации. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание таблицы маршрутизации. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате ``ключ:значение``. Максимум 64 метки на ресурс.</p> 
networkId | **string**<br><p>Идентификатор облачной сети, к которой принадлежит таблица маршрутизации.</p> 
staticRoutes[] | **object**<br><p>Статический маршрут. Дополнительные сведения см. в разделе <a href="/docs/vpc/concepts/static-routes">Статическая маршрутизация</a>.</p> 
staticRoutes[].<br>destinationPrefix | **string**<br><p>Подсеть назначения в нотации CIDR.</p> 
staticRoutes[].<br>nextHopAddress | **string**<br><p>IP-адрес next hop.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает таблицу маршрутизации в указанных каталоге и сети. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.
[delete](delete.md) | Удаляет указанную таблицу маршрутизации.
[get](get.md) | Возвращает указанную таблицу маршрутизации.
[list](list.md) | Возвращает список доступных таблиц маршрутизации в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций для указанной таблицы маршрутизации.
[update](update.md) | Обновляет указанную таблицу маршрутизации. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.