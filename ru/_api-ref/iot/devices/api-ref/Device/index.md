---
editable: false
---

# Device
Набор методов для управления устройствами.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "registryId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "topicAliases": "object"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор устройства.</p> 
registryId | **string**<br><p>Идентификатор реестра, к которому принадлежит устройство.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя устройства. Имя является уникальным в рамках реестра.</p> 
description | **string**<br><p>Описание устройства. Длина описания должна быть от 0 до 256 символов.</p> 
topicAliases | **object**<br><p>Алиас топика устройства.</p> <p>Алиас — это альтернативное имя топика устройства, назначенное пользователем. Алиас сопоставляется со стандартным топиком, например ``my/custom/alias`` эквивалентен ``$device/abcdef/events``.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[addCertificate](addCertificate.md) | Добавляет сертификат.
[addPassword](addPassword.md) | Добавляет пароль для указанного устройства.
[create](create.md) | Создает устройство в указанном реестре.
[delete](delete.md) | Удаляет указанное устройство.
[deleteCertificate](deleteCertificate.md) | Удаляет указанное устройство.
[deletePassword](deletePassword.md) | Удаляет указанный пароль.
[get](get.md) | Возвращает указанное устройство.
[list](list.md) | Возвращает список устройств в указанном реестре.
[listCertificates](listCertificates.md) | Возвращает список сертификатов для указанного устройства.
[listOperations](listOperations.md) | Возвращает список операций для указанного устройства.
[listPasswords](listPasswords.md) | Возвращает список паролей для указанного устройства.
[update](update.md) | Обновляет указанное устройство.