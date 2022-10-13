---
editable: false
---

# SymmetricCryptoService

--- Data plane for KMS symmetric cryptography operations 
Набор методов, выполняющих симметричное шифрование и дешифрование.

| Вызов | Описание |
| --- | --- |
| [Encrypt](#Encrypt) | Шифрует заданный текст с помощью указанного ключа. |
| [Decrypt](#Decrypt) | Расшифровывает указанный шифртекст с помощью указанного ключа. |
| [ReEncrypt](#ReEncrypt) | Заново шифрует заданный зашифрованный текст с указанным ключом KMS. |
| [GenerateDataKey](#GenerateDataKey) | Создает новый симметричный ключ шифрования данных (не ключ KMS) и возвращает сгенерированный ключ в виде открытого текста и текста, зашифрованного указанным симметричным ключом KMS. |

## Вызовы SymmetricCryptoService {#calls}

## Encrypt {#Encrypt}

Шифрует заданный текст с помощью указанного ключа.

**rpc Encrypt ([SymmetricEncryptRequest](#SymmetricEncryptRequest)) returns ([SymmetricEncryptResponse](#SymmetricEncryptResponse))**

### SymmetricEncryptRequest {#SymmetricEncryptRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор симметричного ключа KMS, который следует использовать для шифрования. Максимальная длина строки в символах — 50.
version_id | **string**<br>Идентификатор версии ключа, которую следует использовать для шифрования текста. По умолчанию используется основная версия, если версия не указана явно. Максимальная длина строки в символах — 50.
aad_context | **bytes**<br>Дополнительные аутентифицированные данные (контекст AAD), необязательное поле. Если данные указаны, то их потребуется передать для расшифровки с помощью [SymmetricDecryptRequest](#SymmetricDecryptRequest). Необходимо закодировать в формате base64. Максимальная длина строки в символах — 8192.
plaintext | **bytes**<br>Обязательное поле. Открытый текст, который следует зашифровать. Должен быть в кодировке base64. Максимальная длина строки в символах — 32768.


### SymmetricEncryptResponse {#SymmetricEncryptResponse}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор симметричного ключа KMS, который использовался для шифрования. Максимальная длина строки в символах — 50.
version_id | **string**<br>Идентификатор версии ключа, которая использовалась для шифрования. Максимальная длина строки в символах — 50.
ciphertext | **bytes**<br>Полученный шифртекст. 


## Decrypt {#Decrypt}

Расшифровывает указанный шифртекст с помощью указанного ключа.

**rpc Decrypt ([SymmetricDecryptRequest](#SymmetricDecryptRequest)) returns ([SymmetricDecryptResponse](#SymmetricDecryptResponse))**

### SymmetricDecryptRequest {#SymmetricDecryptRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор симметричного ключа KMS, который следует использовать для дешифрования. Максимальная длина строки в символах — 50.
aad_context | **bytes**<br>Дополнительные аутентификационные данные (AAD-контекст), должны быть такими же, как они были переданы в соответствующем запросе [SymmetricEncryptRequest](#SymmetricEncryptRequest). Должен быть в кодировке base64. Максимальная длина строки в символах — 8192.
ciphertext | **bytes**<br>Обязательное поле. Шифртекст для расшифровки. Должен быть в кодировке base64. 


### SymmetricDecryptResponse {#SymmetricDecryptResponse}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор симметричного ключа KMS, который использовался для дешифрования. 
version_id | **string**<br>Идентификатор версии ключа, которая использовалась для дешифрования. 
plaintext | **bytes**<br>Расшифрованный открытый текст. 


## ReEncrypt {#ReEncrypt}

Заново шифрует заданный зашифрованный текст с указанным ключом KMS.

**rpc ReEncrypt ([SymmetricReEncryptRequest](#SymmetricReEncryptRequest)) returns ([SymmetricReEncryptResponse](#SymmetricReEncryptResponse))**

### SymmetricReEncryptRequest {#SymmetricReEncryptRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор нового ключа, который следует использовать для шифрования. Максимальная длина строки в символах — 50.
version_id | **string**<br>Идентификатор версии нового ключа, которую следует использовать для шифрования. По умолчанию используется основная версия, если версия не указана явно. Максимальная длина строки в символах — 50.
aad_context | **bytes**<br>Дополнительные аутентифицированные данные (AAD-контекст), которые потребуются для расшифровки. Должен быть в кодировке base64. Максимальная длина строки в символах — 8192.
source_key_id | **string**<br>Обязательное поле. Идентификатор ключа, которым на текущий момент зашифрован текст. Может быть таким же, как и новый ключ. Максимальная длина строки в символах — 50.
source_aad_context | **bytes**<br>Дополнительные аутентификационные данные, переданные с первоначальным запросом шифрования. Должен быть в кодировке base64. Максимальная длина строки в символах — 8192.
ciphertext | **bytes**<br>Обязательное поле. Шифртекст, который следует расшифровать и зашифровать повторно. Должен быть в кодировке base64. 


### SymmetricReEncryptResponse {#SymmetricReEncryptResponse}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор ключа, которым в данный момент зашифрован текст. 
version_id | **string**<br>Идентификатор версии ключа, которая использовалась для шифрования. 
source_key_id | **string**<br>Идентификатор ключа, с помощью которого шифртекст был зашифрован ранее. 
source_version_id | **string**<br>Идентификатор версии ключа, которая использовалась для расшифровки перешифруемых данных. 
ciphertext | **bytes**<br>Заново зашифрованный шифртекст. 


## GenerateDataKey {#GenerateDataKey}

Создает новый симметричный ключ шифрования данных (не ключ KMS) и возвращает сгенерированный ключ в виде открытого текста и текста, зашифрованного указанным симметричным ключом KMS.

**rpc GenerateDataKey ([GenerateDataKeyRequest](#GenerateDataKeyRequest)) returns ([GenerateDataKeyResponse](#GenerateDataKeyResponse))**

### GenerateDataKeyRequest {#GenerateDataKeyRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор симметричного ключа KMS, с помощью которого должен быть зашифрован сгенерированный ключ шифрования данных. Максимальная длина строки в символах — 50.
version_id | **string**<br>Идентификатор версии ключа, с которой следует зашифровать сгенерированный ключ шифрования данных. По умолчанию используется основная версия, если версия не указана явно. Максимальная длина строки в символах — 50.
aad_context | **bytes**<br>Дополнительные аутентифицированные данные (контекст AAD), необязательное поле. Если данные указаны, то их потребуется передать для расшифровки с помощью [SymmetricDecryptRequest](#SymmetricDecryptRequest). Необходимо закодировать в формате base64. Максимальная длина строки в символах — 8192.
data_key_spec | enum **SymmetricAlgorithm**<br>Алгоритм шифрования и длина для сгенерированного ключа шифрования данных. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><li>`AES_256_HSM`: Алгоритм AES с 256-битными ключами на базе HSM</li><ul/>
skip_plaintext | **bool**<br>Если `true`, метод не возвращает ключ щифрования данных в виде открытого текста. Значение по умолчанию `false`. 


### GenerateDataKeyResponse {#GenerateDataKeyResponse}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор симметричного ключа KMS, с помощью которого был зашифрован сгенерированный ключ шифрования данных. 
version_id | **string**<br>Идентификатор версии ключа, которая использовалась для шифрования. 
data_key_plaintext | **bytes**<br>Сгенерированный ключ шифрования данных в виде открытого текста. Это поле пусто, если параметр [GenerateDataKeyRequest.skip_plaintext](#GenerateDataKeyRequest) был установлен в `true`. 
data_key_ciphertext | **bytes**<br>Зашифрованный ключ шифрования данных. 

