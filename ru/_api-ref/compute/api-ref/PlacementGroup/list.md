---
editable: false
---

# Метод list
Возвращает список групп размещения в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/placementGroups
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Идентификатор каталога для получения списка групп размещения.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/PlacementGroup/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/PlacementGroup/list#responses), которое можно использовать для получения следующей страницы.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/PlacementGroup/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/PlacementGroup/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.
filter | Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [PlacementGroup.name](/docs/compute/api-ref/PlacementGroup#representation).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "placementGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "spreadPlacementStrategy": {}
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
placementGroups[] | **object**<br><p>Выводит список групп размещения для указанного каталога.</p> 
placementGroups[].<br>id | **string**<br><p>Идентификатор группы размещения. Генерируется при создании.</p> 
placementGroups[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит группа размещения.</p> 
placementGroups[].<br>createdAt | **string** (date-time)<br><p>Время создания ресурса.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
placementGroups[].<br>name | **string**<br><p>Имя группы размещения. Имя уникально в рамках каталога.</p> 
placementGroups[].<br>description | **string**<br><p>Описание группы размещения. Длина описания должна быть от 0 до 256 символов.</p> 
placementGroups[].<br>labels | **object**<br><p>Метки групп размещения в формате ``key:value``.</p> 
placementGroups[].<br>spreadPlacementStrategy | **object**<br>Стратегия распределенного размещения (`spread`). Каждая из виртуальных машин в группе расположена на отдельной стойке.<br><p>Это пустая структура, которую необходимо передать для явного указания стратегии размещения.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем [<RequestMessage>.page_size], используйте ``next_page_token`` в качестве значения параметра [<RequestMessage>.page_token] в следующем запросе списка ресурсов.</p> <p>Каждая следующая страница будет иметь свой ``next_page_token`` для продолжения перебора страниц результатов.</p> 