# Пагинация

Некоторые методы API поддерживают _пагинацию_. Пагинация — это свойство, при котором
 сервер возвращает не все результаты сразу, а частями, по страницам. В основном пагинация
 используется для метода получения списков — [list](standard-methods.md#method-list).

Чтобы получить нужную страницу с результатами, в запросе следует передать query-параметры:

`pageToken` — токен страницы с результатами. Токен
 следующей страницы можно получить в поле `nextPageToken` при
 получении списка ресурсов (см. пример ниже).

`pageSize` — количество результатов на странице. Доступные
 значения: от 0 до 1000. Значение по умолчанию: 100.

>В качестве примера отправим запрос на получение списка каталогов в облаке:
>
>```
>GET https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders?cloudId=de0m97h0gbq0foeuis03&pageToken=1acdeb26078146e6
>```
>
>Ответ:
>
>```json
>{
>  "folders": [
>    {
>      "cloudId": "de0m97h0gbq0foeuis03",
>      "createdAt": "2018-08-09T12:54:53+00:00",
>      "id": "de019dv504rmhoinn3nk",
>      "name": "development"
>    },
>    {
>      "cloudId": "de0m97h0gbq0foeuis03",
>      "createdAt": "2018-08-14T12:35:13+00:00",
>      "id": "de01v8kst15lr4hrdick",
>      "name": "testing"
>    },
>    {
>      "cloudId": "de0m97h0gbq0foeuis03",
>      "createdAt": "2018-08-01T10:17:40+00:00",
>      "id": "de0235a45kkir11u5ch6",
>      "name": "production"
>    },
>    {
>      "cloudId": "de0m97h0gbq0foeuis03",
>      "createdAt": "2018-08-08T15:01:20+00:00",
>      "id": "de02dhitorbth8bkl5pk",
>      "name": "prestable"
>    }
>  ],
>  "nextPageToken": "ae08rgjd5smu4bq5n1o4"
>}
>```

