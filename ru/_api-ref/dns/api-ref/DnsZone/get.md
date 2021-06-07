---
editable: false
---

# Метод get
Возвращает указанную зону DNS.
 
Чтобы получить список доступных зон, используйте запрос [list](/docs/dns/api-ref/DnsZone/list).
 
## HTTP-запрос {#https-request}
```
GET https://dns.api.cloud.yandex.net/dns/v1/zones/{dnsZoneId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
dnsZoneId | Обязательное поле. Идентификатор возвращаемой зоны DNS.  Чтобы получить идентификатор зоны DNS, выполните запрос [list](/docs/dns/api-ref/DnsZone/list).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

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
Зона DNS. Подробнее см. в разделе [Зоны DNS](/docs/dns/concepts/dns-zone).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор зоны DNS. Генерируется при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит зона DNS.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя зоны DNS. Имя должно быть уникальным в каталоге.</p> 
description | **string**<br><p>Описание зоны DNS.</p> 
labels | **object**<br><p>Метки зон DNS в формате ``key:value``.</p> 
zone | **string**<br><p>Суффикс зоны DNS.</p> 
privateVisibility | **object**<br><p>Настройки внутренней зоны. Указывают, будут ли записи в зоне видны только из сетей VPC.</p> <p>Конфигурация для внутренних зон.</p> 
privateVisibility.<br>networkIds[] | **string**<br><p>Идентификаторы сетей.</p> <p>Количество элементов должно находиться в диапазоне от 0 до 10. Длина строки в символах должна быть равна 20.</p> 
publicVisibility | **object**<br><p>Настройки публичной зоны. Указывают, являются ли записи в пределах зоны публичными.</p> <p>Конфигурация для публичных зон.</p> 