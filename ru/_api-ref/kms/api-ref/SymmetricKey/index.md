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
  "rotationPeriod": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор ключа.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит ключ.</p> 
createdAt | **string** (date-time)<br><p>Время создания ключа.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя симметричного ключа.</p> 
description | **string**<br><p>Описание симметричного ключа.</p> 
labels | **object**<br><p>Пользовательские метки для ключа в виде пар <code>key:value</code>. Максимум 64 на ключ.</p> 
status | **string**<br><p>Текущий статус ключа.</p> <ul> <li>CREATING: Ключ создается.</li> <li>ACTIVE: Ключ активен и может использоваться для шифрования и дешифрования.</li> <li>INACTIVE: Ключ неактивен и не может быть использован.</li> </ul> 
primaryVersion | **object**<br><p>Основная версия ключа, используемая по умолчанию для всех операций шифрования / дешифрования, если идентификатор версии не указан явно.</p> <p>Версия ключа KMS: метаданные криптографического материала.</p> 
primaryVersion.<br>id | **string**<br><p>Идентификатор версии ключа.</p> 
primaryVersion.<br>keyId | **string**<br><p>Идентификатор ключа KMS, которому принадлежит версия.</p> 
primaryVersion.<br>status | **string**<br><p>Состояние версии ключа.</p> <p>Возможные статусы версии.</p> <ul> <li>ACTIVE: Версия активна и может использоваться для шифрования и дешифрования.</li> <li>SCHEDULED_FOR_DESTRUCTION: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле destroyAt.</li> <li>DESTROYED: Версия уничтожена и не может быть восстановлена.</li> </ul> 
primaryVersion.<br>algorithm | **string**<br><p>Алгоритм шифрования, используемый при генерации криптографического материала для версии ключа.</p> <p>Поддерживаемые алгоритмы симметричного шифрования.</p> <ul> <li>AES_128: Алгоритм AES со 128-битными ключами.</li> <li>AES_192: Алгоритм AES с 192-битными ключами.</li> <li>AES_256: Алгоритм AES с 256-битными ключами.</li> </ul> 
primaryVersion.<br>createdAt | **string** (date-time)<br><p>Время создания версии ключа.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
primaryVersion.<br>primary | **boolean** (boolean)<br><p>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа.</p> 
primaryVersion.<br>destroyAt | **string** (date-time)<br><p>Время, когда версия ключа будет уничтожена. Пустой, если статус не <code>SCHEDULED_FOR_DESTRUCTION</code>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
defaultAlgorithm | **string**<br><p>Алгоритм по умолчанию, который будет использоваться для создания новой версии во время ротации ключа.</p> <p>Поддерживаемые алгоритмы симметричного шифрования.</p> <ul> <li>AES_128: Алгоритм AES со 128-битными ключами.</li> <li>AES_192: Алгоритм AES с 192-битными ключами.</li> <li>AES_256: Алгоритм AES с 256-битными ключами.</li> </ul> 
rotatedAt | **string** (date-time)<br><p>Время последней ротации ключа (время, когда была создана последняя версия). Пустое, если у ключа еще нет версий.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
rotationPeriod | **string**<br><p>Период времени между автоматическими ротациями ключа KMS.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[cancelVersionDestruction](cancelVersionDestruction.md) | Отменяет ранее запланированное уничтожение версии, если версия еще не была уничтожена.
[create](create.md) | Создает симметричный ключ в указанном каталоге.
[delete](delete.md) | Удаляет указанный симметричный ключ. Это действие также автоматически планирует уничтожение всех версий ключа через 72 часа.
[get](get.md) | Возвращает указанный симметричный ключ.
[list](list.md) | Возвращает список симметричных ключей в указанном каталоге.
[listOperations](listOperations.md) | Возвращет список операций для указанного симметричного ключа.
[listVersions](listVersions.md) | Возвращает список версий, принадлежащих указанному симметричному ключу.
[rotate](rotate.md) | Ротирует указанный ключ: создает новую версию ключа и делает ее основной.
[scheduleVersionDestruction](scheduleVersionDestruction.md) | Планирует уничтожение указанной версии ключа.
[setPrimaryVersion](setPrimaryVersion.md) | Задает основную версию для указанного ключа. Основная версия используется по умолчанию для всех операций шифрования / дешифрования, в которых не указан идентификатор версии.
[update](update.md) | Изменяет указанный симметричный ключ.