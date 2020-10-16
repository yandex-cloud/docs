---
editable: false
---

# Метод get
Возвращает цепочку сертификатов доверия и закрытый ключ указанного сертификата.
 

 
## HTTP-запрос {#https-request}
```
GET https://data.certificate-manager.api.cloud.yandex.net/certificate-manager/v1/certificates/{certificateId}:getContent
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
certificateId | Идентификатор сертификата для загрузки контента.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "certificateId": "string",
  "certificateChain": [
    "string"
  ],
  "privateKey": "string"
}
```

 
Поле | Описание
--- | ---
certificateId | **string**<br><p>Идентификатор сертификата.</p> 
certificateChain[] | **string**<br><p>Содержимое цепочки сертификатов доверия сертификата в PEM-encoded формате.</p> 
privateKey | **string**<br><p>Содержимое закрытого ключа сертификата в PEM-encoded формате.</p> 