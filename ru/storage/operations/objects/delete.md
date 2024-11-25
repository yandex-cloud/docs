---
title: Удаление объекта в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете удалить объект в бакете в {{ objstorage-name }}.
---

# Удаление объекта

## Удалить объект или версию объекта без блокировки {#wo-object-lock}

Любой объект или версию объекта, на которую не установлена [блокировка](../../concepts/object-lock.md) (в том числе если в бакете не включены блокировки), можно удалить без дополнительных подтверждений.

{% note info %}

Объект, [составная загрузка](../../concepts/multipart.md) которого не завершена, удаляется по другой [инструкции](deleting-multipart.md).

{% endnote %}

Минимальная необходимая роль — `storage.editor`.

Чтобы удалить объект:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, где хранится удаляемый объект.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Чтобы видеть все версии объектов в списке, справа от поля поиска объекта в бакете, включите опцию **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}**.
  1. Чтобы удалить один объект, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.file.button_delete }}**.

     Чтобы выполнить это же действие с несколькими объектами, отметьте их в списке и нажмите кнопку **{{ ui-key.yacloud.common.delete }}** в нижней части экрана.

     {% note info %}

     Можно удалить папку с объектами. Это асинхронная операция, после запуска которой объекты не исчезают сразу из бакета, а удаляются постепенно. Вы в это время можете выполнять другие операции в консоли управления, в том числе загрузку новых объектов в удаляемую папку. Детали смотрите в разделе [Папка](../../concepts/object.md#folder).

     {% endnote %}

  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.storage.file.popup-confirm_button_delete }}**.

  В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут.

  {% include [work-with-multiple-objects](../../../_includes/storage/work-with-multiple-objects.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления объекта из бакета:

      ```bash
      yc storage s3api delete-object --help
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

  1. Выполните команду:

      ```bash
      yc storage s3api put-object \
        --bucket <имя_бакета> \
        --key <ключ_объекта>
      ```

      Где:

      * `--bucket` — имя вашего бакета.
      * `--key` — [ключ](../../concepts/object.md#key) объекта.

      Результат:

      ```bash
      request_id: 0311ec7********
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду `aws s3api delete-object`:

  ```bash
  aws s3api delete-object \
    --endpoint-url https://{{ s3-storage-host }} \
    --bucket <имя_бакета> \
    --key <ключ_объекта>
  ```

  Где:
  * `--bucket` — имя вашего бакета.
  * `--key` — [ключ](../../concepts/object.md#key) объекта.

  Чтобы одновременно удалить список объектов, укажите ключи этих объектов в параметре `--delete`:

  * **Bash**:

      ```bash
      aws s3api delete-objects \
        --endpoint-url=https://{{ s3-storage-host }} \
        --bucket <имя_бакета> \
        --delete '{"Objects":[{"Key":"<ключ_объекта_1>"},{"Key":"<ключ_объекта_2>"},...,{"Key":"<ключ_объекта_n>"}]}'
      ```

  * **PowerShell**:

      ```powershell
      aws s3api delete-objects `
        --endpoint-url=https://{{ s3-storage-host }} `
        --bucket <имя_бакета> `
        --delete '{\"Objects\":[{\"Key\":\"<ключ_объекта_1>\"},{\"Key\":\"<ключ_объекта_2>\"},...,{\"Key\":\"<ключ_объекта_n>\"}]}'
      ```

  Где:
  * `--bucket` — имя бакета.
  * `<ключ_объекта_1>`, `<ключ_объекта_2>`, `<ключ_объекта_n>` — [ключи](../../concepts/object.md#key) объектов, которые нужно удалить.

  Результат:

  ```text
  {
    "Deleted": [
        {
            "Key": "<ключ_объекта_1>",
            "VersionId": "null"
        },
        {
            "Key": "<ключ_объекта_2>",
            "VersionId": "null"
        }
        ...
        {
            "Key": "<ключ_объекта_n>",
            "VersionId": "null"
        }
    ]
  }
  ```

  Указать объекты для удаления можно с помощью шаблона запроса в формате JMESPath. Для удаления объектов по шаблону выполните команду:

  * **Bash**:

      ```bash
      aws s3api list-objects \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket <имя_бакета> \
        --query '<запрос>' \
        --output text | xargs -I {} aws s3api delete-object --endpoint-url https://{{ s3-storage-host }} --bucket <имя_бакета> --key {}
      ```

      Где:
      * `--bucket` — имя бакета.
      * `--query` — запрос в формате [JMESPath](https://jmespath.org/).

      Пример команды для удаления из бакета `sample-bucket` всех объектов, расположенных в папке `screenshots`, имена файлов которых начинаются с даты `20231002`:

      ```bash
      aws s3api list-objects \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket sample-bucket \
        --query 'Contents[?starts_with(Key, `screenshots/20231002`) == `true`].[Key]' \
        --output text | xargs -I {} aws s3api delete-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key {}
      ```

  * **PowerShell**:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket <имя_бакета> `
        --query '<запрос>' `
        --output text)) `
        {aws s3api delete-object --endpoint-url https://{{ s3-storage-host }} --bucket <имя_бакета> --key $x}
      ```

      Где:
      * `--bucket` — имя бакета.
      * `--query` — запрос в формате [JMESPath](https://jmespath.org/).

      Пример команды для удаления из бакета `sample-bucket` всех объектов, расположенных в папке `screenshots`, имена файлов которых начинаются с даты `20231002`:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket sample-bucket `
        --query 'Contents[?starts_with(Key, `screenshots/20231002`) == `true`].[Key]' `
        --output text)) `
        {aws s3api delete-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key $x}
      ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}


  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  Чтобы удалить объект из бакета, созданный с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием объекта.

     {% cut "Пример описания объекта в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_storage_object" "cute-cat-picture" {
       access_key = "YCAJEX9Aw2ge********-w-lJ"
       secret_key = "YCONxG7rSdzVF9UMxLA_NRy5VbKzKlqZ********"
       bucket     = "cat-pictures"
       key        = "cute-cat"
       source     = "/images/cats/cute-cat.jpg"
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.
  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```bash
     terraform plan
     ```

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом S3 API [delete](../../s3/api-ref/object/delete.md).

  {% include [work-with-multiple-objects](../../../_includes/storage/work-with-multiple-objects.md) %}

{% endlist %}

## Удалить версию объекта с блокировкой (object lock) {#w-object-lock}

Если в бакете включены [блокировки версий объектов](../buckets/configure-object-lock.md), некоторым или всем пользователям может быть запрещено удалять версию объекта.

Чтобы проверить, установлена ли блокировка, и удалить версию объекта при возможности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Если это возможно, [снимите блокировку](edit-object-lock.md) с объекта который вы хотите удалить.
  1. [Удалите](#object-lock-w-object-lock) объект.
  
  В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут.
  
  {% include [work-with-multiple-objects](../../../_includes/storage/work-with-multiple-objects.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите информации о блокировке версии объекта::

      ```bash
      yc storage s3api head-object \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --version-id <идентификатор_версии>
      ```

     Где:
     * `--bucket` — имя вашего бакета.
     * `--key` — [ключ](../../concepts/object.md#key) объекта.
     * `--version-id` — идентификатор версии объекта.

     Если на версию установлена блокировка, об этом отобразится информация:

     ```text     
     object_lock_mode: GOVERNANCE
     object_lock_retain_until_date: "2024-10-11T10:23:12Z"
     ```

     Или:

     ```text
     object_lock_legal_hold_status: ON
     ```

     Где:
     * `object_lock_mode` — [тип](../../concepts/object-lock.md#types) временной блокировки:
       * `GOVERNANCE` — временная управляемая блокировка. Удалить версию объекта может пользователь с ролью `storage.admin`.
       * `COMPLIANCE` — временная строгая блокировка. Удалить версию объекта нельзя.

     * `object_lock_retain_until_date` — дата и время окончания временной блокировки в любом из форматов, описанных в [стандарте HTTP](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). Например, `Mon, 12 Dec 2022 09:00:00 GMT`.

     * `object_lock_legal_hold_status` — статус [бессрочной блокировки](../../concepts/object-lock.md#types):
       * `ON` — включена. Удалить версию объекта нельзя. [Снять блокировку](edit-object-lock.md#remove-legal-hold) может пользователь с ролью `storage.uploader`.
       * `OFF` — выключена.

     Если на версии объекта нет блокировки, эти поля не отобразятся, и версию объекта можно удалить по [инструкции по удалению версии без блокировки](#wo-object-lock).

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

  1. Если установлена временная управляемая блокировка (`"object_lock_mode": "GOVERNANCE"`) и у вас есть роль `storage.admin`, удалите версию объекта:

      ```bash
      yc storage s3api delete-object \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --version-id <идентификатор_версии> \
        --bypass-governance-retention
      ```

      Где:

      * `--bucket` — имя вашего бакета.
      * `--key` — [ключ](../../concepts/object.md#key) объекта.
      * `--version-id` — идентификатор версии объекта.
      * `--bypass-governance-retention` — флаг, подтверждающий обход блокировки.

      Результат:

      ```bash
      request_id: a58bf215********
      version_id: "null"
      ```

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  1. Получите информацию о блокировке версии объекта:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3api head-object \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии>
     ```

     Где:
     * `--bucket` — имя вашего бакета.
     * `--key` — [ключ](../../concepts/object.md#key) объекта.
     * `--version-id` — идентификатор версии объекта.

     Если на версию установлена блокировка, информация о ней отобразится в результате выполнения команды:

     ```json
     {
       ...
       "ObjectLockMode": "<тип_временной_блокировки>",
       "ObjectLockRetainUntilDate": "<дата_и_время>",
       "ObjectLockLegalHoldStatus": "<статус_бессрочной_блокировки>",
       ...
     }
     ```

     Где:
     * `ObjectLockMode` — [тип](../../concepts/object-lock.md#types) временной блокировки:
       * `GOVERNANCE` — временная управляемая блокировка. Удалить версию объекта может пользователь с ролью `storage.admin`.
       * `COMPLIANCE` — временная строгая блокировка. Удалить версию объекта нельзя.

     * `ObjectLockRetainUntilDate` — дата и время окончания временной блокировки в любом из форматов, описанных в [стандарте HTTP](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). Например, `Mon, 12 Dec 2022 09:00:00 GMT`.

     * `ObjectLockLegalHoldStatus` — статус [бессрочной блокировки](../../concepts/object-lock.md#types):
       * `ON` — включена. Удалить версию объекта нельзя. [Снять блокировку](edit-object-lock.md#remove-legal-hold) может пользователь с ролью `storage.uploader`.
       * `OFF` — выключена.

     Если на версии объекта нет блокировки, эти поля не отобразятся, и версию объекта можно удалить по [инструкции по удалению версии без блокировки](#wo-object-lock).

  1. Если установлена временная управляемая блокировка (`"ObjectLockMode": "GOVERNANCE"`) и у вас есть роль `storage.admin`, удалите версию объекта:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3api delete-object \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии> \
       --bypass-governance-retention
     ```

     Где:
     * `--bucket` — имя вашего бакета.
     * `--key` — [ключ](../../concepts/object.md#key) объекта.
     * `--version-id` — идентификатор версии объекта.
     * `--bypass-governance-retention` — флаг, подтверждающий обход блокировки.

- API {#api}

  1. Чтобы получить информацию о блокировке версии объекта, воспользуйтесь методами S3 API [getObjectRetention](../../s3/api-ref/object/getobjectretention.md) (временная блокировка) и [getObjectLegalHold](../../s3/api-ref/object/getobjectlegalhold.md) (бессрочная блокировка).
  1. Если установлена только временная управляемая блокировка (`GOVERNANCE`) и у вас есть роль `storage.admin`, для удаления версии объекта воспользуйтесь методом S3 API [delete](../../s3/api-ref/object/delete.md). Укажите в запросе идентификатор версии и заголовок `X-Amz-Bypass-Governance-Retention`, чтобы подтвердить обход блокировки.

{% endlist %}