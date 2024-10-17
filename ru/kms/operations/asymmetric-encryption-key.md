---
title: Как создать, изменить и удалить ключевую пару шифрования
description: Следуя данной инструкции, вы сможете создать, изменить и удалить ключевую пару шифрования.
---

# Управление ключевыми парами шифрования

С помощью {{ kms-name }} вы можете создавать, изменять и удалять асимметричные ключевые пары шифрования.

## Создать ключевую пару шифрования {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ключевая пара.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.kms.asymmetric-keys.title_create }}**. В открывшемся окне:
      1. Укажите имя и при необходимости описание в свободной форме.
      1. В поле **{{ ui-key.yacloud.kms.asymmetric-key.form.title_type }}** выберите `{{ ui-key.yacloud.kms.asymmetric-keys.title_key-type-encryption }}`.
      1. В поле **{{ ui-key.yacloud.kms.asymmetric-key.form.title_algorithm }}** выберите нужный алгоритм шифрования.
      1. При необходимости включите защиту от удаления.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ключевой пары шифрования:

      ```bash
      yc kms asymmetric-encryption-key create --help
      ```

  1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором нужно создать ключевую пару.

  1. Создайте ключевую пару:

      ```bash
      yc kms asymmetric-encryption-key create \
        --name <имя_ключевой_пары> \
        --encryption-algorithm <алгоритм_шифрования> \
        --folder-id <идентификатор_каталога>
      ```

      Где:
      * `--name` — имя ключевой пары шифрования.
      * `--folder-id` — идентификатор каталога, в котором будет создана ключевая пара.
      * `--encryption-algorithm` — алгоритм шифрования. Доступные варианты:

          * `rsa-2048-enc-oaep-sha-256`
          * `rsa-3072-enc-oaep-sha-256`
          * `rsa-4096-enc-oaep-sha-256`

      Результат:

      ```text
      id: abjfmo5enqlr********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T18:10:03Z"
      name: sample-encryption-key
      status: ACTIVE
      encryption_algorithm: RSA_2048_ENC_OAEP_SHA_256
      ```

- API {#api}

  Чтобы создать ключевую пару шифрования, воспользуйтесь вызовом gRPC API [AsymmetricEncryptionKeyService/Create](../asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/create.md).

{% endlist %}

## Изменить ключевую пару шифрования {#update}

После создания ключевой пары шифрования вы можете изменить ее имя, описание, метки, а также включить или выключить защиту от удаления.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная ключевая пара.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.kms.asymmetric-key.form.label_encryption }}**.
  1. В строке с нужной ключевой парой нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:
      1. Измените необходимые атрибуты ключевой пары.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения ключевой пары шифрования:

      ```bash
      yc kms asymmetric-encryption-key update --help
      ```

  1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором находится ключевая пара.

  1. {% include [get-asymmetric-encryption-key](../../_includes/kms/get-a-encryption-key.md) %}

  1. Измените ключевую пару:

      ```bash
      yc kms asymmetric-encryption-key update \
        --id <идентификатор_ключевой_пары> \
        --new-name <новое_имя_ключевой_пары> \
        --deletion-protection
      ```

      Где:
      * `--id` — идентификатор ключевой пары шифрования.
      * `--new-name` — новое имя ключевой пары.
      * `--deletion-protection` — флаг включения защиты от удаления. Чтобы отключить защиту ключевой пары от удаления, используйте флаг `--no-deletion-protection`.

      Результат:

      ```text
      id: abjfmo5enqlr********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T18:10:03Z"
      name: new-encryption-key
      status: ACTIVE
      encryption_algorithm: RSA_2048_ENC_OAEP_SHA_256
      deletion_protection: true
      ```

      Команда изменила имя ключевой пары шифрования и включила защиту от удаления.

- API {#api}

  Чтобы изменить ключевую пару шифрования, воспользуйтесь вызовом gRPC API [AsymmetricEncryptionKeyService/Update](../asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/update.md).

{% endlist %}

## Удалить ключевую пару шифрования {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная ключевая пара.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.kms.asymmetric-key.form.label_encryption }}**.
  1. В строке с нужной ключевой парой нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ключевой пары шифрования:

      ```bash
      yc kms asymmetric-encryption-key delete --help
      ```

  1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором находится ключевая пара.

  1. {% include [get-asymmetric-encryption-key](../../_includes/kms/get-a-encryption-key.md) %}

  1. Удалите ключевую пару, указав ее идентификатор:

      ```bash
      yc kms asymmetric-encryption-key delete \
        --id <идентификатор_ключевой_пары>
      ```

      Результат:

      ```text
      id: abjfmo5enqlr********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T18:10:03Z"
      name: new-encryption-key
      encryption_algorithm: RSA_2048_ENC_OAEP_SHA_256
      ```

- API {#api}

  Чтобы удалить ключевую пару шифрования, воспользуйтесь вызовом gRPC API [AsymmetricEncryptionKeyService/Delete](../asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/delete.md).

{% endlist %}