---
editable: false
---

# Folder
Набор методов для управления ресурсом Folder.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор каталога.</p> 
cloudId | **string**<br><p>Идентификатор облака, которому принадлежит каталог.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя каталога. Имя должно быть уникальным в облаке. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание каталога. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате `` key:value ``. Максимум 64 на ресурс.</p> 
status | **string**<br><p>Статус каталога.</p> <ul> <li>ACTIVE: Каталог доступен.</li> <li>DELETING: Каталог удаляется.</li> <li>PENDING_DELETION: Остановка ресурсов каталога с последующим ожиданием момента после которого необходимо начать удалять каталог.</li> </ul> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает каталог в указанном облаке.
[delete](delete.md) | Удаляет указанный каталог.
[get](get.md) | Возвращает указанный ресурс Folder.
[list](list.md) | Возвращает список доступных ресурсов Folder в указанном облаке.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа к указанному каталогу.
[listOperations](listOperations.md) | Возвращает список операций для указанного каталога.
[setAccessBindings](setAccessBindings.md) | Задает привязки прав доступа для указанного каталога.
[update](update.md) | Обновляет указанный каталог.
[updateAccessBindings](updateAccessBindings.md) | Обновляет привязки прав доступа для указанного каталога.