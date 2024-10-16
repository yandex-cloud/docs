# Использование данных из {{ objstorage-full-name }} для обучения модели в {{ ml-platform-name }}


Вы создадите [бакет](../../storage/concepts/bucket.md) в [{{ objstorage-name }}](../../storage/), смонтируете его к файловой системе Windows с помощью [rclone](https://rclone.org) и загрузите туда данные для обучения [модели](../../datasphere/concepts/models/index.md) в [{{ ml-platform-full-name }}]({{ link-datasphere-main }}).

Чтобы использовать данные из {{ objstorage-name }} для обучения модели в {{ ml-platform-name }}:
1. [Подготовьте инфраструктуру](#infra).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Создайте бакет](#bucket-create).
1. [Настройте подключение к {{ objstorage-name }}](#rclone-config).
1. [Смонтируйте бакет](#bucket-mount).
1. [Подготовьте данные для обучения](#prepare-data).
1. [Создайте коннектор S3](#create-s3).
1. [Подключите бакет к проекту](#create-s3).
1. [Обучите модель](#train-model).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость реализации обучения модели с помощью данных из {{ objstorage-name }} входят:
* Плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md).
* Плата за хранение данных в бакете (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-storage)).
* Плата за операции с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-operations)).

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

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

  1. В [консоли управления]({{ link-console-main }}) выберите [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и нажмите кнопку ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
  1. Введите имя [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), например, `data-folder`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для {{ objstorage-name }} {#create-sa}

Для доступа к бакету в {{ objstorage-name }} вам понадобится [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../../iam/concepts/access-control/roles.md) `storage.editor`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта, например, `datasphere-sa`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роль `storage.editor`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Создайте статический ключ доступа {#create-static-key}

Чтобы получить доступ к {{ objstorage-name }} из {{ ml-platform-name }}, вам понадобится [статический ключ](../../iam/concepts/authorization/access-key.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите сервисный аккаунт `datasphere-sa`.
  1. На верхней панели нажмите кнопку ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
  1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание статического ключа и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ. После закрытия диалога значение ключа будет недоступно.

- {{ yandex-cloud }} CLI {#cli}

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

     Подробнее о команде `yc iam access-key create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/iam/access-key/create.md).
  1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

- API {#api}

  Чтобы создать статический ключ доступа, воспользуйтесь методом [create](../../iam/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/api-ref/AccessKey/index.md).

{% endlist %}

## Создайте бакет {#bucket-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI {#cli}
  
  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
  1. Создайте бакет, указав имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming):

     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://<имя_бакета>
     ```

     Результат:

     ```text
     make_bucket: <имя_бакета>
     ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../_includes/storage/terraform-role.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры для создания сервисного аккаунта и ключа доступа:

     {% include [terraform-sa-key](../../_includes/storage/terraform-sa-key.md) %}

  1. Добавьте в конфигурационный файл блок с параметрами бакета, указав имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming):

     ```hcl
     resource "yandex_storage_bucket" "<имя_бакета>" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<имя_бакета>"
     }
     ```

     Подробнее о ресурсе `yandex_storage_bucket` см. в [документации]({{ tf-provider-link }}/storage_bucket) провайдера {{ TF }}.
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Используйте метод REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызов gRPC API [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create) или метод S3 API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}

## Настройте подключение к {{ objstorage-name }} {#rclone-config}

Чтобы перенести данные с локального диска в {{ objstorage-name }}, вам нужно настроить утилиту `rclone`.
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
   1. Укажите регион: введите в терминал значение `{{ region-id }}`.
   1. Укажите эндпоинт: введите в терминал значение `{{ s3-storage-host }}`.
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

Чтобы подключиться к бакету из {{ ml-platform-name }}, вам понадобится [коннектор S3](../../datasphere/concepts/s3-connector.md):
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Заполните поля:
   * **{{ ui-key.yc-ui-datasphere.common.name }}** — имя создаваемого коннектора, например `s3-datasphere-connect`.
   * **{{ ui-key.yc-ui-datasphere.common.endpoint }}** — хост {{ objstorage-name }} — `https://{{ s3-storage-host }}/`.
   * **{{ ui-key.yc-ui-datasphere.common.bucket }}** — имя вашего бакета.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mount-name }}** — название тома при монтировании бакета в файловую систему проекта.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.access-key-id }}**, который используется для подключения к хранилищу.
   * В поле **{{ ui-key.yc-ui-datasphere.new-s3-page.static-access-key }}** нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**. В открывшемся окне введите имя секрета и секретный ключ, который используется для подключения к хранилищу.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Перейдите на страницу коннектора S3 и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.activate }}**. После активации бакет будет доступен в интерфейсе {{ jlab }}Lab в списке на вкладке **S3 Mounts** ![S3 Mounts](../../_assets/console-icons/bucket.svg), и его можно будет просматривать как файловую систему.

## Обучите модель {#train-model}

Склонируйте Git-репозиторий, в котором находится ноутбук `diabetes_catboost.ipynb` с примером обучения модели [CatBoost](https://catboost.ai/):
1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}
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
* [Удалите объекты](../../storage/operations/objects/delete-all.md) из бакета.
* [Удалите бакет](../../storage/operations/buckets/delete.md).
* [Удалите](../../datasphere/operations/projects/delete.md) проект.