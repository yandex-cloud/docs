---
editable: false
---

# Метод get
Возвращает указанную таблицу маршрутизации.
 
Чтобы получить список доступных таблиц маршрутизации, используйте запрос [list](/docs/vpc/api-ref/RouteTable/list).
 
## HTTP-запрос {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/routeTables/{routeTableId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
routeTableId | Обязательное поле. Идентификатор возвращаемой таблицы маршрутизации. Для получения идентификатора таблицы маршрутизации используйте запрос [list](/docs/vpc/api-ref/RouteTable/list) .  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

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
Таблица маршрутизации. 
Дополнительные сведения см. в разделе [Статическая маршрутизация](/docs/vpc/concepts/static-routes).
 
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