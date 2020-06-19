---
editable: false
---

# Метод listCertificates
Возвращает список сертификатов для указанного устройства.
 

 
## HTTP-запрос {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/devices/{deviceId}/certificates
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
deviceId | Обязательное поле. Идентификатор устройства для получения списка сертификатов.  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "certificates": [
    {
      "deviceId": "string",
      "fingerprint": "string",
      "certificateData": "string",
      "createdAt": "string"
    }
  ]
}
```

 
Поле | Описание
--- | ---
certificates[] | **object**<br><p>Сертификат устройства. Дополнительные сведения см. в разделе <a href="/docs/iot-core/operations/certificates/device-certificates">Управление сертификатами устройства</a>.</p> 
certificates[].<br>deviceId | **string**<br><p>Идентификатор устройства, которому принадлежит сертификат.</p> 
certificates[].<br>fingerprint | **string**<br><p>SHA256-хэш сертификата.</p> 
certificates[].<br>certificateData | **string**<br><p>Публичная часть сертификата устройства.</p> 
certificates[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 