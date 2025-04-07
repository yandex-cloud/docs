---
title: Пагинация в API
description: Из статьи вы узнаете про свойство пагинации, а также ознакомитесь с примерами использования.
---

# Пагинация

Некоторые методы API поддерживают _пагинацию_. Пагинация — это свойство, при котором сервер возвращает не все результаты сразу, а частями, по страницам. В основном пагинация используется для метода получения списков — `List*`.

Чтобы получить нужную страницу с результатами, в запросе следует передать параметры:

- `page_token` — токен страницы с результатами. Токен следующей страницы можно получить в поле `next_page_token` при получении списка ресурсов (см. пример ниже).

- `page_size` — количество результатов на странице. Доступные значения: от 0 до 1000. Значение по умолчанию: 100.

## Примеры {#examples}

### gRPC

gRPC-описание метода [List](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) для дисков:
```protobuf
 // Метод возвращает список дисков в заданном каталоге.
 rpc List (ListDisksRequest) returns (ListDisksResponse) {
   option (google.api.http) = { get: "/compute/v1/disks" };
 }
 message ListDisksRequest {
   // Идентификатор каталога.
   // Обязательное поле.
   string folder_id = 1;

   // Максимальное количество результатов на странице.
   int64 page_size = 2;

   // Токен запрашиваемой страницы с результатами.
   string page_token = 3;
 }

 message ListDisksResponse {
   // Список дисков.
   repeated Disk disks = 1;

   // Токен следующей страницы.
   string next_page_token = 2;
 }
```

### REST

Пример REST запроса на получение списка дисков в каталоге:

```http
GET https://compute.{{ api-host }}/compute/v1/disks?folderId=a3s17h9sbq5asdgss12&pageToken=1acdeb26078146e6
```

Ответ:

```json
{
  "disks": [
    {
      "folderId": "de0m97h0gbq0foeuis03",
      "createdAt": "2018-08-09T12:54:53+00:00",
      "id": "de019dv504rmhoinn3nk",
      "name": "development",
      "zoneId" : "{{ region-id }}-a",
      "typeId" : "network-nvme",
      "size" : 5368709120 
    },
    ...
  ],
  "nextPageToken": "ae08rgjd5smu4bq5n1o4"
}
```
