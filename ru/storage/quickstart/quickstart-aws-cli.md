---
title: "Начало работы с помощью AWS CLI"
description: "Следуя данной инструкции, вы сможете создать бакета и загрузить в него объект с помощью AWS CLI."
---

# Как начать работать с AWS CLI в {{ objstorage-full-name }}

[AWS CLI](../tools/aws-cli.md) является одним из самых популярных инструментов для работы с {{ objstorage-name }}. В этом разделе вы научитесь работать с сервисом с помощью этого инструмента. Инструкцию о работе в консоли управления см. в документе [{#T}](../quickstart.md).

Чтобы начать работу с AWS CLI:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте сервисный аккаунт](#create-sa).
1. [Установите и настройте AWS CLI](#cli-setup).
1. [Создайте бакет](#the-first-bucket).
1. [Загрузите объект в бакет](#upload-files).
1. [Получите ссылку на скачивание файла](#get-link).

## Подготовьте облако к работе {#before-you-begin}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
  1. На странице [**{{ ui-key.yacloud.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
  1. На странице [{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}]({{ link-console-access-management }}) убедитесь, что у вас следующие _минимальные_ роли:
      * для создания [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) и получения на него ключей доступа — [iam.serviceAccounts.admin](../../iam/roles-reference.md#iam-serviceAccounts-admin) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Если вы хотите использовать существующий сервисный аккаунт, достаточно роли `iam.serviceAccounts.admin` на этот сервисный аккаунт.
      * для назначения сервисному аккаунту нужной роли — [storage.admin](../../storage/security/index.md#storage-admin) на каталог.

      Если у вас примитивная роль [admin](../../iam/roles-reference.md#admin) на каталог, назначать дополнительно роли не требуется.

{% endlist %}

## Настройте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте сервисный аккаунт:

      {% include [create-sa-via-console-without-role](../../_includes/iam/create-sa-via-console-without-role.md) %}

      Вы также можете использовать существующий сервисный аккаунт.

      Подробнее см. в документе [{#T}](../../iam/operations/sa/create.md).

  1. Назначьте сервисному аккаунту нужную [роль](../security/index.md#roles-list), например [storage.editor](../security/index.md#storage-editor) на каталог:

      1. В [консоли управления]({{ link-console-main }}) выберите нужное облако или каталог.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
      1. В открывшемся окне выберите раздел **{{ ui-key.yacloud.common.resource-acl.label_service-accounts }}**.
      1. Выберите нужный сервисный аккаунт из списка или воспользуйтесь поиском.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль из списка или воспользуйтесь поиском.
      1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

      Подробнее см. в документе [{#T}](../../iam/operations/sa/assign-role-for-sa.md).
    
      {% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %} 

  1. Создайте статический ключ доступа {#create-keys}

      1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
      1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
      1. Выберите сервисный аккаунт и нажмите на строку с его именем.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели.
      1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Задайте описание ключа и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Сохраните идентификатор и секретный ключ.

          {% note alert %}

          После закрытия диалога значение ключа будет недоступно.

          {% endnote %}

      Подробнее см. в документе [{#T}](../../iam/operations/sa/create-access-key.md).

{% endlist %}

## Установите и настройте AWS CLI {#cli-setup}

1. Установите AWS CLI:

    {% list tabs group=operating_system %}

    - Linux {#linux}

      1. В терминале выполните команду:
    
          ```bash
          curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
          unzip awscliv2.zip
          sudo ./aws/install
          ```

      1. После завершения установки перезапустите терминал.

    - macOS {#macos}

      1. В терминале выполните команду:
    
          ```bash
          curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
          sudo installer -pkg AWSCLIV2.pkg -target /
          ```

      1. После завершения установки перезапустите терминал.

    - Windows {#windows}

      1. Скачайте [установочный файл](https://awscli.amazonaws.com/AWSCLIV2.msi) AWS CLI.
      1. Откройте файл и следуйте инструкциям программы установки.

    {% endlist %}

    Подробнее об установке AWS CLI см. в [документации AWS](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

1. Настройте AWS CLI:

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      1. В терминале введите команду для настройки AWS CLI:

          ```bash
          aws configure
          ```

      1. Введите значения для параметров:

          * `AWS Access Key ID` — идентификатор статического ключа, полученный ранее.
          * `AWS Secret Access Key` — секретный ключ, полученный ранее.
          * `Default region name` — регион `{{ region-id }}`.

            Для работы с {{ objstorage-name }} всегда указывайте регион — `{{ region-id }}`. Другие значения региона могут привести к ошибке авторизации.

     

          Значения остальных параметров оставьте без изменений.

          {% include [store-aws-key-in-lockbox](../../_includes/storage/store-aws-key-in-lockbox.md) %}

      1. Задайте эндпоинт {{ objstorage-name }}:

          ```bash
          aws configure set endpoint-url https://{{ s3-storage-host }}/
          ```

          {% cut "Пример получившихся конфигурационных файлов" %}

          * `~/.aws/config`:

            ```text
            [default]
            region = {{ region-id }}
            endpoint_url = https://{{ s3-storage-host }}/
            ```

          * `~/.aws/credentials`:

            ```text
            [default]
            aws_access_key_id = <идентификатор_статического_ключа>
            aws_secret_access_key = <секретный_ключ>
            ```

          {% endcut %}

    {% endlist %}

Подробнее о настройке AWS CLI см. в [документации AWS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

{% note info %}

Учитывайте [особенности](../tools/aws-cli.md#specifics) работы AWS CLI с {{ objstorage-name }}.

{% endnote %}

## Создайте бакет {#the-first-bucket}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  В терминале выполните команду, указав имя [бакета](../concepts/bucket.md):

  ```bash
  aws s3 mb s3://<имя_бакета>
  ```

  Подробности см. в документе [{#T}](../operations/buckets/create.md).

{% endlist %}

## Загрузите объект в бакет {#upload-files}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  Чтобы загрузить [объект](../concepts/object.md), выполните команду, указав путь к локальному файлу, который нужно загрузить, имя вашего бакета и [ключ](../concepts/object.md#key), по которому объект будет храниться в бакете:

  ```bash
  aws s3 cp <путь_к_локальному_файлу>/ s3://<имя_бакета>/<ключ_объекта>
  ```

  Подробности см. в документе [{#T}](../operations/objects/upload.md).

{% endlist %}

## Получите ссылку на скачивание объекта {#get-link}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  В терминале выполните команду, указав имя бакета, ключ объекта и время жизни ссылки в секундах:

  ```bash
  aws s3 presign s3://<имя_бакета>/<ключ_объекта> --expires-in <время_жизни>
  ```

  Полученной ссылкой вы можете поделиться или использовать ее в своем сервисе для доступа к файлу.

  Подробности см. в документе [{#T}](../operations/objects/link-for-download.md).

{% endlist %}
