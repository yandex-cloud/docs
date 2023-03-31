# Настройка блокировок версии объекта (object lock)

Если в бакете включены [версионирование](../buckets/versioning.md) и [блокировки версий объектов](../buckets/configure-object-lock.md), вы можете настроить блокировку версии, уже загруженной в бакет.

## Установить или настроить временную блокировку (governance или compliance) {#edit-retention}

Минимальные необходимые роли:

* для установки блокировки — `storage.uploader`;
* для изменения существующей блокировки — `storage.admin`.

Временную строгую блокировку (compliance-mode retention) можно только продлить. Сократить ее или заменить на управляемую блокировку (governance-mode retention) нельзя.

Чтобы установить или настроить блокировку:

{% list tabs %}

- AWS CLI

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

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

- API

  Воспользуйтесь методом S3 API [putObjectRetention](../../s3/api-ref/object/putobjectretention.md).

{% endlist %}


## Снять временную управляемую блокировку (governance) {#remove-governance-retention}

Минимально необходимая роль — `storage.admin`.

Чтобы снять блокировку:

{% list tabs %}

- AWS CLI

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

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

- API

  Чтобы снять блокировку, воспользуйтесь методом S3 API [putObjectRetention](../../s3/api-ref/object/putobjectretention.md) с заголовком `X-Amz-Bypass-Governance-Retention: true` и пустым элементом `Retention`.

{% endlist %}


## Установить или удалить бессрочную блокировку (legal hold) {#edit-legal-hold}

Минимально необходимая роль — `storage.uploader`.

Чтобы установить или удалить блокировку:

{% list tabs %}

- AWS CLI

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  1. Выполните команду:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object-legal-hold \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии> \
       --legal-hold Status=<статус_блокировки>
     ```
   
     Где:
   
     * `bucket` — имя вашего бакета.
     * `key` — [ключ](../../concepts/object.md#key) объекта.
     * `version-id` — идентификатор версии объекта.
     * `legal-hold` — настройки бессрочной блокировки:
     
       * `Status` — статус блокировки:
     
         * `ON` — блокировка установлена.
         * `OFF` — блокировка не установлена.

- API

  Чтобы установить или удалить блокировку, воспользуйтесь методом S3 API [putObjectLegalHold](../../s3/api-ref/object/putobjectlegalhold.md).

{% endlist %}