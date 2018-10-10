# Стандартные методы

Стандартные методы позволяют выполнять над ресурсами CRUD-операции: создавать, получать,
 изменять и удалять. Стандартные методы имеют одинаковую сигнатуру и для всех API работают
 одинаково.

Ниже перечислены стандартные методы API:

Метод API | Соответствующий HTTP-глагол | Тело ответа
----- | ----- | -----
[get](#method-get) | GET <[URL ресурса](resources-structure.md#url-resource)> | Представление ресурса.
[list](#method-list) | GET <[URL для просмотра списка ресурсов](resources-structure.md#listing)> | Список ресурсов.
[create](#method-create) | POST <[URL для просмотра списка ресурсов](resources-structure.md#listing)> | Объект [Operation](operation.md).
[update](#method-update) | PATCH <[URL ресурса](resources-structure.md#url-resource)> | Объект [Operation](operation.md).
[delete](#method-delete) | DELETE <[URL ресурса](resources-structure.md#url-resource)> | Объект [Operation](operation.md).

## get {#method-get}

Возвращает представление запрашиваемого ресурса.

>Пример получения диска:
>
>```
>GET https://compute.api.cloud.yandex.net/compute/v1/disks/e0m97h0gbq0foeuis03
>```

## list {#method-list}

Выводит список ресурсов определенной категории.

>Пример получения списка дисков в каталоге:
>
>```
>GET https://compute.api.cloud.yandex.net/compute/v1/disks?folderId=a3s17h9sbq5asdgss12
>```

Метод `list` поддерживает постраничное отображение результатов. Подробнее см. в разделе [Пагинация](pagination.md).


## create {#method-create}

Создает ресурс.

>Пример создания диска:
>
>```
>POST https://compute.api.cloud.yandex.net/compute/v1/disks
>
>{
>  "folderId": "a3s17h9sbq5asdgss12",
>  "name": "disk-1",
>  "description": "Test disk",
>  "zoneId" : "ru-central1-a",
>  "typeId" : "network-nvme",
>  "size" : 10737418240   
>}
>```

Метод `create` имеет асинхронную сигнатуру. Сервер возвращает объект [Operation](operation.md), который содержит статус операции.

При вызове операции `create` объект `Operation` гарантированно будет содержать идентификатор
 создаваемого ресурса, даже если операция еще не была завершена. По этому идентификатору вы
  сможете обратиться к ресурсу и проверить его состояние. Если ресурс еще не готов, его представление
   будет содержать поле `status`. Оно будет отображать текущее состояние ресурса
  (например, <q>CREATING</q>).

## update {#method-update}

Изменяет представление ресурса. Поддерживается частичное изменение ресурса (то есть изменение отдельных его полей).

>Пример изменения поля `description` у диска:
>
>```
>PATCH https://compute.api.cloud.yandex.net/compute/v1/disks/e0m97h0gbq0foeuis03
>
>{
>   "description": "Новое описание"
>}
>```
Метод `update` имеет асинхронную сигнатуру. Он возвращает объект [Operation](operation.md), который содержит статус
 операции.
## delete {#method-delete}

Удаляет ресурс.

>Пример удаления диска:
>
>```
>DELETE https://compute.api.cloud.yandex.net/compute/v1/disks/e0m97h0gbq0foeuis03
>```

Метод `delete` имеет асинхронную сигнатуру. Он возвращает объект [Operation](operation.md), который содержит статус операции.

