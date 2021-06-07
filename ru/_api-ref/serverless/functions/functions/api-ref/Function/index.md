---
editable: false
---

# Function
Набор методов управления бессерверными функциями.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "logGroupId": "string",
  "httpInvokeUrl": "string",
  "status": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор функции. Генерируется во время создания.</p> 
folderId | **string**<br><p>Идентификатор каталога, к которому принадлежит функция.</p> 
createdAt | **string** (date-time)<br><p>Время создания функции.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя функции. Имя уникально в рамках каталога.</p> <p>Длина строки в символах должна быть от 3 до 63.</p> 
description | **string**<br><p>Описание функции.</p> <p>Длина строки в символах должна быть от 0 до 256.</p> 
labels | **object**<br><p>Метки функций в виде пар ``key:value`` .</p> <p>Не более 64 на ресурс.</p> 
logGroupId | **string**<br><p>Идентификатор группы журналов выполнения функции.</p> 
httpInvokeUrl | **string**<br><p>URL-адрес, который нужнозапросить для вызова функции.</p> 
status | **string**<br><p>Состояние функции.</p> <ul> <li>CREATING: Функция создается.</li> <li>ACTIVE: Функция готова к вызову.</li> <li>DELETING: Функция удаляется.</li> <li>ERROR: Сбой функции.</li> </ul> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает функцию в указанном каталоге.
[createVersion](createVersion.md) | Создает версию для указанной функции.
[delete](delete.md) | Удаляет указанную функцию.
[get](get.md) | Возвращает указанную функцию.
[getVersion](getVersion.md) | Возвращает указанную версию функции.
[getVersionByTag](getVersionByTag.md) | Возвращает все версии с указанным тегом.
[list](list.md) | Возвращает список функций в указанном каталоге.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа для указанной функции.
[listOperations](listOperations.md) | Возвращает список операций для указанной функции.
[listRuntimes](listRuntimes.md) | Список доступных сред выполнения для указанной функции.
[listTagHistory](listTagHistory.md) | Возвращает журнал тегов, назначенных версиям указанной функции.
[listVersions](listVersions.md) | Извлекает список версий для указанной функции или всех версий функции в указанном каталоге
[removeTag](removeTag.md) | Удаляет тег из указанной версии функции.
[setAccessBindings](setAccessBindings.md) | Устанавливает привязки прав доступа для указанной функции.
[setTag](setTag.md) | Устанавливает тег для указанной версии функции.
[update](update.md) | Обновляет указанную функцию.
[updateAccessBindings](updateAccessBindings.md) | Обновляет привязки прав доступа для указанной функции.