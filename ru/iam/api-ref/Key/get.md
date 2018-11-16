# Метод get
Возвращает указанный ресурс Key.
 
Чтобы получить список доступных ресурсов Key, используйте
запрос [list](/docs/iam/api-ref/Key/list).
 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/keys/{keyId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
keyId | Обязательное поле. Идентификатор возвращаемого ресурса Key. Чтобы получить идентификатор, используйте запрос [list](/docs/iam/api-ref/Key/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
format | Формат вывода ключа.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Key. Подробнее см. [Ключи шифрования](/docs/iam/concepts/users/service-accounts#keys).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор ресурса Key</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
description | **string**<br><p>Описание ресурса Key. Длина описания должна быть от 0 до 256 символов.</p> 
keyAlgorithm | **string**<br><ul> <li>RSA_2048: RSA с длиной ключа 2048 бит.</li> <li>RSA_4096: RSA с длиной ключа 4096 бит.</li> </ul> 
publicKey | **string**<br><p>Открытый ключ ресурса Key.</p> 
userAccountId | **string** <br> включает только одно из полей `userAccountId`, `serviceAccountId`<br><br><p>Идентификатор аккаунта пользователя, которому принадлежит ресурс Key.</p> 
serviceAccountId | **string** <br> включает только одно из полей `userAccountId`, `serviceAccountId`<br><br><p>Идентификатор сервисного аккаунта, которому принадлежит ресурс Key.</p> 