# Создание сервера MLFlow для логирования экспериментов и артефактов

В практическом руководстве показано, как развернуть [MLFlow Tracking Server](https://mlflow.org/docs/latest/tracking.html) для логирования экспериментов и артефактов на отдельной виртуальной машине [{{ compute-full-name }}](../../compute/). Эксперименты будут проводиться в {{ jlab }}Lab Notebook. Для хранения внутренних объектов будет использоваться база данных [{{ mpg-full-name }}](../../managed-postgresql/), а для хранения артефактов — бакет [{{ objstorage-full-name }}](../../storage/).

Чтобы создать сервер MLFlow для логирования экспериментов и артефактов {{ jlab }}Lab Notebook:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Создайте пару ключей SSH](#create-ssh-keys).
1. [Создайте виртуальную машину](#create-vm).
1. [Создайте управляемую БД](#create-db).
1. [Создайте бакет](#create-bucket).
1. [Установите MLFlow Tracking Server и добавьте его в автозагрузку ВМ](#setup-mlflow).
1. [Создайте секреты](#create-secrets).
1. [Обучите модель](#train-model).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость реализации обучения модели с помощью данных из {{ objstorage-name }} входят:

* плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md);
* плата за использование [вычислительных ресурсов {{ compute-name }}](../../compute/pricing.md);
* плата за запущенный кластер [{{ mpg-name }}](../../managed-postgresql/pricing.md);
* плата за хранение данных в бакете (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-operations)).

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например, `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для {{ objstorage-name }} {#create-sa}

Для доступа к бакету в {{ objstorage-name }} вам понадобится [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролями `storage.viewer` и `storage.uploader`.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
   1. На вкладке **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя сервисного аккаунта, например, `datasphere-sa`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роли `storage.viewer` и `storage.uploader`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Создайте статический ключ доступа {#create-static-key}

Чтобы получить доступ к {{ objstorage-name }} из {{ ml-platform-name }}, вам понадобится статический ключ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт `datasphere-sa`.
  1. На верхней панели нажмите кнопку ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
  1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ. После закрытия диалога значение ключа будет недоступно.

- CLI {#cli}

  1. Создайте ключ доступа для сервисного аккаунта `datasphere-sa`:

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

  1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

- API {#api}

  Чтобы создать ключ доступа, воспользуйтесь методом [create](../../iam/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/api-ref/AccessKey/index.md).

{% endlist %}

## Создайте пару ключей SSH {#create-ssh-keys}

Чтобы подключаться к [виртуальной машине](../../compute/concepts/vm.md) по [SSH](../../glossary/ssh-keygen.md), нужна пара ключей: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя. Такой способ более безопасен, чем подключение по логину и паролю.

{% include [vm-connect-ssh-linux-note](../../_includes/vm-connect-ssh-linux-note.md) %}

Чтобы создать пару ключей:

{% include [vm-ssh-prepare-key](../../_includes/vm-ssh-prepare-key.md) %}

## Создайте виртуальную машину {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.  
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
     * Введите имя ВМ, например `mlflow-vm`.
     * Выберите зону доступности `{{ region-id }}-a`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите `Ubuntu 22.04`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.section_disk }}** настройте загрузочный диск:
     * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}`.
     * **{{ ui-key.yacloud.compute.disk-form.field_size }}** — `20 ГБ`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
     * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `4`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите подсеть, которая указана в [настройках проекта](../../datasphere/operations/projects/update.md) {{ ml-platform-name }}. У подсети должен быть [настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
     * **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** — `datasphere-sa`.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](#create-ssh-keys).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

## Создайте управляемую БД {#create-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Введите имя кластера, например `mlflow-bd`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите конфигурацию `s3-c2-m8`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** выберите `250 ГБ`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** введите имя пользователя и пароль. Они понадобятся для подключения.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** выберите зону доступности `{{ region-id }}-a`.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Зайдите в созданную БД и нажмите **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
  1. Сохраните ссылку на хост из поля `host` — она понадобится для подключения.

{% endlist %}

## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета, например `mlflow-bucket`.
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. Чтобы создать папку для артефактов MLflow, зайдите в созданный бакет и нажмите **{{ ui-key.yacloud.storage.bucket.button_create }}**.
  1. Введите имя папки, например `artifacts`.

{% endlist %}

## Установите MLFlow Tracking Server и добавьте его в автозагрузку ВМ {#setup-mlflow}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине через SSH.
1. Скачайте дистрибутив `Anaconda`:

   ```bash
   curl -O https://repo.anaconda.com/archive/Anaconda3-2023.07-1-Linux-x86_64.sh
   ```

1. Запустите установку:

   ```bash
   bash Anaconda3-2023.07-1-Linux-x86_64.sh
   ```

   Дождитесь окончания установки и перезапустите оболочку.

1. Создайте окружение:

   ```bash
   conda create -n mlflow
   ```

1. Активируйте окружение:

   ```bash
   conda activate mlflow
   ```

1. Установите необходимые пакеты, последовательно выполнив команды:

   ```bash
   conda install -c conda-forge mlflow
   conda install -c anaconda boto3
   pip install psycopg2-binary
   pip install pandas
   ```

1. Создайте переменные окружения для доступа к S3:

   * Откройте файл с переменными:

      ```bash
      sudo nano /etc/environment
      ```   
   
   * Добавьте в него следующие строки, подставив значение внутреннего IP вашей виртуальной машины:

     ```bash
     MLFLOW_S3_ENDPOINT_URL=https://{{ s3-storage-host }}/
     MLFLOW_TRACKING_URI=http://<внутренний_IP-адрес_виртуальной_машины>:8000
     ```

1. Укажите данные, которые будут использоваться библиотекой `boto3` для доступа к S3:

   * Создайте папку `.aws`:

     ```bash
     mkdir ~/.aws
     ```

   * Создайте файл `credentials`:

     ```bash
     nano ~/.aws/credentials
     ```

   * Добавьте в него следующие строки, подставив идентификатор и значение статического ключа:

     ```bash
     [default]
     aws_access_key_id=<идентификатор_статического_ключа>
     aws_secret_access_key=<секретный_ключ>
     ```

1. Запустите MLFlow Tracking Server, подставив данные вашего кластера:

   ```bash
   mlflow server --backend-store-uri postgresql://<имя_пользователя>:<пароль>@<хост>:6432/db1?sslmode=verify-full --default-artifact-root s3://mlflow-bucket/artifacts -h 0.0.0.0 -p 8000
   ```   

   Проверить подключение к MLFlow можно по ссылке `http://<публичный_IP-адрес_виртуальной_машины>:8000`.

### Включите автозапуск MLFlow {#autorun}

Чтобы MLFlow автоматически запускался после перезагрузки виртуальной машины, нужно сделать его службой `Systemd`.

1. Создайте директории для хранения логов и ошибок:

   ```bash
   mkdir ~/mlflow_logs/
   mkdir ~/mlflow_errors/
   ```

1. Создайте файл `mlflow-tracking.service`:

   ```bash
   sudo nano /etc/systemd/system/mlflow-tracking.service
   ```

1. Добавьте в него следующие строки, подставив свои данные:

   ```bash
   [Unit]
   Description=MLflow Tracking Server
   After=network.target

   [Service]
   Environment=MLFLOW_S3_ENDPOINT_URL=https://{{ s3-storage-host }}/
   Restart=on-failure
   RestartSec=30
   StandardOutput=file:/home/<имя_пользователя_ВМ>/mlflow_logs/stdout.log
   StandardError=file:/home/<имя_пользователя_ВМ>/mlflow_errors/stderr.log
   User=<имя_пользователя_ВМ>
   ExecStart=/bin/bash -c 'PATH=/home/<имя_пользователя_ВМ>/anaconda3/envs/mlflow_env/bin/:$PATH exec mlflow server --backend-store-uri postgresql://<имя_пользователя_БД>:<пароль>@<хост>:6432/db1?sslmode=verify-full --default-artifact-root s3://mlflow-bucket/artifacts -h 0.0.0.0 -p 8000'

   [Install]
   WantedBy=multi-user.target
   ```
   Где:

   * `<имя_пользователя_ВМ>` — имя учетной записи пользователя ВМ;
   * `<имя_пользователя_БД>` — имя пользователя, указанное при создании кластера БД.

1. Запустите сервис и активируйте автозагрузку при старте системы:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable mlflow-tracking
   sudo systemctl start mlflow-tracking
   sudo systemctl status mlflow-tracking
   ```

## Создайте секреты {#create-secrets}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.name }}** задайте имя секрета — `MLFLOW_S3_ENDPOINT_URL`.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.content }}** вставьте адрес — `https://{{ s3-storage-host }}/`.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Создайте еще три секрета:
   * `MLFLOW_TRACKING_URI` со значением `http://<внутренний_IP-адрес_виртуальной_машины>:8000`;
   * `AWS_ACCESS_KEY_ID` с идентификатором статического ключа;
   * `AWS_SECRET_ACCESS_KEY` со значением статического ключа.

## Обучите модель {#train-model}

В примере используется набор данных для прогнозирования качества вина на основе количественных характеристик, таких как кислотность, водородный показатель, остаточный сахар и так далее. Чтобы обучить модель, скопируйте код в ячейки ноутбука.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Установите необходимые модули:

    ```python
    %pip install mlflow
    ```

1. Импортируйте необходимые библиотеки:

    ```python
    import os
    import warnings
    import sys

    import pandas as pd
    import numpy as np
    from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
    from sklearn.model_selection import train_test_split
    from sklearn.linear_model import ElasticNet
    from urllib.parse import urlparse
    import mlflow
    import mlflow.sklearn
    from mlflow.models import infer_signature
    import logging
    ```

1. Cоздайте эксперимент в MLFlow:

    ```python
    mlflow.set_experiment("my_first_experiment")
    ```

1. Создайте функцию оценки качества прогноза:

    ```python
    def eval_metrics(actual, pred):
      rmse = np.sqrt(mean_squared_error(actual, pred))
      mae = mean_absolute_error(actual, pred)
      r2 = r2_score(actual, pred)
      return rmse, mae, r2
    ```

1. Подготовьте данные, обучите модель и зарегистрируйте ее в MLflow:

    ```python
    logging.basicConfig(level=logging.WARN)
    logger = logging.getLogger(__name__)

    warnings.filterwarnings("ignore")
    np.random.seed(40)

    # Загружаем датасет для оценки качества вина
    csv_url = (
       "https://raw.githubusercontent.com/mlflow/mlflow/master/tests/datasets/winequality-red.csv"
    )
    try:
        data = pd.read_csv(csv_url, sep=";")
    except Exception as e:
        logger.exception(
            "Unable to download training & test CSV, check your internet connection. Error: %s", e
       )

    # Разделяем датасет на обучающую и тестовую выборку
    train, test = train_test_split(data)

    # Выделяем целевую переменную и переменные, используемые для прогноза
    train_x = train.drop(["quality"], axis=1)
    test_x = test.drop(["quality"], axis=1)
    train_y = train[["quality"]]
    test_y = test[["quality"]]

    alpha = 0.5
    l1_ratio = 0.5

    # Создаем запуск в mlflow
    with mlflow.start_run():
      
       # Создаем и обучаем модель ElasticNet
       lr = ElasticNet(alpha=alpha, l1_ratio=l1_ratio, random_state=42)
       lr.fit(train_x, train_y)
      
       # Делаем прогнозы качества на тестовой выборке
       predicted_qualities = lr.predict(test_x)

       (rmse, mae, r2) = eval_metrics(test_y, predicted_qualities)

       print("Elasticnet model (alpha={:f}, l1_ratio={:f}):".format(alpha, l1_ratio))
       print("  RMSE: %s" % rmse)
       print("  MAE: %s" % mae)
       print("  R2: %s" % r2)

       # Логируем информацию о гиперпараметрах и метриках качества в MLflow
       mlflow.log_param("alpha", alpha)
       mlflow.log_param("l1_ratio", l1_ratio)
       mlflow.log_metric("rmse", rmse)
       mlflow.log_metric("r2", r2)
       mlflow.log_metric("mae", mae)

       predictions = lr.predict(train_x)
       signature = infer_signature(train_x, predictions)

       tracking_url_type_store = urlparse(mlflow.get_tracking_uri()).scheme

       # Регистрируем модель в MLflow
       if tracking_url_type_store != "file":
         mlflow.sklearn.log_model(
               lr, "model", registered_model_name="ElasticnetWineModel", signature=signature
         )
       else:
          mlflow.sklearn.log_model(lr, "model", signature=signature)
    ```

    Проверить результат можно по ссылке `http://<публичный_IP-адрес_виртуальной_машины>:8000`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md);
* [удалите кластер](../../managed-postgresql/operations/cluster-delete.md) базы данных;
* [удалите объекты](../../storage/operations/objects/delete-all.md) из бакета;
* [удалите бакет](../../storage/operations/buckets/delete.md);
* [удалите проект](../../datasphere/operations/projects/delete.md).
