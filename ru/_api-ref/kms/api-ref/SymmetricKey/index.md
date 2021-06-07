---
editable: false
---

# SymmetricKey
Набор методов для управления симметричными ключами KMS.
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
  "primaryVersion": {
    "id": "string",
    "keyId": "string",
    "status": "string",
    "algorithm": "string",
    "createdAt": "string",
    "primary": true,
    "destroyAt": "string"
  },
  "defaultAlgorithm": "string",
  "rotatedAt": "string",
  "rotationPeriod": "string",
  "deletionProtection": true
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор ключа.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит ключ.</p> 
createdAt | **string** (date-time)<br><p>Время создания ключа.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя симметричного ключа.</p> 
description | **string**<br><p>Описание симметричного ключа.</p> 
labels | **object**<br><p>Пользовательские метки для ключа в виде пар ``key:value``. Максимум 64 на ключ.</p> 
status | **string**<br><p>Текущий статус ключа.</p> <ul> <li>CREATING: Ключ создается.</li> <li>ACTIVE: Ключ активен и может использоваться для шифрования и дешифрования. Можно установить в INACTIVE с помощью метода <a href="/docs/kms/api-ref/SymmetricKey/update">update</a>.</li> <li>INACTIVE: Ключ неактивен и не может быть использован. Можно установить в ACTIVE с помощью метода <a href="/docs/kms/api-ref/SymmetricKey/update">update</a>.</li> </ul> 
primaryVersion | **object**<br><p>Основная версия ключа, используемая по умолчанию для всех операций шифрования, когда идентификатор версии не указан явно.</p> <p>Версия симметричного ключа KMS: метаданные криптографического материала.</p> 
primaryVersion.<br>id | **string**<br><p>Идентификатор версии ключа.</p> 
primaryVersion.<br>keyId | **string**<br><p>Идентификатор симметричного ключа KMS, которому принадлежит версия.</p> 
primaryVersion.<br>status | **string**<br><p>Состояние версии ключа.</p> <p>Возможные статусы версии.</p> <ul> <li>ACTIVE: Версия активна и может использоваться для шифрования и дешифрования.</li> <li>SCHEDULED_FOR_DESTRUCTION: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле ``destroyAt``.</li> <li>DESTROYED: Версия уничтожена и не может быть восстановлена.</li> </ul> 
primaryVersion.<br>algorithm | **string**<br><p>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования.</p> <p>Поддерживаемые алгоритмы симметричного шифрования.</p> <ul> <li>AES_128: Алгоритм AES со 128-битными ключами.</li> <li>AES_192: Алгоритм AES с 192-битными ключами.</li> <li>AES_256: Алгоритм AES с 256-битными ключами.</li> </ul> 
primaryVersion.<br>createdAt | **string** (date-time)<br><p>Время создания версии ключа.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
primaryVersion.<br>primary | **boolean** (boolean)<br><p>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа.</p> 
primaryVersion.<br>destroyAt | **string** (date-time)<br><p>Время, когда версия ключа будет уничтожена. Пустой, если статус не ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
defaultAlgorithm | **string**<br><p>Алгоритм шифрования по умолчанию, который следует использовать с новыми версиями ключа.</p> <p>Поддерживаемые алгоритмы симметричного шифрования.</p> <ul> <li>AES_128: Алгоритм AES со 128-битными ключами.</li> <li>AES_192: Алгоритм AES с 192-битными ключами.</li> <li>AES_256: Алгоритм AES с 256-битными ключами.</li> </ul> 
rotatedAt | **string** (date-time)<br><p>Время последней ротации ключа (время, когда была создана последняя версия). Пустое, если у ключа еще нет версий.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
rotationPeriod | **string**<br><p>Период времени между автоматическими ротациями ключа.</p> 
deletionProtection | **boolean** (boolean)<br><p>Флаг, запрещающий удаление ключа</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[cancelVersionDestruction](cancelVersionDestruction.md) | Отменяет ранее запланированное уничтожение версии, если версия еще не была уничтожена.
[create](create.md) | Создает симметричный ключ KMS в указанном каталоге.
[delete](delete.md) | Удаляет указанный симметричный ключ KMS. Это действие также автоматически планирует уничтожение всех версий ключа через 72 часа.
[get](get.md) | Возвращает указанный симметричный ключ KMS.
[list](list.md) | Возвращает список симметричных ключей KMS в указанном каталоге.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа для указанного симметричного ключа KMS.
[listOperations](listOperations.md) | Возвращет список операций для указанного симметричного ключа KMS.
[listVersions](listVersions.md) | Возвращает список версий указанного симметричного ключа KMS.
[rotate](rotate.md) | Ротирует указанный ключ: создает новую версию ключа и делает ее основной. Старая версия остается доступной для расшифровки зашифрованных с ее помощью данных.
[scheduleVersionDestruction](scheduleVersionDestruction.md) | Планирует уничтожение указанной версии ключа.
[setAccessBindings](setAccessBindings.md) | Устанавливает привязки прав доступа для указанного симметричного ключа KMS.
[setPrimaryVersion](setPrimaryVersion.md) | Задает основную версию для указанного ключа. Основная версия используется по умолчанию для всех операций шифрования / дешифрования, в которых не указан идентификатор версии.
[update](update.md) | Изменяет указанный симметричный ключ KMS.
[updateAccessBindings](updateAccessBindings.md) | Обновляет привязки прав доступа для указанного симметричного ключа KMS.