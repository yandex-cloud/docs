---
editable: false
---

# Метод list
Возвращает список доступных адресов в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/addresses
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит адрес.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов  больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/vpc/api-ref/Address/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/vpc/api-ref/Address/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации адресов в ответе.  В параметрах фильтрации указываются:  1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Address.name](/docs/vpc/api-ref/Address#representation).  2. Оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.  Пример фильтра: "name=my-address".
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "addresses": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "reserved": true,
      "used": true,
      "externalIpv4Address": {
        "address": "string",
        "zoneId": "string",
        "requirements": {
          "ddosProtectionProvider": "string",
          "outgoingSmtpCapability": "string"
        }
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
addresses[] | **object**<br><p>Ресурс Адрес. Подробнее см. <a href="/docs/vpc/concepts/address">документацию</a>.</p> 
addresses[].<br>id | **string**<br><p>Идентификатор адреса. Генерируется при создании.</p> 
addresses[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит адрес.</p> 
addresses[].<br>createdAt | **string** (date-time)<br><p>Время создания ресурса.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
addresses[].<br>name | **string**<br><p>Имя адреса. Имя должно быть уникальным в каталоге.</p> 
addresses[].<br>description | **string**<br><p>Описание адреса.</p> 
addresses[].<br>labels | **object**<br><p>Метки адреса в формате ``ключ:значение``.</p> 
addresses[].<br>reserved | **boolean** (boolean)<br><p>Определяет, зарезервирован ли адрес (статический ли он).</p> 
addresses[].<br>used | **boolean** (boolean)<br><p>Определяет, используется ли адрес.</p> 
addresses[].<br>externalIpv4Address | **object**<br>
addresses[].<br>externalIpv4Address.<br>address | **string**<br><p>Значение адреса.</p> 
addresses[].<br>externalIpv4Address.<br>zoneId | **string**<br><p>Зона доступности, из которой будет выделен адрес.</p> 
addresses[].<br>externalIpv4Address.<br>requirements | **object**<br><p>Параметры выделяемого адреса, например защита от DDoS-атак.</p> 
addresses[].<br>externalIpv4Address.<br>requirements.<br>ddosProtectionProvider | **string**<br><p>Идентификатор провайдера защиты от DDoS-атак.</p> 
addresses[].<br>externalIpv4Address.<br>requirements.<br>outgoingSmtpCapability | **string**<br><p>Возможность отправки SMTP-трафика.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/vpc/api-ref/Address/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/vpc/api-ref/Address/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Каждая следующая страница будет иметь свой ``next_page_token`` для продолжения перебора страниц результатов.</p> 