---
editable: false
---

# Метод list
Возвращает список сертификатов для указанной федерации.
 

 
## HTTP-запрос {#https-request}
```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/certificates
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
federationId | Обязательное поле. Идентификатор федерации для получения списка сертификатов. Чтобы получить идентификатор федерации, используйте запрос [list](/docs/organization-manager/api-ref/Federation/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/organization-manager/api-ref/Certificate/list#query_params) , сервис вернет значение [nextPageToken](/docs/organization-manager/api-ref/Certificate/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/organization-manager/api-ref/Certificate/list#query_params) равным значению поля [nextPageToken](/docs/organization-manager/api-ref/Certificate/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Certificate.name](/docs/organization-manager/api-ref/Certificate#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "certificates": [
    {
      "id": "string",
      "federationId": "string",
      "name": "string",
      "description": "string",
      "createdAt": "string",
      "data": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
certificates[] | **object**<br><p>Сертификат.</p> 
certificates[].<br>id | **string**<br><p>Обязательное поле. Идентификатор сертификата.</p> <p>Максимальная длина строки в символах — 50.</p> 
certificates[].<br>federationId | **string**<br><p>Обязательное поле. Идентификатор федерации, которой принадлежит сертификат.</p> <p>Максимальная длина строки в символах — 50.</p> 
certificates[].<br>name | **string**<br><p>Имя сертификата.</p> <p>Значение должно соответствовать регулярному выражению `` \|[a-z][-a-z0-9]{1,61}[a-z0-9] ``.</p> 
certificates[].<br>description | **string**<br><p>Описание сертификата. Длина описания должна быть от 0 до 256 символов.</p> <p>Максимальная длина строки в символах — 256.</p> 
certificates[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
certificates[].<br>data | **string**<br><p>Обязательное поле. Данные сертификата в формате PEM.</p> <p>Максимальная длина строки в символах — 32000.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/organization-manager/api-ref/Certificate/list#query_params">pageSize</a>, используйте <a href="/docs/organization-manager/api-ref/Certificate/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/organization-manager/api-ref/Certificate/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/organization-manager/api-ref/Certificate/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 