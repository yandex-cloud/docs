# Метод get
Возвращает указанный ресурс Zone.
 
Чтобы получить список доступных ресурсов Zone, используйте
запрос [list](/docs/compute/api-ref/Zone/list).
 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/zones/{zoneId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
zoneId | Обязательное поле. Идентификатор возвращаемого ресурса Zone.  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Zone. Подробнее см. [Зоны доступности](/docs/gen-ref/concepts/geo-scope).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор зоны доступности.</p> 
regionId | **string**<br><p>Идентификатор региона.</p> 
status | **string**<br><p>Статус зоны доступности.</p> <ul> <li>UP: Зона доступна. Вы можете обращаться к ресурсам в этой зоне.</li> <li>DOWN: Зона недоступна.</li> </ul> 