---
editable: false
---

# ApiGateway
Набор методов управления API-шлюзами.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "domain": "string",
  "logGroupId": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор API-шлюза. Генерируется при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит API-шлюз.</p> 
createdAt | **string** (date-time)<br><p>Время создания API-шлюза.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя API-шлюза. Имя уникально в рамках каталога.</p> 
description | **string**<br><p>Описание API-шлюза.</p> 
labels | **object**<br><p>Метки API-шлюза в формате ``key:value`` .</p> 
status | **string**<br><p>Состояние API-шлюза.</p> <ul> <li>CREATING: API-шлюз создается.</li> <li>ACTIVE: API-шлюз готов к использованию.</li> <li>DELETING: API-шлюз удаляется.</li> <li>ERROR: Сбой API-шлюза. Единственное разрешенное действие c API-шлюзом — удаление.</li> </ul> 
domain | **string**<br><p>Домен по умолчанию для API-шлюза. Генерируется при создании.</p> 
logGroupId | **string**<br><p>Идентификатор группы журналов выполнения для API-шлюза.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает API-шлюз в указанном каталоге.
[delete](delete.md) | Удаляет указанный API-шлюз.
[get](get.md) | Возвращает указанный API-шлюз. Обратите внимание, что возвращаются только базовые параметры API-шлюза. Чтобы получить соответствующую спецификацию OpenAPI, сделайте [getOpenapiSpec](/docs/api-gateway/api-ref/ApiGateway/getOpenapiSpec) запрос.
[getOpenapiSpec](getOpenapiSpec.md) | Возвращает спецификацию OpenAPI указанного API-шлюза.
[list](list.md) | Возвращает список API-шлюзов в указанном каталоге.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа для указанного API-шлюза.
[listOperations](listOperations.md) | Возвращает список операции для указанного API-шлюза.
[setAccessBindings](setAccessBindings.md) | Задает список привязок прав доступа для указанного API-шлюза.
[update](update.md) | Изменяет указанный API-шлюз.
[updateAccessBindings](updateAccessBindings.md) | Обновляет привязки прав доступа для указанного API-шлюза.