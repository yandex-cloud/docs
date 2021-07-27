---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# ServiceAccount
A set of methods for managing ServiceAccount resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the service account.</p> 
folderId | **string**<br><p>ID of the folder that the service account belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the service account. The name is unique within the cloud. 3-63 characters long.</p> 
description | **string**<br><p>Description of the service account. 0-256 characters long.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a service account in the specified folder.
[delete](delete.md) | Deletes the specified service account.
[get](get.md) | Returns the specified ServiceAccount resource.
[list](list.md) | Retrieves the list of ServiceAccount resources in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the specified service account.
[listOperations](listOperations.md) | Lists operations for the specified service account.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the service account.
[update](update.md) | Updates the specified service account.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified service account.