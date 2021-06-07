---
editable: false
---

# Метод list
Возвращает список API-шлюзов в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://serverless-apigateway.api.cloud.yandex.net/apigateways/v1/apigateways
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка API-шлюзов.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `pageSize` , сервис вернет значение [nextPageToken](/docs/api-gateway/api-ref/ApiGateway/list#responses), которое можно использовать для получения следующей страницы.  Значение по умолчанию: 100.
pageToken | Токен страницы. Установите значение `pageToken` равным значению поля [nextPageToken](/docs/api-gateway/api-ref/ApiGateway/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.
filter | Выражение фильтра, для фильтрации списка функций в ответе.  В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [ApiGateway.name](/docs/api-gateway/api-ref/ApiGateway#representation). 2. Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-apigw`.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "apiGateways": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "domain": "string",
      "logGroupId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
apiGateways[] | **object**<br><p>Возвращает список API-шлюзов в указанном каталоге.</p> 
apiGateways[].<br>id | **string**<br><p>Идентификатор API-шлюза. Генерируется при создании.</p> 
apiGateways[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит API-шлюз.</p> 
apiGateways[].<br>createdAt | **string** (date-time)<br><p>Время создания API-шлюза.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
apiGateways[].<br>name | **string**<br><p>Имя API-шлюза. Имя уникально в рамках каталога.</p> 
apiGateways[].<br>description | **string**<br><p>Описание API-шлюза.</p> 
apiGateways[].<br>labels | **object**<br><p>Метки API-шлюза в формате ``key:value`` .</p> 
apiGateways[].<br>status | **string**<br><p>Состояние API-шлюза.</p> <ul> <li>CREATING: API-шлюз создается.</li> <li>ACTIVE: API-шлюз готов к использованию.</li> <li>DELETING: API-шлюз удаляется.</li> <li>ERROR: Сбой API-шлюза. Единственное разрешенное действие c API-шлюзом — удаление.</li> </ul> 
apiGateways[].<br>domain | **string**<br><p>Домен по умолчанию для API-шлюза. Генерируется при создании.</p> 
apiGateways[].<br>logGroupId | **string**<br><p>Идентификатор группы журналов выполнения для API-шлюза.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/api-gateway/api-ref/ApiGateway/list#query_params">pageSize</a>, используйте ``nextPageToken`` в качестве значения параметра <a href="/docs/api-gateway/api-ref/ApiGateway/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Каждая следующая страница будет иметь свой ``nextPageToken`` для продолжения перебора страниц результатов.</p> 