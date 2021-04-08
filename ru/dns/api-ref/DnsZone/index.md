---
editable: false
---

# DnsZone
Набор методов для управления зонами DNS.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zone": "string",
  "privateVisibility": {
    "networkIds": [
      "string"
    ]
  },
  "publicVisibility": {}
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор зоны DNS. Генерируется при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит зона DNS.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя зоны DNS. Имя должно быть уникальным в каталоге.</p> 
description | **string**<br><p>Описание зоны DNS.</p> 
labels | **object**<br><p>Метки зон DNS в формате `key:value`.</p> 
zone | **string**<br><p>Суффикс зоны DNS.</p> 
privateVisibility | **object**<br><p>Настройки внутренней зоны. Указывают, будут ли записи в зоне видны только из сетей VPC.</p> <p>Конфигурация для внутренних зон.</p> 
privateVisibility.<br>networkIds[] | **string**<br><p>Идентификаторы сетей.</p> <p>Количество элементов должно находиться в диапазоне от 0 до 10. Длина строки в символах должна быть равна 20.</p> 
publicVisibility | **object**<br><p>Настройки публичной зоны. Указывают, являются ли записи в пределах зоны публичными.</p> <p>Конфигурация для публичных зон.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает зону DNS в указанном каталоге.
[delete](delete.md) | Удаляет указанную зону DNS.
[get](get.md) | Возвращает указанную зону DNS.
[getRecordSet](getRecordSet.md) | Возвращает указанный набор записей.
[list](list.md) | Возвращает список зон DNS в указанном каталоге.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа для указанной зоны DNS.
[listOperations](listOperations.md) | Возвращает список операций для указанной зоны DNS.
[listRecordSets](listRecordSets.md) | Возвращает список наборов записей в указанном каталоге.
[setAccessBindings](setAccessBindings.md) | Задает список привязок прав доступа для указанной зоны DNS.
[update](update.md) | Обновляет указанную зону DNS.
[updateAccessBindings](updateAccessBindings.md) | Обновляет привязки прав доступа для указанной зоны DNS.
[updateRecordSets](updateRecordSets.md) | Метод со строгим контролем за изменением состояния зоны. Возвращает ошибку, когда: 1. Удаленная запись не найдена. 2. Найдена запись с совпадающим типом и именем, но другим TTL или значением. 3. Предпринята попытка добавить запись с существующим именем и типом. Сначала происходит удаление. Если запись с одинаковым именем и типом существует в обоих списках, то существующая запись будет удалена, а новая добавлена.
[upsertRecordSets](upsertRecordSets.md) | Метод без строгого контроля за изменением состояния зоны. Если удаленная запись не существует, ничего не происходит. Удаляет записи, соответствующие всем указанным полям, что позволяет удалять только указанные записи из набора записей.