---
editable: false
---

# Метод get
Возвращает сведения об указанной зоне доступности.
 
Чтобы получить список зон доступности, выполните запрос [list](/docs/compute/api-ref/Zone/list).
 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/zones/{zoneId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
zoneId | Обязательное поле. Идентификатор зоны доступности для получения сведений.  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "regionId": "string",
  "status": "string"
}
```
Зона доступности. Дополнительные сведения см. в разделе [Зоны доступности](/docs/overview/concepts/geo-scope).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор зоны.</p> 
regionId | **string**<br><p>Идентификатор региона.</p> 
status | **string**<br><p>Статус зоны доступности.</p> <ul> <li>UP: Зона доступна. Вы можете обращаться к ресурсам в этой зоне.</li> <li>DOWN: Зона недоступна.</li> </ul> 