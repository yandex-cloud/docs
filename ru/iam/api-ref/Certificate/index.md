---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Certificate
A set of methods for managing certificates.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "federationId": "string",
  "name": "string",
  "description": "string",
  "createdAt": "string",
  "data": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the certificate.</p> <p>The maximum string length in characters is 50.</p> 
federationId | **string**<br><p>Required. ID of the federation that the certificate belongs to.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the certificate.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Description of the certificate.</p> <p>The maximum string length in characters is 256.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
data | **string**<br><p>Required. Certificate data in PEM format.</p> <p>The maximum string length in characters is 32000.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a certificate in the specified federation.
[delete](delete.md) | Deletes the specified certificate.
[get](get.md) | Returns the specified certificate.
[list](list.md) | Retrieves the list of certificates in the specified federation.
[listOperations](listOperations.md) | Lists operations for the specified certificate.
[update](update.md) | Updates the specified certificate.