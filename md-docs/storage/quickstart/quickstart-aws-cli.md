# Как начать работать с AWS CLI в Yandex Object Storage

[AWS CLI](../tools/aws-cli.md) является одним из самых популярных инструментов для работы с Object Storage. В этом разделе вы научитесь работать с сервисом с помощью этого инструмента. Инструкцию о работе в консоли управления см. в документе [Как начать работать с Yandex Object Storage](../quickstart.md).

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

  1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.
  1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
  1. [Назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud _минимальные_ роли:
      * для создания [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) и получения на него ключей доступа — [iam.serviceAccounts.admin](../../iam/roles-reference.md#iam-serviceAccounts-admin) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Если вы хотите использовать существующий сервисный аккаунт, достаточно роли `iam.serviceAccounts.admin` на этот сервисный аккаунт.
      * для назначения сервисному аккаунту нужной роли — [storage.admin](../security/index.md#storage-admin) на каталог.

      Если у вас примитивная роль [admin](../../iam/roles-reference.md#admin) на каталог, назначать дополнительно роли не требуется.

      {% note info %}
      
      Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
      
      {% endnote %}

{% endlist %}

## Настройте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте сервисный аккаунт:

      1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
      1. Перейдите в сервис **Identity and Access Management**.
      1. Нажмите кнопку **Создать сервисный аккаунт**.
      1. Введите имя сервисного аккаунта.
      
         Требования к формату имени:
      
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
      
         Имя сервисного аккаунта должно быть уникальным в рамках облака.
      
      1. Нажмите кнопку **Создать**.

      Вы также можете использовать существующий сервисный аккаунт.

      Подробнее см. в документе [Создание сервисного аккаунта](../../iam/operations/sa/create.md).

  1. Назначьте сервисному аккаунту нужную [роль](../security/index.md#roles-list), например [storage.editor](../security/index.md#storage-editor) на каталог:

      1. В [консоли управления](https://console.yandex.cloud) выберите нужное облако или каталог.
      1. Перейдите на вкладку **Права доступа**.
      1. Нажмите кнопку **Настроить доступ**.
      1. В открывшемся окне выберите раздел **Сервисные аккаунты**.
      1. Выберите нужный сервисный аккаунт из списка или воспользуйтесь поиском.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль из списка или воспользуйтесь поиском.
      1. Нажмите кнопку **Сохранить**.

      Подробнее см. в документе [Назначение роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md).

      {% note info %}
      
      Сервисный аккаунт может просматривать список бакетов только в том каталоге, в котором он был создан.
      
      Сервисный аккаунт может выполнять действия с объектами в бакетах, которые созданы в каталогах, отличных от каталога сервисного аккаунта. Для этого [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роли](../security/index.md#service-roles) на нужный каталог или бакет в нем.
      
      {% endnote %}

  1. Создайте статический ключ доступа {#create-keys}

      1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, которому принадлежит сервисный аккаунт.
      1. Перейдите в сервис **Identity and Access Management**.
      1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
      1. В открывшемся списке выберите нужный сервисный аккаунт.
      1. Нажмите кнопку **Создать новый ключ** на верхней панели.
      1. Выберите **Создать статический ключ доступа**.
      1. Задайте описание ключа и нажмите кнопку **Создать**.
      1. Сохраните идентификатор и секретный ключ.

          {% note alert %}

          После закрытия диалога значение ключа будет недоступно.

          {% endnote %}

      Подробнее см. в документе [Создать статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

{% endlist %}

## Установите и настройте AWS CLI {#cli-setup}

1. Установите AWS CLI:

    {% list tabs group=operating_system %}

    - Linux {#linux}

      1. В терминале выполните команду:

          ```bash
          curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" --output "awscliv2.zip"
          unzip awscliv2.zip
          sudo ./aws/install
          ```

      1. После завершения установки перезапустите терминал.

    - macOS {#macos}

      1. В терминале выполните команду:

          ```bash
          curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" --output "AWSCLIV2.pkg"
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
          * `Default region name` — регион `ru-central1`.

            Для работы с Object Storage всегда указывайте регион — `ru-central1`. Другие значения региона могут привести к ошибке авторизации.


          Значения остальных параметров оставьте без изменений.

          
          Статический ключ для доступа к Object Storage можно безопасно хранить в сервисе Yandex Lockbox. Подробнее смотрите [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../tutorials/static-key-in-lockbox/index.md).


      1. Задайте эндпоинт Object Storage:

          ```bash
          aws configure set endpoint_url https://storage.yandexcloud.net/
          ```

          {% cut "Пример получившихся конфигурационных файлов" %}

          * `~/.aws/config`:

            
            ```text
            [default]
            region = ru-central1
            endpoint_url = https://storage.yandexcloud.net/
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

Учитывайте [особенности](../tools/aws-cli.md#specifics) работы AWS CLI с Object Storage.

{% endnote %}

## Создайте бакет {#the-first-bucket}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  В терминале выполните команду, указав имя [бакета](../concepts/bucket.md):

  ```bash
  aws s3 mb s3://<имя_бакета>
  ```

  Подробности см. в документе [Создание бакета](../operations/buckets/create.md).

{% endlist %}

## Загрузите объект в бакет {#upload-files}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  Чтобы загрузить [объект](../concepts/object.md), выполните команду, указав путь к локальному файлу, который нужно загрузить, имя вашего бакета и [ключ](../concepts/object.md#key), по которому объект будет храниться в бакете:

  ```bash
  aws s3 cp <путь_к_локальному_файлу>/ s3://<имя_бакета>/<ключ_объекта>
  ```

  Подробности см. в документе [Загрузка объекта](../operations/objects/upload.md).

{% endlist %}

## Получите ссылку на скачивание объекта {#get-link}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  В терминале выполните команду, указав имя бакета, ключ объекта и время жизни ссылки в секундах:

  ```bash
  aws s3 presign s3://<имя_бакета>/<ключ_объекта> --expires-in <время_жизни>
  ```

  Полученной ссылкой вы можете поделиться или использовать ее в своем сервисе для доступа к файлу.

  Подробности см. в документе [Получение подписанной ссылки (pre-signed URL) на скачивание объекта](../operations/objects/link-for-download.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../s3/s3-api-quickstart.md)
* [Вебинар: как с помощью Cloud CDN разгрузить высоконагруженную инфраструктуру](https://yandex.cloud/ru/events/1489?utm_source=docs&utm_medium=yandex&utm_campaign=infra&utm_content=vebinar&utm_term=cdns3)