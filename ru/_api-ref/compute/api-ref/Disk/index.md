---
editable: false
---

# Disk
Набор методов для управления ресурсами Disk.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "typeId": "string",
  "zoneId": "string",
  "size": "string",
  "productIds": [
    "string"
  ],
  "status": "string",
  "instanceIds": [
    "string"
  ],

  //  включает только одно из полей `sourceImageId`, `sourceSnapshotId`
  "sourceImageId": "string",
  "sourceSnapshotId": "string",
  // конец списка возможных полей

}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор типа диска.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит диск.</p> 
createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя диска. Длина 1-63 символов.</p> 
description | **string**<br><p>Описание диска. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате ``key:value``. Максимум 64 на ресурс.</p> 
typeId | **string**<br><p>Идентификатор типа диска.</p> 
zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост.</p> 
size | **string** (int64)<br><p>Размер диска в байтах.</p> 
productIds[] | **string**<br><p>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины.</p> <p>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса.</p> <p>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе <a href="/docs/compute/api-ref/Image/create">create</a>.</p> 
status | **string**<br>Текущий статус диска.<br><ul> <li>CREATING: Диск создается.</li> <li>READY: Диск готов к использованию.</li> <li>ERROR: С диском произошла ошибка, блокирующая работу.</li> <li>DELETING: Диск удаляется.</li> </ul> 
instanceIds[] | **string**<br><p>Массив виртуальных машин, к которым подключен диск.</p> 
sourceImageId | **string** <br> включает только одно из полей `sourceImageId`, `sourceSnapshotId`<br><br><p>Идентификатор образа, из которого был создан диск.</p> 
sourceSnapshotId | **string** <br> включает только одно из полей `sourceImageId`, `sourceSnapshotId`<br><br><p>Идентификатор снимка, из которого был создан диск.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает диск в указанном каталоге.
[delete](delete.md) | Удаляет указанный диск.
[get](get.md) | Возвращает указанный ресурс Disk.
[list](list.md) | Возвращает список доступных ресурсов Disk в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций для указанного диска.
[update](update.md) | Изменяет указанный диск.