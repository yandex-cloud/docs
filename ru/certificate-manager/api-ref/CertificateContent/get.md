---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method get
Returns chain and private key of the specified certificate.
 

 
## HTTP request {#https-request}
```
GET https://data.certificate-manager.api.cloud.yandex.net/certificate-manager/v1/certificates/{certificateId}:getContent
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
certificateId | ID of the certificate to download content.
 
## Response {#responses}
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

 
Field | Description
--- | ---
certificateId | **string**<br><p>ID of the certificate.</p> 
certificateChain[] | **string**<br><p>PEM-encoded certificate chain content of the certificate.</p> 
privateKey | **string**<br><p>PEM-encoded private key content of the certificate.</p> 