---
editable: false
---

# Метод list
Возвращает список зон DNS в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://dns.api.cloud.yandex.net/dns/v1/zones
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка зон DNS.   Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/dns/api-ref/DnsZone/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/dns/api-ref/DnsZone/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 1000.
filter | Параметры фильтрации зон DNS в ответе.  В параметрах фильтрации указываются:  1. Имя поля. Фильтрация осуществляется только по полю [DnsZone.name](/docs/dns/api-ref/DnsZone#representation).  2. Оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. 3. Значение или списки значений. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=my-dns-zone`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "dnsZones": [
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
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
dnsZones[] | **object**<br><p>Зона DNS. Подробнее см. в разделе <a href="/docs/dns/concepts/dns-zone">Зоны DNS</a>.</p> 
dnsZones[].<br>id | **string**<br><p>Идентификатор зоны DNS. Генерируется при создании.</p> 
dnsZones[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит зона DNS.</p> 
dnsZones[].<br>createdAt | **string** (date-time)<br><p>Время создания ресурса.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
dnsZones[].<br>name | **string**<br><p>Имя зоны DNS. Имя должно быть уникальным в каталоге.</p> 
dnsZones[].<br>description | **string**<br><p>Описание зоны DNS.</p> 
dnsZones[].<br>labels | **object**<br><p>Метки зон DNS в формате `key:value`.</p> 
dnsZones[].<br>zone | **string**<br><p>Суффикс зоны DNS.</p> 
dnsZones[].<br>privateVisibility | **object**<br><p>Настройки внутренней зоны. Указывают, будут ли записи в зоне видны только из сетей VPC.</p> <p>Конфигурация для внутренних зон.</p> 
dnsZones[].<br>privateVisibility.<br>networkIds[] | **string**<br><p>Идентификаторы сетей.</p> <p>Количество элементов должно находиться в диапазоне от 0 до 10. Длина строки в символах должна быть равна 20.</p> 
dnsZones[].<br>publicVisibility | **object**<br><p>Настройки публичной зоны. Указывают, являются ли записи в пределах зоны публичными.</p> <p>Конфигурация для публичных зон.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/dns/api-ref/DnsZone/list#query_params">pageSize</a>, используйте `next_page_token` в качестве значения параметра <a href="/docs/dns/api-ref/DnsZone/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов.</p> 