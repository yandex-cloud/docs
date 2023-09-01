# Управление ключевыми парами электронной подписи

С помощью {{ kms-name }} вы можете создавать, изменять и удалять ключевые пары электронной подписи.

## Создать ключевую пару электронной подписи {#create}

Чтобы создать новую ключевую пару электронной подписи:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ключевая пара.
  1. В списке сервисов выберите **{{ kms-name }}**.
  1. На панели слева выберите **Асимметричные ключи**.
  1. В правом верхнем углу нажмите кнопку **Создать ключ**. В открывшемся окне:
      1. Укажите имя и при необходимости описание в свободной форме.
      1. В поле **Тип** выберите **Подпись**.
      1. В поле **Алгоритм** выберите нужный алгоритм подписи.
      1. При необходимости включите защиту от удаления.
      1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ключевой пары электронной подписи:

      ```bash
      yc kms asymmetric-signature-key create --help
      ```

  1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором нужно создать ключевую пару.

  1. Создайте ключевую пару электронной подписи:

      ```bash
      yc kms asymmetric-signature-key create \
        --name <имя_ключевой_пары> \
        --folder-id <идентификатор_каталога> \
        --signature-algorithm <алгоритм_подписи>
      ```
      
      Где:
      * `--name` — имя ключевой пары электронной подписи.
      * `--folder-id` — идентификатор каталога, в котором будет создана ключевая пара.
      * `--signature-algorithm` — алгоритм электронной подписи. Доступны следующие алгоритмы [ECDSA](https://ru.wikipedia.org/wiki/ECDSA) и [RSA](https://ru.wikipedia.org/wiki/RSA):

          * `rsa-2048-sign-pss-sha-256`
          * `rsa-2048-sign-pss-sha-384`
          * `rsa-2048-sign-pss-sha-512`
          * `rsa-3072-sign-pss-sha-256`
          * `rsa-3072-sign-pss-sha-384`
          * `rsa-3072-sign-pss-sha-512`
          * `rsa-4096-sign-pss-sha-256`
          * `rsa-4096-sign-pss-sha-384`
          * `rsa-4096-sign-pss-sha-512`
          * `ecdsa-nist-p256-sha-256`
          * `ecdsa-nist-p384-sha-384`
          * `ecdsa-nist-p521-sha-512`
          * `ecdsa-secp256-k1-sha-256`
      
      Результат:

      ```bash
      id: abj9g2dil5sj********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T09:06:57Z"
      name: sample-signature-key
      status: ACTIVE
      signature_algorithm: RSA_2048_SIGN_PSS_SHA_512
      ```

{% endlist %}

## Изменить ключевую пару электронной подписи {#update}

После создания ключевой пары вы можете изменить ее имя, описание, метки, а также включить или выключить защиту от удаления.

Чтобы изменить ключевую пару электронной подписи:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная ключевая пара.
  1. В списке сервисов выберите **{{ kms-name }}**.
  1. На панели слева выберите **Асимметричные ключи**.
  1. Перейдите на вкладку **Подпись**.
  1. В строке с нужной ключевой парой нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Изменить**. В открывшемся окне:
      1. Измените необходимые атрибуты ключевой пары.
      1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения ключевой пары электронной подписи:

      ```bash
      yc kms asymmetric-signature-key update --help
      ```

  1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором находится ключевая пара.
  
  1. {% include [get-signature-key](../../_includes/kms/get-signature-key.md) %}
  
  1. Измените ключевую пару электронной подписи:

      ```bash
      yc kms asymmetric-signature-key update \
        --id <идентификатор_ключевой_пары> \
        --new-name <новое_имя_ключевой_пары> \
        --deletion-protection
      ```

      Где:
      * `--id` — идентификатор ключевой пары электронной подписи.
      * `--new-name` — новое имя ключевой пары.
      * `--deletion-protection` — флаг включения защиты от удаления. Чтобы отключить защиту ключевой пары от удаления, используйте флаг `--no-deletion-protection`.

      Результат:

      ```bash
      id: abj9g2dil5sj********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T09:06:57Z"
      name: sample-new-key
      status: ACTIVE
      signature_algorithm: RSA_2048_SIGN_PSS_SHA_512
      deletion_protection: true
      ```

     Команда изменила имя ключевой пары электронной подписи и включила защиту от удаления.

{% endlist %}

## Удалить ключевую пару электронной подписи {#delete}

Чтобы удалить ключевую пару электронной подписи:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная ключевая пара.
  1. В списке сервисов выберите **{{ kms-name }}**.
  1. На панели слева выберите **Асимметричные ключи**.
  1. Перейдите на вкладку **Подпись**.
  1. В строке с нужной ключевой парой нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
  1. Подтвердите удаление.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ключевой пары подписи:

      ```bash
      yc kms asymmetric-signature-key delete --help
      ```

  1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором находится ключевая пара.
  
  1. {% include [get-signature-key](../../_includes/kms/get-signature-key.md) %}
  
  1. Удалите ключевую пару электронной подписи, указав ее идентификатор:

      ```bash
      yc kms asymmetric-signature-key delete \
        --id <идентификатор_ключевой_пары>
      ```

      Результат:

      ```bash
      done (1s)
      id: abj9g2dil5sj********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T09:06:57Z"
      name: sample-new-key
      signature_algorithm: RSA_2048_SIGN_PSS_SHA_512
      ```

{% endlist %}