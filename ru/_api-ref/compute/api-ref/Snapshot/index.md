---
editable: false
---

# Snapshot
Набор методов для управления ресурсами Snapshot.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "storageSize": "string",
  "diskSize": "string",
  "productIds": [
    "string"
  ],
  "status": "string",
  "sourceDiskId": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор снимка.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит снимок.</p> 
createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя снимка. Длина 1-63 символов.</p> 
description | **string**<br><p>Описание снимка. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате ``key:value``. Максимум 64 на ресурс.</p> 
storageSize | **string** (int64)<br><p>Размер снимка, указанный в байтах.</p> 
diskSize | **string** (int64)<br><p>Размер диска при создании снимка указывается в байтах.</p> 
productIds[] | **string**<br><p>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины.</p> <p>Правильный идентификатор лицензии генерируется {{ yandex-cloud }}. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса.</p> <p>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе <a href="/docs/compute/api-ref/Image/create">create</a>.</p> 
status | **string**<br><p>Текущий статус снимка.</p> <ul> <li>CREATING: Снимок создается.</li> <li>READY: Снимок готов к использованию.</li> <li>ERROR: Со снимком произошла ошибка, блокирующая работу.</li> <li>DELETING: Снимок удаляется.</li> </ul> 
sourceDiskId | **string**<br><p>Идентификатор диска, используемого для создания снимка.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает снимок указанного диска.
[delete](delete.md) | Удаляет указанный снимок.
[get](get.md) | Возвращает указанный ресурс Snapshot.
[list](list.md) | Возвращает список доступных ресурсов Snapshot в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций для указанного снимка.
[update](update.md) | Изменяет указанный снимок.