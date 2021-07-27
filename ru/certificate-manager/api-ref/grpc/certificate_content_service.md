---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# CertificateContentService

A set of methods for managing certificate content.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns chain and private key of the specified certificate. |

## Calls CertificateContentService {#calls}

## Get {#Get}

Returns chain and private key of the specified certificate.

**rpc Get ([GetCertificateContentRequest](#GetCertificateContentRequest)) returns ([GetCertificateContentResponse](#GetCertificateContentResponse))**

### GetCertificateContentRequest {#GetCertificateContentRequest}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate to download content. 


### GetCertificateContentResponse {#GetCertificateContentResponse}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate. 
certificate_chain[] | **string**<br>PEM-encoded certificate chain content of the certificate. 
private_key | **string**<br>PEM-encoded private key content of the certificate. 


