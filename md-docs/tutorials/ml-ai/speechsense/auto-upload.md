# Автоматическая загрузка данных в Yandex SpeechSense с помощью Yandex Workflows

# Автоматическая загрузка данных в Yandex SpeechSense с помощью Yandex Workflows



{% note info %}

Workflows находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


Вы можете настроить автоматическую загрузку файлов с диалогами и их метаданными из бакета Yandex Object Storage в [пространство SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/concepts/resources-hierarchy#space). Поддерживаемые форматы:

  * `MP3`, `WAV`, `OggOpus` — для аудиозаписей;
  * `JSON` — для переписки из чата.

![image](../../../_assets/tutorials/auto-upload.svg)

На схеме:

1. [Триггер](../../../functions/concepts/trigger/os-trigger.md) для Object Storage отслеживает появление новых JSON-файлов с метаданными в выделенной папке [бакета](../../../storage/concepts/bucket.md) или любой из ее подпапок.
1. Когда в папке появляются новые файлы, триггер вызывает [функцию](../../../functions/concepts/function.md) `workflow-call`, которая запускает [рабочий процесс Workflows](../../../serverless-integrations/concepts/workflows/workflow.md).
1. Рабочий процесс получает содержимое JSON-файлов с метаданными и проверяет их синтаксис с помощью функции `verify-file`.
1. Рабочий процесс получает параметры подключения SpeechSense из [секрета Yandex Lockbox](../../../lockbox/concepts/secret.md).
1. Путь к аудиозаписи или текстовому файлу, а также их метаданные передаются в функцию загрузки `speechsense-upload`.
1. Функция `speechsense-upload` загружает файлы и их метаданные в пространство SpeechSense.
1. Во время выполнения рабочий процесс обращается к БД с метаданными:
    1. Логируются ошибки синтаксиса в файлах с метаданными.
    1. Логируются ошибки синтаксиса записей в файлах с метаданными.
    1. Проводится проверка на дубликаты: перед вызовом функции `speechsense-upload` проверяется, загружен ли уже файл в это пространство SpeechSense.
    1. Логируются ошибки функции `speechsense-upload`.
    1. При успешной загрузке файла логируются его метаданные и уникальный идентификатор в пространстве SpeechSense.
1. Сервис WebSQL позволяет получить доступ к БД с метаданными. Для просмотра используется один пользователь БД, а для загрузки файлов — другой.

Настроить автоматическую загрузку данных можно сразу для нескольких [подключений SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/concepts/resources-hierarchy#connection).

Чтобы автоматизировать загрузку данных в SpeechSense:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру для загрузки файлов](#infra).
1. [Создайте секрет Yandex Lockbox](#create-secret).
1. [Создайте модель данных в кластере Yandex Managed Service for PostgreSQL](#create-table).
1. [Создайте в бакете Object Storage папки для хранения файлов и их метаданных](#create-folder).
1. [Подготовьте метаданные](#prepare-metadata).
1. [Загрузите файлы в бакет Object Storage](#upload-files).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Сервис SpeechSense: длительность каждого двухканального аудиофайла или количество символов в каждом текстовом диалоге (см. [тарифы SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/pricing)).
* Бакет Object Storage: использование хранилища и выполнение операций с данными (см. [тарифы Object Storage](../../../storage/pricing.md)).
* Кластер Managed Service for PostgreSQL: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Managed Service for PostgreSQL](../../../managed-postgresql/pricing.md)).
* Функция Yandex Cloud Functions: количество вызовов функции, время простоя подготовленных экземпляров и выделенные для выполнения функции вычислительные ресурсы (см. [тарифы Cloud Functions](../../../functions/pricing.md)).
* Секрет Yandex Lockbox: количество хранимых версий секрета и запросы к ним (см. [тарифы Yandex Lockbox](../../../lockbox/pricing.md)).

### Создайте сервисные аккаунты {#create-sa}

Создайте два сервисных аккаунта:

  * `deploy-sa` — от его имени будет создаваться инфраструктура.

  * `speechsense-sa` — от его имени будут вызываться функции и запускаться рабочий процесс.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md): `deploy-sa`.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роли: [functions.admin](../../../functions/security/index.md#functions-admin), [storage.editor](../../../storage/security/index.md#storage-editor), [iam.editor](../../../iam/roles-reference.md#iam-editor), [mdb.admin](../../../iam/roles-reference.md#mdb-admin), `serverless.workflows.admin`.
  1. Нажмите кнопку **Создать**.
  1. Повторите предыдущие шаги и создайте сервисный аккаунт `speechsense-sa` c ролями [storage.viewer](../../../storage/security/index.md#storage-viewer), [functions.functionInvoker](../../../functions/security/index.md#functions-functionInvoker), [functions.mdbProxiesUser](../../../functions/security/index.md#functions-mdbProxiesUser), [lockbox.payloadViewer](../../../lockbox/security/index.md#lockbox-payloadViewer), `serverless.workflows.executor`.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт `deploy-sa`:

      ```bash
      yc iam service-account create deploy-sa
      ```

      Результат:

      ```
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-09-21T10:36:29.726397755Z"
      name: deploy-sa
      ```

      Сохраните идентификатор сервисного аккаунта `deploy-sa` (`id`) и каталога, в котором его создали (`folder_id`).

      Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Назначьте сервисному аккаунту `deploy-sa` роли [functions.admin](../../../functions/security/index.md#functions-admin), [storage.editor](../../../storage/security/index.md#storage-editor), [iam.editor](../../../iam/roles-reference.md#iam-editor), [mdb.admin](../../../iam/roles-reference.md#mdb-admin), `serverless.workflows.admin` на каталог, указав сохраненные ранее идентификаторы каталога и сервисного аккаунта:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role <роль> \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```
  
      Команда принимает только одну роль за раз.

      Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

      Если вы будете создавать секрет Yandex Lockbox через Yandex Cloud CLI  от имени сервисного аккаунта `deploy-sa`, также назначьте ему роль [lockbox.editor](../../../lockbox/security/index.md#lockbox-editor).

  1. Повторите предыдущие шаги и создайте сервисный аккаунт `speechsense-sa` c ролями [storage.viewer](../../../storage/security/index.md#storage-viewer), [functions.functionInvoker](../../../functions/security/index.md#functions-functionInvoker), [functions.mdbProxiesUser](../../../functions/security/index.md#functions-mdbProxiesUser), [lockbox.payloadViewer](../../../lockbox/security/index.md#lockbox-payloadViewer), `serverless.workflows.executor`.

- API {#api}

  
  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService.Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту `deploy-sa` роли [functions.admin](../../../functions/security/index.md#functions-admin), [storage.editor](../../../storage/security/index.md#storage-editor), [iam.editor](../../../iam/roles-reference.md#iam-editor), [mdb.admin](../../../iam/roles-reference.md#mdb-admin) и `serverless.workflows.admin`, воспользуйтесь методом [setAccessBindings](../../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService.SetAccessBindings](../../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

  Таким же способом назначьте сервисному аккаунту `speechsense-sa` роли [storage.viewer](../../../storage/security/index.md#storage-viewer), [functions.functionInvoker](../../../functions/security/index.md#functions-functionInvoker), [functions.mdbProxiesUser](../../../functions/security/index.md#functions-mdbProxiesUser), [lockbox.payloadViewer](../../../lockbox/security/index.md#lockbox-payloadViewer), `serverless.workflows.executor`.


{% endlist %}

### Создайте API-ключ для сервисного аккаунта {#create-key}

Создайте API-ключ для сервисного аккаунта `speechsense-sa`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт `speechsense-sa`.
  1. На панели сверху нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите пункт **Создать API-ключ**.
  1. В открывшемся окне в поле **Область действия** выберите [область действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.speech-sense.use`.
  1. Нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- Yandex Cloud CLI {#cli}

  Создайте API-ключ для сервисного аккаунта `speechsense-sa` и запишите ответ в файл `api_key.yaml`:

  ```bash
  yc iam api-key create \
    --service-account-name speechsense-sa \
    > api_key.yaml
  ```
  
  В результате вы получите файл `api_key.yaml`, который содержит значение API-ключа в поле `secret`:

  ```yaml
  api_key:
    id: ajeke74kbp5b********
    service_account_id: ajepg0mjt06s********
    created_at: "2019-04-09T08:41:27Z"
  secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHs********
  ```

- API {#api}

  
  Создайте API-ключ с помощью метода REST API [create](../../../iam/api-ref/ApiKey/create.md) для ресурса [ApiKey](../../../iam/api-ref/ApiKey/index.md):


  ```bash
  export SERVICEACCOUNT_ID=<идентификатор_сервисного_аккаунта>
  export IAM_TOKEN=<токен>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer $IAM_TOKEN" \
    --data "{ \"serviceAccountId\": \"$SERVICEACCOUNT_ID\" }" \
    https://iam.api.cloud.yandex.net/iam/v1/apiKeys
  ```

  Где:

  
  * `SERVICEACCOUNT_ID` — [идентификатор](../../../iam/operations/sa/get-id.md) сервисного аккаунта.
  * `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).

  Также API-ключ можно создать с помощью вызова gRPC API [ApiKeyService.Create](../../../iam/api-ref/grpc/ApiKey/create.md).


{% endlist %}      

### Создайте пространство {#create-space}

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

  1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
  1. Нажмите кнопку **Создать пространство**.
  1. Введите название пространства.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Добавьте сервисный аккаунт в пространство {#add-sa-to-space}

Добавьте сервисный аккаунт `speechsense-sa` в пространство SpeechSense.

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

  1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
  1. Перейдите в [новое пространство](#create-space).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/person-plus.svg) **Добавить участника** → ![image](../../../_assets/console-icons/persons.svg) **Добавить из организации**.
  1. Cкопируйте идентификатор [созданного ранее сервисного аккаунта](#create-sa) `speechsense-sa` и вставьте в строку поиска.
  1. Выберите сервисный аккаунт `speechsense-sa` и укажите роль [Data editor](https://aistudio.yandex.ru/docs/ru/speechsense/security/#speechsense-data-editor). Эта роль позволит сервисному аккаунту `speechsense-sa` загружать данные в SpeechSense.
  1. Нажмите кнопку **Добавить**.

{% endlist %}

### Создайте подключение {#create-connection}

В зависимости от типа файлов, которые будут загружаться в SpeechSense, создайте подключение для аудио или для чата.

#### Создайте подключение для аудио {#create-audio-connection}

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

  1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
  1. Перейдите в нужное пространство.
  1. В правом верхнем углу нажмите **Еще** → ![create](../../../_assets/console-icons/thunderbolt.svg) **Создать подключение**.
  1. Укажите название подключения.
  1. Выберите тип данных **Двухканальное аудио**.
  1. В блоках **Оператор**, **Клиент**:

      1. Укажите каналы, в которых записаны голос оператора и голос клиента.
      1. Укажите для оператора и клиента ключи из файла метаданных. Этот файл содержит информацию о звонке, полученную из CRM-систем, АТС или других источников.

        По умолчанию в подключение добавлены ключи с именем и идентификатором оператора и клиента. В поле **Название в системе** введите название, под которым ключ будет отображаться в SpeechSense.

        Чтобы указать дополнительные метаданные для оператора и клиента, нажмите кнопку **Добавить ключ**.

  1. В блоке **Общие метаданные** укажите не связанные с оператором и клиентом ключи из файла метаданных.

      По умолчанию в подключение добавлены ключи с датой, направлением звонка и языком диалога. В поле **Название в системе** введите название, под которым ключ будет отображаться в SpeechSense.

      Чтобы указать дополнительные метаданные, нажмите кнопку **Добавить ключ**.

  1. Нажмите кнопку **Создать подключение**.

{% endlist %}

#### Создайте подключение для чата {#create-chat-connection}

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

  1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
  1. Перейдите в нужное пространство.
  1. В правом верхнем углу нажмите **Еще** → ![create](../../../_assets/console-icons/thunderbolt.svg) **Создать подключение**.
  1. Укажите название подключения.
  1. Выберите тип данных **Чат**.
  1. В блоках **Оператор**, **Клиент**, **Бот** укажите ключи из файла метаданных. Этот файл содержит информацию о диалоге, полученную из чатов, CRM-систем или других источников.

      По умолчанию в подключение добавлены ключи с именем и идентификатором оператора, клиента и бота. В поле **Название в системе** введите название, под которым ключ будет отображаться в SpeechSense.

      Чтобы указать дополнительные метаданные для оператора, клиента и бота, нажмите кнопку **Добавить ключ**.

  1. В блоке **Общие метаданные** укажите не связанные с оператором, клиентом и ботом ключи из файла метаданных.

      По умолчанию в подключение добавлены ключи с датой, направлением и языком диалога. В поле **Название в системе** введите название, под которым ключ будет отображаться в SpeechSense.

      Чтобы указать дополнительные метаданные, нажмите кнопку **Добавить ключ**.

  1. Нажмите кнопку **Создать подключение**.

{% endlist %}

### Создайте проект {#create-project}

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

  1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
  1. Перейдите в нужное пространство.
  1. Нажмите кнопку ![create](../../../_assets/console-icons/folder-plus.svg) **Создать проект**.
  1. Введите имя проекта.
  1. В блоке **Подключение** нажмите **Добавить подключение** и выберите подключение, созданное [ранее](#create-connection).
  1. Нажмите кнопку **Создать проект**.

{% endlist %}

## Создайте инфраструктуру {#infra}

1. Склонируйте репозиторий [yc-serverless-speechsense-workflows](https://github.com/yandex-cloud-examples/yc-serverless-speechsense-workflows):

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-serverless-speechsense-workflows.git
    ```

    В репозитории находится скрипт, который создаст в облаке инфраструктуру, необходимую для загрузки файлов в SpeechSense:

      * бакет Object Storage;
      * кластер Managed Service for PostgreSQL;
      * функции Cloud Functions;
      * триггер для вызова функции Cloud Functions;
      * рабочий процесс Workflows;
      * подключения к базе данных кластера Managed Service for PostgreSQL.

1. Для успешной работы скрипта настройте аутентификацию Yandex Cloud CLI от имени сервисного аккаунта `deploy-sa`:

    {% list tabs group=instructions %}

    - Yandex Cloud CLI {#cli}

      1. Создайте [авторизованный ключ](../../../iam/concepts/authorization/key.md) для сервисного аккаунта `deploy-sa` и запишите его в файл:
      
          ```bash
          yc iam key create --output <путь_к_файлу_ключа> --service-account-name deploy-sa
          ```
      
          Где `--output` — путь к файлу для записи авторизованного ключа в формате JSON.

          Результат:
      
          ```bash
          id: aje4lue48687********
          service_account_id: ajeb9l33h6m********
          created_at: "2024-08-01T11:58:52.313177213Z"
          key_algorithm: RSA_2048
          ```
      
          Подробнее о команде `yc iam key create` см. в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/service-account/create.md).

       1. Создайте профиль, который будет использоваться для выполнения операций от имени сервисного аккаунта `deploy-sa`:

          ```bash
          yc config profile create <имя_профиля>
          ```

       1. Укажите в конфигурации профиля авторизованный ключ сервисного аккаунта `deploy-sa`:

          ```bash
          yc config set service-account-key <путь_к_файлу_ключа>
          ```   

    {% endlist %}

1. Перейдите в папку с репозиторием и запустите скрипт:

    {% list tabs group=programming_language %}

    - Bash {#bash}

        ```bash
        cd deploy && bash deploy.sh
        ```

    {% endlist %}

    
    В командной строке введите [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), имя сервисного аккаунта `speechsense-sa`, от которого будут вызываться функции и запускаться рабочий процесс, и [имя бакета](../../../storage/concepts/bucket.md#naming).


    Примерное время выполнения скрипта — 10-15 минут.

## Создайте секрет {#create-secret}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать секрет.
  1. Перейдите в сервис **Lockbox**.
  1. Нажмите кнопку **Создать секрет**.
  1. В поле **Имя** укажите имя секрета: `speechsense-secret`.

  1. В блоке **Данные секрета**:

        1. Выберите тип секрета **Пользовательский**.
        
        1. Добавьте API-ключ сервисного аккаунта:

            * В поле **Ключ** укажите: `speechsense_api_key`.
            * В поле **Значение** укажите значение [созданного ранее](#create-key) API-ключа сервисного аккаунта `speechsense-sa`.

        1. Нажмите кнопку **Добавить ключ/значение** и добавьте идентификатор подключения SpeechSense:

            * В поле **Ключ** укажите: `speechsense_connection_id`.
            * В поле **Значение** укажите идентификатор подключения, [созданного ранее](#create-connection).

        1. Нажмите кнопку **Добавить ключ/значение** и добавьте формат файлов с диалогами, которые будут загружены в SpeechSense:

            * В поле **Ключ** укажите: `speechsense_file_format`.
            * В поле **Значение** укажите формат файла. Допустимые значения: `mp3`,`wav`,`ogg`, `text`.

  1. Нажмите кнопку **Создать**.

- Yandex Cloud CLI {#cli}

  Чтобы создать секрет, выполните команду:

  ```bash
  yc lockbox secret create --name speechsense-secret \
    --payload "[{'key': 'speechsense_api_key', 'text_value': '<API-ключ>'},{'key': 'speechsense_connection_id', 'text_value': '<идентификатор_подключения>'}, {'key': 'speechsense_file_format', 'text_value': '<формат_файлов>'}]"
  ```

  Результат:

  ```text
  id: e6q2ad0j9b55********
  folder_id: b1gktjk2rg49********
  created_at: "2021-11-08T19:23:00.383Z"
  name: speechsense-secret
  status: ACTIVE
  current_version:
    id: g6q4fn3b6okj********
    secret_id: e6e2ei4u9b55********
    created_at: "2023-03-21T19:23:00.383Z"
    status: ACTIVE
    payload_entry_keys:
      - speechsense_api_key
      - speechsense_connection_id
      - speechsense_file_format
  ```

- API {#api}

  
  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService.Create](../../../lockbox/api-ref/grpc/Secret/create.md).


{% endlist %}


## Создайте модель данных {#create-table}

1. В папке с репозиторием откройте файл `pg_metadata.sql`.

1. В блоке, отвечающем за вставку данных в таблицу `public.source_system`, укажите значения параметров:

    ```sql
    insert into public.source_system(source_system_id, lockbox_secret_id, source_system_desc)
    values ('<идентификатор_источника>', '<идентификатор_секрета>', '<описание_источника>');
    ```

    Где:  

    * `source_system_id` — идентификатор источника данных, который будет использоваться в метаданных. Укажите любое уникальное строковое значение. Например: `000001`.
    * `lockbox_secret_id` — идентификатор секрета Yandex Lockbox, созданного [ранее](#create-secret). Например: `e6qigo0vbci2********`.
    * `source_system_desc` — описание источника данных. Например: `Загрузка данных телефонии`.

1. Скопируйте содержимое файла `pg_metadata.sql` и выполните получившийся запрос c помощью сервиса WebSQL:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
        1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
        1. Нажмите на имя кластера, [созданного ранее](#infra). По умолчанию это `speechsense-upload-metadata`.
        1. Выберите вкладку **WebSQL**.
        1. Нажмите на имя подключения, которое заканчивается на `-uploader`.
        1. На странице сервиса WebSQL нажмите на имя БД — `uploader`.
        1. Вставьте запрос в редактор и нажмите кнопку **Выполнить**.

    {% endlist %}

## Создайте папки для хранения файлов и их метаданных {#create-folder}

В [созданном ранее](#infra) бакете Object Storage создайте две папки:

  * `client_data` — для файлов с диалогами.
  * `client_metadata` — для файлов с метаданными.

Папки не должны быть вложены одна в другую.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать папку:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится бакет.
    1. Перейдите в сервис **Object Storage**.
    1. Выберите нужный бакет.
    1. Нажмите **Создать папку** и укажите имя папки.
    1. Нажмите на кнопку **Создать**.

- Yandex Cloud CLI {#cli}

  Чтобы создать папку, выполните команду:

    ```bash
    yc storage s3api put-object \
      --bucket <имя_бакета> \
      --key <имя_папки>/
    ```

  Результат:

    ```bash
    etag: '"d41d8cd98f00b204e9800998********"'
    request_id: ba96231*********
    ```        

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).

  Чтобы создать папку, выполните команду:

    ```bash
    aws s3api put-object \
      --endpoint-url=https://storage.yandexcloud.net \
      --bucket <имя_бакета>
      --key <имя_папки>/
    ```

  Результат:

    ```bash
    {
    "ETag": "\"d41d8cd98f00b204e9800998********\""
    }
    ```

- API {#api}

  Чтобы создать папку, воспользуйтесь методом S3 API [upload](../../../storage/s3/api-ref/object/upload.md).

{% endlist %}


## Подготовьте метаданные {#prepare-metadata}

{% note info %}

Даты указываются в формате ISO 8601 UTC с нулевым смещением времени. Если необходимо указать московское время, добавьте `+03:00` вместо `Z` в конец строки: `2025-04-24T14:34:19+03:00`.

{% endnote %}

Чтобы загрузить файл в SpeechSense, подготовьте его метаданные в формате `JSON`. Например:

```json
{
  "source_system_id": "000001",
  "bucket_folder": "bucket://client_data",
  "metadata": [
    {
      "id": "my_audio.ogg",
      "operator_id": "42",
      "operator_name": "Иван Петров",
      "client_id": "327142",
      "client_name": "Петр Иванов",
      "date": "2024-08-30T19:32:11Z",
      "direction_outgoing": "0",
      "language": "ru-ru",
      "file_name": "my_audio.ogg"
    }
  ]
}
```

Где:

  * Параметры, которые используются функцией `speechsense-upload` для загрузки файлов:

    * `source_system_id` — идентификатор источника данных, указанный в [таблице `public.source_system`](#create-table).

    * `bucket_folder` — путь к [созданной ранее](#create-folder) папке для аудиозаписей или текстовых файлов.

    * `file_name` — имя файла, который будет загружен.

  * Параметры, обязательные для передачи в SpeechSense:
  
    * `id` — идентификатор файла, уникальный для пространства SpeechSense.

    * `operator_id` — идентификатор оператора.

    * `operator_name` — имя оператора.

    * `client_id` — идентификатор клиента 

    * `client_name` — имя клиента.

    * `date` — дата и время звонка в формате `YYYY-MM-DDTHH:MM:SSZ`.

    * `direction_outgoing` — направление звонка. `0` — для исходящего звонка, `1` — для входящего.

    * `language` — язык диалога. `ru-ru` — для русского языка.

  * Дополнительные параметры для аналитики в SpeechSense:

      * `cpn_region_id` — идентификатор региона.

      * `cpn_region_name` — название региона.

      `cpn_region_id` и `cpn_region_name` использованы в качестве примера. Дополнительные параметры могут быть другими.

Метаданные могут содержать одну запись или массив из нескольких записей. 

{% note warning %}

Не передавайте больше 100 записей одновременно: это может привести к потере данных, так как время выполнения функции Cloud Functions ограничено таймаутом.

Если файлов для загрузки больше 100, разделите их метаданные на отдельные JSON-файлы по 100 записей.

{% endnote %}


## Загрузите файлы {#upload-files}

Загрузите файлы с диалогами в папку `client_data`, а JSON-файлы с метаданными — в папку `client_metadata`.

{% note warning %}

Не загружайте файлы с диалогами в папку `client_metadata` или вложенные в нее папки. Появление новых файлов в папке запустит рабочий процесс, но файлы с диалогами не пройдут проверку синтаксиса, которую проходят файлы с метаданными, и процесс завершится ошибкой.

{% endnote %}

Если файлов больше 1000, не используйте для загрузки консоль управления.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы загрузить файлы:

    1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
    1. Перейдите в сервис **Object Storage**.
    1. Перейдите в бакет, в который нужно загрузить файлы.
    1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **Объекты**.
    1. Перейдите в нужную папку, нажав на ее имя.
    1. Оказавшись в нужной папке, на верхней панели нажмите ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **Загрузить**.
    1. В появившемся окне выберите необходимые файлы и нажмите **Открыть**.
    1. Консоль управления отобразит все файлы, выбранные для загрузки, и предложит для каждого из них выбрать [класс хранилища](../../../storage/concepts/storage-class.md). Класс хранилища по умолчанию определяется [настройкой бакета](../../../storage/concepts/bucket.md#bucket-settings).
    1. Нажмите **Загрузить**.
    1. Обновите страницу.

    В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут. 

- Yandex Cloud CLI {#cli}

  Чтобы загрузить файл в папку, выполните команду:

    ```bash
    yc storage s3api put-object \
      --body <путь_к_загружаемому_файлу> \
      --bucket <имя_бакета> \
      --key <имя_папки>/<имя_файла>
    ```

    Где:

    * `--body` — путь к файлу, который нужно загрузить.
    * `--bucket` — имя бакета.
    * `--key` — путь к файлу в папке.

  Результат:

    ```bash
    etag: '"d41d8cd98f00b204e980099********"'
    request_id: 3f2705f********
    ```    

- AWS CLI {#aws-cli}

  Чтобы загрузить один файл, выполните команду:

    ```bash
    aws --endpoint-url=https://storage.yandexcloud.net/ \
      s3 cp <путь_к_загружаемому_файлу> s3://<имя_бакета>/<имя_папки>/<имя_файла>
    ```

  Чтобы загрузить все файлы из локальной директории и вложенных в нее директорий, используйте команду:
   
    ```bash
    aws --endpoint-url=https://storage.yandexcloud.net/ \
      s3 cp --recursive <путь_к_директории_с_загружаемыми_файлами>/ s3://<имя_бакета>/<имя_папки>/
    ```

  Результат:

    ```bash
    upload: <имя_файла> to <путь_к_файлу_в_бакете>
    ```

- API {#api}

  Чтобы загрузить файл, воспользуйтесь методом S3 API [upload](../../../storage/s3/api-ref/object/upload.md).     

{% endlist %}

{% note tip %}

Чтобы ускорить обработку аудиозаписей, используйте файлы формата `OggOpus`. Файлы других форматов можно сконвертировать в `OggOpus` с помощью утилит [FFmpeg](https://www.ffmpeg.org) или [SoX](https://sourceforge.net/projects/sox/).

{% endnote %}

## Проверьте результат {#check-result}

Чтобы проверить выполнение рабочего процесса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева выберите ![GraphNode](../../../_assets/console-icons/graph-node.svg) **Workflows**.
  1. Нажмите на имя рабочего процесса. По умолчанию это `wf-speechsense-upload`.
  1. Перейдите на вкладку **Запуски**.
  1. Убедитесь, что рабочий процесс находится в статусе `Выполнен`.

{% endlist %}

Чтобы проверить, что файлы загрузились в SpeechSense:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте страницу [сервиса WebSQL](https://websql.yandex.cloud).
  1. В разделе ![image](../../../_assets/console-icons/folder-tree.svg) **Подключения** выберите подключение `speechsense-upload-metadata` и БД `uploader`.
  1. Выберите схему `public`.
  1. В группе **Таблицы** выберите таблицу:

      * `talk` — для просмотра загруженных в SpeechSense метаданных. Если файл с диалогом загружен, в его метаданных должен быть указан идентификатор `talk_id`.
      * `errors` — для просмотра ошибок, если загрузить файлы не удалось.

{% endlist %}

## Удалите ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать.


1. [Удалите](../../../storage/operations/buckets/delete.md) объекты в бакете Object Storage и сам бакет.
1. [Удалите](../../../managed-postgresql/operations/cluster-delete.md) кластер Managed Service for PostgreSQL.
1. [Удалите](../../../functions/operations/trigger/trigger-delete.md) триггер для вызова функции Cloud Functions.
1. [Удалите](../../../functions/operations/function/function-delete.md) функции Cloud Functions.
1. Удалите подключение к базе данных кластера Managed Service for PostgreSQL:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите удалить подключение.
    1. Перейдите в сервис **Cloud Functions**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/timestamps.svg) **Подключения к БД**.
    1. В строке с подключением `speechsense-upload-metadata-connection` нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
    1. В открывшемся окне нажмите **Удалить**.

1. Удалите рабочий процесс Workflows:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите удалить рабочий процесс.
    1. Перейдите в сервис **Serverless Integrations**.
    1. На панели слева выберите ![GraphNode](../../../_assets/console-icons/graph-node.svg) **Workflows**.
    1. В строке с рабочим процессом `wf-speechsense-upload` нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
    1. В открывшемся окне нажмите **Удалить**.