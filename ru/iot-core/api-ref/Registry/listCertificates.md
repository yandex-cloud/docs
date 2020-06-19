---
editable: false
---

# Метод listCertificates
Возвращает список сертификатов реестра для указанного реестра.
 

 
## HTTP-запрос {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/registries/{registryId}/certificates
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
registryId | Обязательное поле. Идентификатор реестра для получения списка сертификатов.  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "certificates": [
    {
      "registryId": "string",
      "fingerprint": "string",
      "certificateData": "string",
      "createdAt": "string"
    }
  ]
}
```

 
Поле | Описание
--- | ---
certificates[] | **object**<br><p>Сертификат реестра. Дополнительные сведения см. в разделе <a href="/docs/iot-core/operations/certificates/registry-certificates">Управление сертификатами реестра</a>.</p> 
certificates[].<br>registryId | **string**<br><p>Идентификатор реестра, к которому принадлежит сертификат.</p> 
certificates[].<br>fingerprint | **string**<br><p>SHA256-хэш сертификата.</p> 
certificates[].<br>certificateData | **string**<br><p>Публичная часть сертификата устройства.</p> 
certificates[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 