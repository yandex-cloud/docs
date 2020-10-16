---
editable: false
---

# CertificateContentService

Набор методов для управления содержимым сертификата.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает цепочку сертификатов доверия и закрытый ключ указанного сертификата. |

## Вызовы CertificateContentService {#calls}

## Get {#Get}

Возвращает цепочку сертификатов доверия и закрытый ключ указанного сертификата.

**rpc Get ([GetCertificateContentRequest](#GetCertificateContentRequest)) returns ([GetCertificateContentResponse](#GetCertificateContentResponse))**

### GetCertificateContentRequest {#GetCertificateContentRequest}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор сертификата для загрузки контента. 


### GetCertificateContentResponse {#GetCertificateContentResponse}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор сертификата. 
certificate_chain[] | **string**<br>Содержимое цепочки сертификатов доверия сертификата в PEM-encoded формате. 
private_key | **string**<br>Содержимое закрытого ключа сертификата в PEM-encoded формате. 


