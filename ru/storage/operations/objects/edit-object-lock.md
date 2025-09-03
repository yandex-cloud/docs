---
title: Настройка блокировок версии объекта в бакете в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете настроить блокировку версии объекта в бакете в {{ objstorage-name }}.
---

# Настройка блокировок версии объекта (object lock)

Если в бакете включены [версионирование](../buckets/versioning.md) и [блокировки версий объектов](../buckets/configure-object-lock.md), вы можете настроить блокировку версии, уже загруженной в бакет.

## Установить или настроить временную блокировку (governance или compliance) {#edit-retention}

Минимальные необходимые роли:

* для установки блокировки — `storage.uploader`;
* для изменения существующей блокировки — `storage.admin`.

Временную строгую блокировку (compliance-mode retention) можно только продлить. Сократить ее или заменить на управляемую блокировку (governance-mode retention) нельзя.

Чтобы установить или настроить блокировку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, для объектов которого хотите настроить блокировку.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Чтобы видеть все версии объектов в списке, справа от поля поиска объекта в бакете включите опцию **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}**.
  1. В списке объектов выберите нужный, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.bucket.button_object-lock }}**.
  1. В открывшемся окне включите опцию **{{ ui-key.yacloud.storage.field_temp-object-lock-enabled }}**.
  1. Выберите **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_mode_61kxf }}**:
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-governance }}** — пользователь с ролью `storage.admin` может обойти блокировку, изменить ее срок или снять ее.
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-compliance }}** — пользователь с ролью `storage.admin` может только продлить блокировку. Обойти, сократить или снять блокировку до ее окончания нельзя.
  1. Установите **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_retention-period_jJYhy }}** в днях или годах. Отсчитывается от момента, когда версия объекта загружена в бакет.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для настройки временной блокировки версии объекта:

      ```bash
      yc storage s3api put-object-retention --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Задайте настройки временной блокировки версии объекта:

      ```bash
      yc storage s3api put-object-retention \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --version-id <идентификатор_версии> \
        --retention Mode=<тип_блокировки>,RetainUntilDate="<срок_блокировки>" \
        --bypass-governance-retention
      ```

      {% include [object-lock-retention-cli-legend](../../../_includes/storage/object-lock-retention-cli-legend.md) %}

      Результат:

      ```bash
      request_id: c5984d03********
      ```

  1. {% include [get-object-retention-cli-command](../../../_includes/storage/get-object-retention-cli-command.md) %}

      Результат:

      ```text
      request_id: 077b184e********
      retention:
        mode: GOVERNANCE
        retain_until_date: "2024-12-01T10:49:08.363Z"
      ```

      В поле `mode` указан [тип](../../concepts/object-lock.md#types) блокировки, в поле `retain_until_date` — ее срок.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object-retention \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии> \
       --retention Mode=<тип_блокировки>,RetainUntilDate="<срок_блокировки>" \
       --bypass-governance-retention
     ```

     {% include [object-lock-retention-cli-legend](../../../_includes/storage/object-lock-retention-cli-legend.md) %}

- API {#api}

  Воспользуйтесь методом S3 API [putObjectRetention](../../s3/api-ref/object/putobjectretention.md).

{% endlist %}

## Снять временную управляемую блокировку (governance) {#remove-governance-retention}

Минимально необходимая роль — `storage.admin`.

Чтобы снять блокировку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Чтобы видеть все версии объектов в списке, справа от поля поиска объекта в бакете включите опцию **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}**.
  1. В списке объектов выберите нужный, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.bucket.button_object-lock }}**.
  1. В открывшемся окне выключите опцию **{{ ui-key.yacloud.storage.field_temp-object-lock-enabled }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для настройки временной блокировки версии объекта:

      ```bash
      yc storage s3api put-object-retention --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Задайте настройки временной блокировки версии объекта:

      ```bash
      yc storage s3api put-object-retention \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --version-id <идентификатор_версии> \
        --retention "{}" \
        --bypass-governance-retention
      ```

      {% include [object-lock-retention-remove-cli-legend](../../../_includes/storage/object-lock-retention-remove-cli-legend.md) %}

      Результат:

      ```bash
      request_id: m6384f81********
      ```

  1. {% include [get-object-retention-cli-command](../../../_includes/storage/get-object-retention-cli-command.md) %}

      Выполнение команды завершится ошибкой с информацией о том, что для указанного объекта не задана блокировка:

      ```text
      The specified object does not have a ObjectLock configuration.
      ```

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object-retention \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии> \
       --retention "{}" \
       --bypass-governance-retention
     ```

     {% include [object-lock-retention-remove-cli-legend](../../../_includes/storage/object-lock-retention-remove-cli-legend.md) %}

- API {#api}

  Воспользуйтесь методом S3 API [putObjectRetention](../../s3/api-ref/object/putobjectretention.md) с заголовком `X-Amz-Bypass-Governance-Retention: true` и пустым элементом `Retention`.

{% endlist %}


## Установить или удалить бессрочную блокировку (legal hold) {#edit-legal-hold}

Минимально необходимая роль — `storage.uploader`.

Чтобы установить или удалить блокировку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Чтобы видеть все версии объектов в списке, справа от поля поиска объекта в бакете включите опцию **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}**.
  1. В списке объектов выберите нужный, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.bucket.button_object-lock }}**.
  1. В открывшемся окне включите или выключите опцию **{{ ui-key.yacloud.storage.field_perm-object-lock-enabled }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для настройки бессрочной блокировки версии объекта:

      ```bash
      yc storage s3api put-object-legal-hold --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Задайте настройки бессрочной блокировки версии объекта:

      ```bash
      yc storage s3api put-object-legal-hold \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --version-id <идентификатор_версии> \
        --legal-hold Status=<статус_блокировки>
      ```

      {% include [legal-hold-cli-legend](../../../_includes/storage/legal-hold-cli-legend.md) %}

      Результат:

      ```bash
      request_id: cb262625********
      ```

  1. Убедитесь, что настройки блокировки версии объекта изменились:

      ```bash
      yc storage s3api get-object-legal-hold \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --version-id <идентификатор_версии>
      ```

      Где:

      * `--bucket` — имя вашего бакета.
      * `--key` — ключ объекта.
      * `--version-id` — идентификатор версии объекта

      Результат:

      ```text
      request_id: 0bef4a0b********
      legal_hold:
        status: ON
      ```

- AWS CLI {#aws-cli}

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

     {% include [legal-hold-cli-legend](../../../_includes/storage/legal-hold-cli-legend.md) %}

- API {#api}

  Воспользуйтесь методом S3 API [putObjectLegalHold](../../s3/api-ref/object/putobjectlegalhold.md).

{% endlist %}

## Примеры {#examples}

### Установка управляемой блокировки со смещением по московскому времени (UTC+3) {#example-lock}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  > ```bash
  > yc storage s3api put-object-retention \
  >   --bucket test-bucket \
  >   --key object-key/ \
  >   --version-id 0005FA15******** \
  >   --retention Mode=GOVERNANCE,RetainUntilDate=2025-01-01T00:00:00+03:00 \
  > ```

- AWS CLI {#aws-cli}

  > ```bash
  > aws --endpoint-url=https://{{ s3-storage-host }}/ \
  >   s3api put-object-retention \
  >   --bucket test-bucket \
  >   --key object-key/ \
  >   --version-id 0005FA15******** \
  >   --retention Mode=GOVERNANCE,RetainUntilDate="2025-01-01T00:00:00+03:00" \
  > ```

{% endlist %}