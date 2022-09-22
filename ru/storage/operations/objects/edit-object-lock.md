# Настройка блокировок версии объекта (object lock)


## Установить или настроить временную блокировку {#edit-retention}

Минимальные необходимые роли:

* для установки блокировки — `storage.uploader`;
* для изменения существующей блокировки — `storage.admin`.

Временную строгую блокировку можно только продлить. Сократить ее или заменить ее на управляемую блокировку нельзя. 

{% list tabs %}

- AWS CLI

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }}/ \
    s3api put-object-retention \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --version-id <идентификатор_версии> \
    --retention Mode=<тип_блокировки>,RetainUntilDate="<дата_и_время_окончания_временной_блокировки>" \
    --bypass-governance-retention
  ```

  Где:

  * `bucket` — имя вашего бакета.
  * `key` — [ключ](../../concepts/object.md#key) объекта.
  * `version-id` — идентификатор версии объекта.
  * `retention` — настройки временной блокировки (оба параметра обязательны):
    
    * `Mode` — [тип](../../concepts/object-lock.md#types) блокировки:
  
      * `GOVERNANCE` — временная управляемая блокировка. Этот тип нельзя указать, если на версию объекта уже установлена строгая блокировка. 
      * `COMPLIANCE` — временная строгая блокировка.
  
    * `RetainUntilDate` — дата и время окончания блокировки в любом из форматов, описанных в [стандарте HTTP](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). Например, `Mon, 12 Dec 2022 09:00:00 GMT`. Если на версию объекта уже установлена строгая блокировка, ее можно только продлить, то есть новые дата и время должны быть позже текущих.

  * `bypass-governance-retention` — флаг, подтверждающий обход блокировки. Его нужно установить, если на версию объекта уже установлена управляемая блокировка.

{% endlist %}


## Снять временную управляемую блокировку {#remove-governance-retention}

Минимально необходимая роль — `storage.admin`.

{% list tabs %}

- AWS CLI

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }}/ \
    s3api put-object-retention \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --version-id <идентификатор_версии> \
    --retention Mode="",RetainUntilDate="" \
    --bypass-governance-retention
  ```

  Где:

  * `bucket` — имя вашего бакета.
  * `key` — [ключ](../../concepts/object.md#key) объекта.
  * `version-id` — идентификатор версии объекта.
  * `retention` — настройки временной блокировки. В обоих параметрах указаны пустые строки, чтобы снять блокировку.
  * `bypass-governance-retention` — флаг, подтверждающий обход блокировки.

{% endlist %}


## Установить или удалить бессрочную блокировку {#edit-legal-hold}

Минимально необходимая роль — `storage.uploader`.

{% list tabs %}

- AWS CLI

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }}/ \
    s3api put-object-legal-hold \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --version-id <идентификатор_версии> \
    --legal-hold Status=ON
  ```

  Где:

  * `bucket` — имя вашего бакета.
  * `key` — [ключ](../../concepts/object.md#key) объекта.
  * `version-id` — идентификатор версии объекта.
  * `legal-hold` — настройки бессрочной блокировки:
  
    * `Status` — статус блокировки:
  
      * `ON` — блокировка установлена.
      * `OFF` — блокировка не установлена.

{% endlist %}