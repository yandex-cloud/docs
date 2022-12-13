---
editable: false
---

# Certificate Manager API, gRPC: CertificateContentService

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
version_id | **string**<br>Optional ID of the version. 
private_key_format | enum **PrivateKeyFormat**<br>Desired format of private key 


### GetCertificateContentResponse {#GetCertificateContentResponse}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate. 
certificate_chain[] | **string**<br>PEM-encoded certificate chain content of the certificate. 
private_key | **string**<br>PEM-encoded private key content of the certificate. 


