# Метод get
Возвращает указанный ресурс Folder.
 
Чтобы получить список доступных ресурсов Folder, используйте
запрос [list](/docs/resource-manager/api-ref/Folder/list).
 
## HTTP-запрос
`GET /resource-manager/v1/folders/{folderId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
folderId | Обязательное поле. Идентификатор запрашиваемого ресурса Folder. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Folder. Дополнительные сведения см. в разделе
[Каталог как ресурс Яндекс.Облака](/docs/resource-manager/concepts/resources-hierarchy#folder).
 
Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор каталога.
cloudId | **string**<br>Идентификатор облака, которому принадлежит каталог.
createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
name | **string**<br>Имя каталога. Имя должно быть уникальным в облаке. Длина имени должна быть от 3 до 63 символов.
description | **string**<br>Описание каталога. Длина описания должна быть от 0 до 256 символов.
labels | **object**<br>Метки ресурса в формате ключ-значение. Максимум 64 метки на ресурс.
status | **string**<br>Только для вывода. Статус каталога.  Статус каталога.   - STATUS_UNSPECIFIED: Статус неопределен.  - ACTIVE: Каталог активен.  - DELETING: Каталог удаляется.<br>`ACTIVE`<br>`DELETING`<br>