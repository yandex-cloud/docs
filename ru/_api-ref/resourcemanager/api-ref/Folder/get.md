---
editable: false
---

# Метод get
Возвращает указанный ресурс Folder.
 
Чтобы получить список доступных ресурсов Folder, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).
 
## HTTP-запрос {#https-request}
```
GET https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/{folderId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор запрашиваемого ресурса Folder. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

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
Ресурс Folder. Дополнительные сведения см. в разделе
[Каталог как ресурс Яндекс.Облака](/docs/resource-manager/concepts/resources-hierarchy#folder).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор каталога.</p> 
cloudId | **string**<br><p>Идентификатор облака, которому принадлежит каталог.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя каталога. Имя должно быть уникальным в облаке. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание каталога. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате `` key:value ``. Максимум 64 на ресурс.</p> 
status | **string**<br><p>Статус каталога.</p> <ul> <li>ACTIVE: Каталог доступен.</li> <li>DELETING: Каталог удаляется.</li> <li>PENDING_DELETION: Остановка ресурсов каталога с последующим ожиданием момента после которого необходимо начать удалять каталог.</li> </ul> 