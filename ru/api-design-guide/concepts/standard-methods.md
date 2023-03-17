# Стандартные методы

Ниже перечислены стандартные методы API и соответствующие им HTTP-методы:

Метод API | HTTP-метод | Тело запроса | Тело ответа
----- | ----- | ----- | ----
[Get](#method-get) | GET | — | Представление ресурса.
[List](#method-list) | GET | — | Список ресурсов.
[Create](#method-create) | POST | Представление ресурса. | Объект [Operation](operation.md).
[Update](#method-update) | PATCH | Представление ресурса. | Объект [Operation](operation.md).
[Delete](#method-delete) | DELETE | — |Объект [Operation](operation.md).

Ниже приведены gRPC-описания стандартных методов и рассмотрены примеры соответствующих REST запросов.

## Get {#method-get}

Возвращает представление запрашиваемого ресурса.

Методу соответствует HTTP-метод `GET`.

Пример gRPC-описания метода [Get](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) для получения диска:
```protobuf
 rpc Get (GetDiskRequest) returns (Disk) {
   // Методу Get соответствует HTTP-метод GET.
   option (google.api.http) = {
     get: "/compute/v1/disks/{disk_id}"
   };
 }

 message GetDiskRequest {
   // Идентификатор запрашиваемого диска.
   string disk_id = 1;
 }
```

Пример REST запроса на получение диска:
```
GET https://compute.{{ api-host }}/compute/v1/disks/e0m97h0gbq0foeuis03
```

## List {#method-list}

Выводит список ресурсов определенной категории. Например, список дисков или список виртуальных машин.

На данный момент списки ресурсов можно получать только относительно их непосредственного родителя. Например, вы можете получить список дисков в каком-нибудь каталоге, но не сможете посмотреть список дисков во всем облаке.

Методу `List` соответствует HTTP-метод `GET`. В параметрах запроса необходимо передать идентификатор родительского ресурса, например каталога.

{% include notitle [page-size-field](../_includes/page-size-field.md) %}

Метод `List` поддерживает [постраничное отображение результатов](pagination.md).

Пример gRPC-описания метода [List](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) для получения списка дисков:
```protobuf
 rpc List (ListDisksRequest) returns (ListDisksResponse) {
   // Методу List соответствует HTTP-метод GET.
   option (google.api.http) = {
     get: "/compute/v1/disks"
   };
 }
 message ListDisksRequest {
   // Идентификатор каталога, для которого
   // нужно получить список дисков.
   // Обязательное поле.
   string folder_id = 1;

   // Максимальное количество результатов на странице ответа.
   // Если число возвращаемых результатов
   // больше значения, заданного в page_size, сервис возвращает поле
   // [ListDisksResponse.next_page_token]. Используйте его
   // для получения следующей страницы.
   int64 page_size = 2;

   // Токен запрашиваемой страницы с результатами.
   // Чтобы получить следующую страницу,
   // подставьте в это поле значение из
   // [ListDisksResponse.next_page_token], которое было
   // получено в результате предыдущего запроса List.
   string page_token = 3;
 }

 message ListDisksResponse {
   // Список дисков.
   repeated Disk disks = 1;
   // Токен следующей страницы результатов.
   string next_page_token = 2;
 }
```

Пример получения списка дисков в REST:

```
GET https://compute.{{ api-host }}/compute/v1/disks?folderId=a3s17h9sbq5asdgss12
```


## Create {#method-create}

Создает ресурс в указанном облаке, каталоге, сети и т. д.

Методу `Create` соответствует HTTP-метод `POST`. В качестве параметров необходимо передать идентификатор родительского ресурса, в котором нужно создать ресурс (например, идентификатор каталога).

Метод `Create` имеет асинхронную сигнатуру. Он возвращает объект [Operation](operation.md), который содержит статус операции, а также идентификатор создаваемого ресурса.

{% include notitle [name-description-labels-fields](../_includes/name-description-labels-fields.md) %}

При попытке создать ресурс, который уже существует, метод вернет ошибку `ALREADY_EXISTS`. [Подробнее об ошибках](errors.md)


Пример gRPC-описания метода [Create](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) для создания диска в заданном каталоге:
```protobuf
 rpc Create (CreateDiskRequest) returns (operation.Operation) {
   // Методу Create соответствует HTTP-метод POST.
   option (google.api.http) = {
     post: "/compute/v1/disks" body: "*"
   };
   // В поле `metadata` объекта Operation
   // содержится представление `CreateDiskMetadata`.
   // В случае успешного завершения операции
   // в поле `response` объекта Operation
   // содержится представление дискового ресурса.
   option (yandex.api.operation) = {
     metadata: "CreateDiskMetadata"
     response: "Disk"
   };
 }

 message CreateDiskRequest {
   // Идентификатор каталога, в котором нужно создать диск.
   // Обязательное поле.
   string folder_id = 1;

   // Имя диска.
   string name = 2;

   // Описание диска.
   string description = 3;

   // Метки диска в формате 'ключ: значение'.
   map<string, string> labels = 4;

   // Тип диска.
   string type_id = 5;

   // Идентификатор зоны, в которой нужно создать диск.
   string zone_id = 6;

   // Размер диска в байтах.
   int64 size = 7;

   oneof source {
     // Идентификатор образа, на основе которого нужно создать диск.
     string image_id = 8;

     // либо идентификатор снимка, с которого нужно создать диск.
     string snapshot_id = 9;
   }
 }

 message CreateDiskMetadata {
   // Идентификатор создаваемого диска.
   string disk_id = 1;
 }
```

Пример REST запроса на создание диска:
```
 POST https://compute.{{ api-host }}/compute/v1/disks

 {
   "folderId": "a3s17h9sbq5asdgss12",
   "name": "disk-1",
   "description": "Test disk",
   "zoneId" : "{{ region-id }}-a",
   "typeId" : "network-nvme",
   "size" : 10737418240
 }
```

{% include [create-operation-response](../_includes/create-operation-response.md) %}


## Update {#method-update}

Изменяет представление ресурса. Методу соответствует HTTP-метод `PATCH`.

Метод `Update` поддерживает частичное изменение ресурса. Поля, которые требуется изменить, указываются в запросе в поле `update_mask` ([подробнее](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/field_mask.proto)). Поля, которые не указаны в поле `update_mask`, не будут изменены. Если в запросе не передается `update_mask`, значения всех полей будут обновлены по следующему правилу:

- для полей, указанных в запросе, будут использованы переданные значения;
- значения остальных полей будут сброшены на значения по умолчанию.

Метод имеет асинхронную сигнатуру. Он возвращает объект [Operation](operation.md), который содержит статус операции и представление измененного ресурса.

{% include notitle [name-description-labels-fields](../_includes/name-description-labels-fields.md) %}

Пример gRPC-описания метода [Update](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) для изменения дискового ресурса:
```protobuf
 rpc Update (UpdateDiskRequest) returns (operation.Operation) {
   // Методу Update соответствует HTTP-метод PATCH.
   option (google.api.http) = {
     patch: "/compute/v1/disks/{disk_id}" body: "*"
   };
   // В поле `metadata` объекта Operation
   // содержится представление `UpdateDiskMetadata`.
   // В случае успешного завершения операции
   // в поле `response` объекта Operation
   // содержится представление измененного дискового ресурса.
   option (yandex.api.operation) = {
     metadata: "UpdateDiskMetadata"
     response: "Disk"
   };
 }
 message UpdateDiskRequest {
   // Идентификатор изменяемого диска.
   // Обязательное поле.
   string disk_id = 1;

   // Маска, задающая поля, которые нужно изменить.
   google.protobuf.FieldMask update_mask = 2;

   // Имя диска.
   string name = 3;

   // Описание диска.
   string description = 4;

   // Метки диска в формате 'ключ: значение'.
   map<string, string> labels = 5;

   // Размер диска в байтах.
   int64 size = 6;
 }

 message UpdateDiskMetadata {
   // Идентификатор изменяемого диска.
   string disk_id = 1;
 }
```

Пример REST запроса на изменение дискового ресурса:
```
PATCH https://compute.{{ api-host }}/compute/v1/disks/e0m97h0gbq0foeuis03

 {
   "name": "Новое имя",
   "description": "Новое описание",
   "size": "10737418240",
   "updateMask" : "name,description"
 }
```

В примере будут изменены только поля "name" и "description".

## Delete {#method-delete}

Удаляет заданный ресурс.

Методу `Delete` соответствует HTTP-метод `DELETE`. В параметрах запроса необходимо передать идентификатор ресурса, который требуется удалить.

Метод имеет асинхронную сигнатуру. Он возвращает объект [Operation](operation.md), который содержит статус операции удаления.

Пример gRPC-описания метода [Delete](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) для удаления диска:
```protobuf
 rpc Delete (DeleteDiskRequest) returns (operation.Operation) {
   // Методу соответствует HTTP-метод DELETE.
   option (google.api.http) = {
     delete: "/compute/v1/disks/{disk_id}"
   };
   // В поле `metadata` объекта Operation
   // содержится представление `DeleteDiskMetadata`.
   // В случае успешного завершения операции
   // в поле `response` объекта Operation
   // содержится представление ресурса `google.protobuf.Empty`.
   option (yandex.api.operation) = {
     metadata: "DeleteDiskMetadata"
     response: "google.protobuf.Empty"
   };
 }
 message DeleteDiskRequest {
   // Идентификатор удаляемого диска.
   // Обязательное поле.
   string disk_id = 1;
 }

 message DeleteDiskMetadata {
   // Идентификатор удаляемого диска.
   string disk_id = 1;
 }
```

Пример REST запроса на удаление диска:
```
 DELETE https://compute.{{ api-host }}/compute/v1/disks/e0m97h0gbq0foeuis03
```
