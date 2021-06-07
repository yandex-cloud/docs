---
editable: false
---

# Registry
Набор методов для управления реестрами.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "logGroupId": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор реестра.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит реестр.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Название реестра. Имя уникально в рамках каталога.</p> 
description | **string**<br><p>Описание реестра. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки группы размещения в формате ``key:value``. Максимум 64 метки на ресурс.</p> 
status | **string**<br><p>Статус реестра.</p> <ul> <li>CREATING: Реестр создается.</li> <li>ACTIVE: Реестр готов к использованию.</li> <li>DELETING: Реестр удаляется.</li> </ul> 
logGroupId | **string**<br><p>Идентификатор группы журналов для указанного реестра.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[addCertificate](addCertificate.md) | Добавляет сертификат.
[addPassword](addPassword.md) | Добавляет пароль для указанного реестра.
[create](create.md) | Создает реестр в указанном каталоге.
[delete](delete.md) | Удаляет указанный реестр.
[deleteCertificate](deleteCertificate.md) | Удаляет указанный сертификат реестра.
[deletePassword](deletePassword.md) | Удаляет указанный пароль.
[get](get.md) | Возвращает указанный реестр.
[list](list.md) | Возвращает список реестров в указанном каталоге.
[listCertificates](listCertificates.md) | Возвращает список сертификатов реестра для указанного реестра.
[listDeviceTopicAliases](listDeviceTopicAliases.md) | Возвращает список алиасов устройств для указанного реестра.
[listOperations](listOperations.md) | Возвращает список операций для указанного реестра.
[listPasswords](listPasswords.md) | Возращает список паролей для указанного реестра.
[update](update.md) | Обновляет указанный реестр.