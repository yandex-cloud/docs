# Использование данных из Object Storage для обучения модели в Yandex DataSphere

# Использование данных из Yandex Object Storage для обучения модели в DataSphere


Вы создадите [бакет](../concepts/bucket.md) в [Object Storage](../index.md), смонтируете его к файловой системе Windows с помощью [rclone](https://rclone.org) и загрузите туда данные для обучения [модели](../../datasphere/concepts/models/index.md) в [Yandex DataSphere](https://datasphere.yandex.cloud).

Чтобы использовать данные из Object Storage для обучения модели в DataSphere:
1. [Подготовьте инфраструктуру](#infra).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Создайте бакет](#bucket-create).
1. [Настройте подключение к Object Storage](#rclone-config).
1. [Смонтируйте бакет](#bucket-mount).
1. [Подготовьте данные для обучения](#prepare-data).
1. [Создайте коннектор S3](#create-s3).
1. [Подключите бакет к проекту](#create-s3).
1. [Обучите модель](#train-model).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../../datasphere/concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../../datasphere/operations/community/create.md).
1. [Привяжите платежный аккаунт](../../datasphere/operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.

### Необходимые платные ресурсы {#paid-resources}

В стоимость реализации обучения модели с помощью данных из Object Storage входят:
* Плата за использование [вычислительных ресурсов DataSphere](../../datasphere/pricing.md).
* Плата за хранение данных в бакете (см. [тарифы Object Storage](../pricing.md#prices-storage)).
* Плата за операции с данными (см. [тарифы Object Storage](../pricing.md#prices-operations)).

## Подготовьте инфраструктуру {#infra}

Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud и выберите организацию, в которой вы работаете с DataSphere. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен платежный аккаунт.

Если у вас есть активный платежный аккаунт, на [странице облака](https://console.yandex.cloud/cloud) вы можете создать или выбрать каталог, в котором будет работать ваша инфраструктура.

{% note info %}

Если вы работаете с Yandex Cloud через [федерацию удостоверений](../../organization/concepts/add-federation.md), вам может быть недоступна платежная информация. В этом случае обратитесь к администратору вашей организации в Yandex Cloud.

{% endnote %}

### Подготовьте рабочее окружение {#environment-prepare}

{% list tabs group=operating_system %}

- Windows {#windows}

  Скачайте и установите [дистрибутив winfsp](https://winfsp.dev/rel/) с сайта производителя.

  Скачайте с сайта производителя и распакуйте в свою рабочую директорию на локальном компьютере:
  * [Архив с утилитами sysinternals suite](https://docs.microsoft.com/en-us/sysinternals/downloads/).
  * [Архив с утилитой Windows Service Wrapper (winsw)](https://github.com/winsw/winsw/releases).
  * [Архив с утилитой rclone](https://rclone.org/downloads/).

{% endlist %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и нажмите кнопку ![create](../../_assets/console-icons/plus.svg) **Создать каталог**.
  1. Введите имя [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), например, `data-folder`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте сервисный аккаунт для Object Storage {#create-sa}

Для доступа к бакету в Object Storage вам понадобится [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../../iam/concepts/access-control/roles.md) `storage.editor`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта, например, `datasphere-sa`.
  1. Нажмите **Добавить роль** и назначьте сервисному аккаунту роль `storage.editor`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте статический ключ доступа {#create-static-key}

Чтобы получить доступ к Object Storage из DataSphere, вам понадобится [статический ключ](../../iam/concepts/authorization/access-key.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В открывшемся списке выберите сервисный аккаунт `datasphere-sa`.
  1. На верхней панели нажмите кнопку ![](../../_assets/console-icons/plus.svg) **Создать новый ключ**.
  1. Выберите **Создать статический ключ доступа**.
  1. Задайте описание статического ключа и нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ. После закрытия диалога значение ключа будет недоступно.

- Yandex Cloud CLI {#cli}

  1. Создайте статический ключ доступа для сервисного аккаунта `datasphere-sa`:

     ```bash
     yc iam access-key create --service-account-name datasphere-sa
     ```

     Результат:

     ```text
     access_key:
       id: aje6t3vsbj8l********
       service_account_id: ajepg0mjt06s********
       created_at: "2022-07-18T14:37:51Z"
       key_id: 0n8X6WY6S24N7Oj*****
     secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hx*****
     ```

     Подробнее о команде `yc iam access-key create` см. в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/access-key/create.md).
  1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

- API {#api}

  Чтобы создать статический ключ доступа, воспользуйтесь методом [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md).

{% endlist %}

## Создайте бакет {#bucket-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Справа сверху нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите имя бакета в соответствии с [правилами именования](../concepts/bucket.md#naming).
  1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите **С авторизацией**.
  1. Нажмите кнопку **Создать бакет**.

- AWS CLI {#cli}
  
  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).
  1. Создайте бакет, указав имя бакета в соответствии с [правилами именования](../concepts/bucket.md#naming):

     ```bash
     aws --endpoint-url https://storage.yandexcloud.net \
       s3 mb s3://<имя_бакета>
     ```

     Результат:

     ```text
     make_bucket: <имя_бакета>
     ```

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры для создания сервисного аккаунта и ключа доступа:

     ```hcl
     ...
     // Создание сервисного аккаунта
     resource "yandex_iam_service_account" "sa" {
       name = "<имя_сервисного_аккаунта>"
     }
     
     // Назначение роли сервисному аккаунту
     resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
       folder_id = "<идентификатор_каталога>"
       role      = "storage.admin"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }
     
     // Создание статического ключа доступа
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }
     ```

  1. Добавьте в конфигурационный файл блок с параметрами бакета, указав имя бакета в соответствии с [правилами именования](../concepts/bucket.md#naming):

     ```hcl
     resource "yandex_storage_bucket" "<имя_бакета>" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<имя_бакета>"
     }
     ```

     Подробнее о ресурсе `yandex_storage_bucket` см. в [документации](../../terraform/resources/storage_bucket.md) провайдера Terraform.
  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Terraform создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Используйте метод REST API [create](../api-ref/Bucket/create.md) для ресурса [Bucket](../api-ref/Bucket/index.md), вызов gRPC API [BucketService/Create](../api-ref/grpc/Bucket/create.md) или метод S3 API [create](../s3/api-ref/bucket/create.md).

{% endlist %}

## Настройте подключение к Object Storage {#rclone-config}

Чтобы перенести данные с локального диска в Object Storage, вам нужно настроить утилиту `rclone`.
1. В рабочей директории запустите командную строку от имени администратора и выполните команду:

   ```powershell
   .\psexec -i -s cmd.exe
   ```

1. В открывшейся консоли выполните команду `whoami` и убедитесь, что сессия запущена от имени системного пользователя.
1. Перейдите в рабочую директорию и запустите конфигурацию утилиты `rclone`:

   ```powershell
   rclone.exe config
   ```

1. Следуя запросам приложения, создайте новый профиль подключения:
   1. Выберите создание нового профиля: введите в терминал значение `n`.
   1. Введите имя подключения: `s3-connect`.
   1. Выберите тип хранилища: введите в терминал значение `4`.
   1. Выберите провайдера: введите в терминал значение `1`.
   1. Выберите ручной способ ввода учетных данных: введите в терминал значение `1`.
   1. Введите в терминале идентификатор секретного ключа.
   1. Введите в терминале значение секретного ключа.
   1. Укажите регион: введите в терминал значение `ru-central1`.
   1. Укажите эндпоинт: введите в терминал значение `storage.yandexcloud.net`.
   1. Остальные настройки можно оставить по умолчанию — нажимайте **Enter**, чтобы их пропустить.

{% note info %}

При необходимости вы можете выполнить расширенную настройку подключения. Для этого на шаге `Edit advanced config?` введите в терминале `y`. Подробнее с расширенными настройками можно ознакомиться [на странице документации](https://rclone.org/s3/) утилиты `rclone`.

{% endnote %}

## Смонтируйте бакет к файловой системе Windows {#bucket-mount}

1. Проверьте подключение к бакету. В той же командной строке, где выполнялась настройка подключения, выполните команду, указав имя бакета:

   ```powershell
   rclone.exe ls s3-connect:<имя_бакета>
   ```

   Если конфигурация настроена правильно, в консоль будет выведен список объектов бакета.
1. Смонтируйте бакет в файловую систему, указав имя бакета и свободную букву диска в файловой системе:

   ```powershell
   rclone.exe mount s3-connect:<имя_бакета> <буква_диска>: --vfs-cache-mode full
   ```

   В проводнике Windows появится новый диск с объектами из бакета.

## Подготовьте данные для обучения {#prepare-data}

1. [Скачайте CSV-файл](https://storage.yandexcloud.net/doc-files/diabetes_data.csv), содержащий данные по предсказанию наличия диабета. [Датасет](../../datasphere/concepts/dataset.md) создан на основе данных [Kaggle](https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset?select=diabetes_012_health_indicators_BRFSS2015.csv) за 2015 год.
1. Скопируйте файл в смонтированный бакет.

## Подключите бакет к проекту {#create-s3}

Чтобы подключиться к бакету из DataSphere, вам понадобится [коннектор S3](../../datasphere/concepts/s3-connector.md):
1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В правом верхнем углу нажмите кнопку **Создать ресурс**. Во всплывающем окне выберите **Коннектор S3**.
1. Заполните поля:
   * **Имя** — имя создаваемого коннектора, например `s3-datasphere-connect`.
   * **Эндпоинт** — хост Object Storage — `https://storage.yandexcloud.net/`.
   * **Бакет** — имя вашего бакета.
   * **Имя раздела при подключении** — название тома при монтировании бакета в файловую систему проекта.
   * **Идентификатор статического ключа доступа**, который используется для подключения к хранилищу.
   * В поле **Статический ключ доступа** нажмите **Создать**. В открывшемся окне введите имя секрета и секретный ключ, который используется для подключения к хранилищу.
1. Нажмите кнопку **Создать**.
1. Перейдите на страницу коннектора S3 и нажмите кнопку **Активировать**. После активации бакет будет доступен в интерфейсе JupyterLab в списке на вкладке **S3 Mounts** ![S3 Mounts](../../_assets/console-icons/bucket.svg), и его можно будет просматривать как файловую систему.

## Обучите модель {#train-model}

Склонируйте Git-репозиторий, в котором находится ноутбук `diabetes_catboost.ipynb` с примером обучения модели [CatBoost](https://catboost.ai/):
1. Откройте проект DataSphere:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
   1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.
1. В верхнем меню нажмите **Git** и выберите **Clone**.
1. В открывшемся окне введите URI репозитория `https://github.com/yandex-cloud-examples/yc-datasphere-s3-mount.git` и нажмите кнопку **Clone**.

В ноутбуке `diabetes_catboost.ipynb` вы подключитесь к датасету `diabetes_data.csv` в вашем смонтированном бакете и обучите модель `CatBoost`:
1. Установите необходимые модули:

   ```python
   %pip install catboost
   %pip install scikit-learn
   %pip install ipywidgets
   ```

1. Импортируйте необходимые библиотеки:

   ```python
   import pandas as pd
   from catboost import CatBoostClassifier
   from sklearn.metrics import classification_report
   from sklearn.model_selection import train_test_split
   ```

1. Загрузите данные для обучения:

   ```python
   data = pd.read_csv('<путь_к_датасету>')
   data.head()
   ```

   Чтобы получить путь к файлу `diabetes_data.csv`, во вкладке **S3 Mounts** ![S3 Mounts](../../_assets/console-icons/bucket.svg) нажмите на него правой кнопкой мыши и выберите **Copy path**.
1. Разделите факторы для обучения и целевую переменную:

   ```python
   X = data.loc[:, data.columns != 'Diabetes_binary']
   y = data['Diabetes_binary']
   ```

1. Разделите выборку на обучающую и тестовую:

   ```python
   X_train, X_validation, y_train, y_validation = train_test_split(X, y, train_size=0.75, random_state=42)
   ```

1. Создайте классификатор `СatBoost` и задайте гиперпараметры:

   ```python
   model = CatBoostClassifier(
     iterations=100,
     random_seed=42,
     logging_level='Verbose'
   )
   ```

1. Запустите обучение модели:

   ```python
   model.fit(
     X_train, y_train,
     eval_set=(X_validation, y_validation),
     plot=True
   )
   ```

1. Выведите метрики качества обученной модели на экран:

   ```python
   print(classification_report(y_validation, model.predict(X_validation)))
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите объекты](../operations/objects/delete-all.md) из бакета.
* [Удалите бакет](../operations/buckets/delete.md).
* [Удалите](../../datasphere/operations/projects/delete.md) проект.