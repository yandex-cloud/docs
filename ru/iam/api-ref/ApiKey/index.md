---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# ApiKey
A set of methods for managing API keys.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the API Key.</p> 
serviceAccountId | **string**<br><p>ID of the service account that the API key belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
description | **string**<br><p>Description of the API key. 0-256 characters long.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates an API key for the specified service account.
[delete](delete.md) | Deletes the specified API key.
[get](get.md) | Returns the specified API key.
[list](list.md) | Retrieves the list of API keys for the specified service account.
[listOperations](listOperations.md) | Retrieves the list of operations for the specified API key.
[update](update.md) | Updates the specified API key.