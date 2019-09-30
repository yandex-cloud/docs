---
editable: false
---

# Метод list
Возвращает список симметричных ключей в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://kms.api.cloud.yandex.net/kms/v1/keys
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка симметричных ключей.  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/kms/api-ref/SymmetricKey/list#query_params) , сервис вернет значение [nextPageToken](/docs/kms/api-ref/SymmetricKey/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/kms/api-ref/SymmetricKey/list#query_params) равным значению поля [nextPageToken](/docs/kms/api-ref/SymmetricKey/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keys": [
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
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
keys[] | **object**<br><p>Ключ KMS, который может содержать несколько версий криптографического материала.</p> 
keys[].<br>id | **string**<br><p>Идентификатор ключа.</p> 
keys[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит ключ.</p> 
keys[].<br>createdAt | **string** (date-time)<br><p>Время создания ключа.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
keys[].<br>name | **string**<br><p>Имя симметричного ключа.</p> 
keys[].<br>description | **string**<br><p>Описание симметричного ключа.</p> 
keys[].<br>labels | **object**<br><p>Пользовательские метки для ключа в виде пар <code>key:value</code>. Максимум 64 на ключ.</p> 
keys[].<br>status | **string**<br><p>Текущий статус ключа.</p> <ul> <li>CREATING: Ключ создается.</li> <li>ACTIVE: Ключ активен и может использоваться для шифрования и дешифрования.</li> <li>INACTIVE: Ключ неактивен и не может быть использован.</li> </ul> 
keys[].<br>primaryVersion | **object**<br><p>Основная версия ключа, используемая по умолчанию для всех операций шифрования / дешифрования, если идентификатор версии не указан явно.</p> <p>Версия ключа KMS: метаданные криптографического материала.</p> 
keys[].<br>primaryVersion.<br>id | **string**<br><p>Идентификатор версии ключа.</p> 
keys[].<br>primaryVersion.<br>keyId | **string**<br><p>Идентификатор ключа KMS, которому принадлежит версия.</p> 
keys[].<br>primaryVersion.<br>status | **string**<br><p>Состояние версии ключа.</p> <p>Возможные статусы версии.</p> <ul> <li>ACTIVE: Версия активна и может использоваться для шифрования и дешифрования.</li> <li>SCHEDULED_FOR_DESTRUCTION: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле destroyAt.</li> <li>DESTROYED: Версия уничтожена и не может быть восстановлена.</li> </ul> 
keys[].<br>primaryVersion.<br>algorithm | **string**<br><p>Алгоритм шифрования, используемый при генерации криптографического материала для версии ключа.</p> <p>Поддерживаемые алгоритмы симметричного шифрования.</p> <ul> <li>AES_128: Алгоритм AES со 128-битными ключами.</li> <li>AES_192: Алгоритм AES с 192-битными ключами.</li> <li>AES_256: Алгоритм AES с 256-битными ключами.</li> </ul> 
keys[].<br>primaryVersion.<br>createdAt | **string** (date-time)<br><p>Время создания версии ключа.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
keys[].<br>primaryVersion.<br>primary | **boolean** (boolean)<br><p>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа.</p> 
keys[].<br>primaryVersion.<br>destroyAt | **string** (date-time)<br><p>Время, когда версия ключа будет уничтожена. Пустой, если статус не <code>SCHEDULED_FOR_DESTRUCTION</code>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
keys[].<br>defaultAlgorithm | **string**<br><p>Алгоритм по умолчанию, который будет использоваться для создания новой версии во время ротации ключа.</p> <p>Поддерживаемые алгоритмы симметричного шифрования.</p> <ul> <li>AES_128: Алгоритм AES со 128-битными ключами.</li> <li>AES_192: Алгоритм AES с 192-битными ключами.</li> <li>AES_256: Алгоритм AES с 256-битными ключами.</li> </ul> 
keys[].<br>rotatedAt | **string** (date-time)<br><p>Время последней ротации ключа (время, когда была создана последняя версия). Пустое, если у ключа еще нет версий.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
keys[].<br>rotationPeriod | **string**<br><p>Период времени между автоматическими ротациями ключа KMS.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/kms/api-ref/SymmetricKey/list#query_params">pageSize</a>, используйте <a href="/docs/kms/api-ref/SymmetricKey/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/kms/api-ref/SymmetricKey/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/kms/api-ref/SymmetricKey/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 