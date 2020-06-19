---
editable: false
---

# Метод listPasswords
Возвращает список паролей для указанного устройства.
 

 
## HTTP-запрос {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/devices/{deviceId}/passwords
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
deviceId | Обязательное поле. Идентификатор реестра для получения списка паролей.  Чтобы получить идентификатор реестра, используйте запрос [list](/docs/iot-core/api-ref/Registry/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "passwords": [
    {
      "deviceId": "string",
      "id": "string",
      "createdAt": "string"
    }
  ]
}
```

 
Поле | Описание
--- | ---
passwords[] | **object**<br><p>Пароль устройства.</p> 
passwords[].<br>deviceId | **string**<br><p>Идентификатор устройства, которому принадлежит пароль.</p> 
passwords[].<br>id | **string**<br><p>Идентификатор пароля.</p> 
passwords[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 