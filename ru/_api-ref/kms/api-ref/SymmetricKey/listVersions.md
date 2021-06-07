---
editable: false
---

# Метод listVersions
Возвращает список версий указанного симметричного ключа KMS.
 

 
## HTTP-запрос {#https-request}
```
GET https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}/versions
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
keyId | Обязательное поле. Идентификатор симметричного ключа KMS, для которого нужно вернуть список версий.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/kms/api-ref/SymmetricKey/listVersions#query_params) , сервис вернет значение [nextPageToken](/docs/kms/api-ref/SymmetricKey/listVersions#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/kms/api-ref/SymmetricKey/listVersions#query_params) равным значению поля [nextPageToken](/docs/kms/api-ref/SymmetricKey/listVersions#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keyVersions": [
    {
      "id": "string",
      "keyId": "string",
      "status": "string",
      "algorithm": "string",
      "createdAt": "string",
      "primary": true,
      "destroyAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
keyVersions[] | **object**<br><p>Версия симметричного ключа KMS: метаданные криптографического материала.</p> 
keyVersions[].<br>id | **string**<br><p>Идентификатор версии ключа.</p> 
keyVersions[].<br>keyId | **string**<br><p>Идентификатор симметричного ключа KMS, которому принадлежит версия.</p> 
keyVersions[].<br>status | **string**<br><p>Состояние версии ключа.</p> <p>Возможные статусы версии.</p> <ul> <li>ACTIVE: Версия активна и может использоваться для шифрования и дешифрования.</li> <li>SCHEDULED_FOR_DESTRUCTION: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле ``destroyAt``.</li> <li>DESTROYED: Версия уничтожена и не может быть восстановлена.</li> </ul> 
keyVersions[].<br>algorithm | **string**<br><p>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования.</p> <p>Поддерживаемые алгоритмы симметричного шифрования.</p> <ul> <li>AES_128: Алгоритм AES со 128-битными ключами.</li> <li>AES_192: Алгоритм AES с 192-битными ключами.</li> <li>AES_256: Алгоритм AES с 256-битными ключами.</li> </ul> 
keyVersions[].<br>createdAt | **string** (date-time)<br><p>Время создания версии ключа.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
keyVersions[].<br>primary | **boolean** (boolean)<br><p>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа.</p> 
keyVersions[].<br>destroyAt | **string** (date-time)<br><p>Время, когда версия ключа будет уничтожена. Пустой, если статус не ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/kms/api-ref/SymmetricKey/listVersions#query_params">pageSize</a>, используйте <a href="/docs/kms/api-ref/SymmetricKey/listVersions#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/kms/api-ref/SymmetricKey/listVersions#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/kms/api-ref/SymmetricKey/listVersions#responses">nextPageToken</a> для перебора страниц результатов.</p> 