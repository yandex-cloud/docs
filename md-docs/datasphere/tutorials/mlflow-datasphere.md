# Создание сервера MLFlow для логирования экспериментов и артефактов

В практическом руководстве показано, как развернуть [MLFlow Tracking Server](https://mlflow.org/docs/latest/tracking.html) для логирования экспериментов и артефактов на отдельной виртуальной машине [Yandex Compute Cloud](../../compute/index.md). Эксперименты будут проводиться в JupyterLab Notebook. Для хранения внутренних объектов будет использоваться база данных [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md), а для хранения артефактов — бакет [Yandex Object Storage](../../storage/index.md).

Чтобы создать сервер MLFlow для логирования экспериментов и артефактов JupyterLab Notebook:

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

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../operations/community/create.md).
1. [Привяжите платежный аккаунт](../operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Бакет Object Storage: использование хранилища и выполнение операций с данными (см. [тарифы Object Storage](../../storage/pricing.md)).
* Проект DataSphere: использование вычислительных ресурсов и хранилища (см. [тарифы DataSphere](../pricing.md)).


## Подготовьте инфраструктуру {#infra}

Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud и выберите организацию, в которой вы работаете с DataSphere. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен платежный аккаунт.

Если у вас есть активный платежный аккаунт, на [странице облака](https://console.yandex.cloud/cloud) вы можете создать или выбрать каталог, в котором будет работать ваша инфраструктура.

{% note info %}

Если вы работаете с Yandex Cloud через [федерацию удостоверений](../../organization/concepts/add-federation.md), вам может быть недоступна платежная информация. В этом случае обратитесь к администратору вашей организации в Yandex Cloud.

{% endnote %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg) **Создать каталог**.
   1. Введите имя каталога, например, `data-folder`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте сервисный аккаунт для Object Storage {#create-sa}

Для доступа к бакету в Object Storage вам понадобится [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролями `storage.viewer` и `storage.uploader`.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `data-folder`.
   1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
   1. Нажмите кнопку **Создать сервисный аккаунт**.
   1. Введите имя сервисного аккаунта, например, `datasphere-sa`.
   1. Нажмите **Добавить роль** и назначьте сервисному аккаунту роли `storage.viewer` и `storage.uploader`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте статический ключ доступа {#create-static-key}

Чтобы получить доступ к Object Storage из DataSphere, вам понадобится статический ключ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В открывшемся списке выберите сервисный аккаунт `datasphere-sa`.
  1. На верхней панели нажмите кнопку ![](../../_assets/console-icons/plus.svg) **Создать новый ключ**.
  1. Выберите **Создать статический ключ доступа**.
  1. Задайте описание ключа и нажмите кнопку **Создать**.
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

  Чтобы создать ключ доступа, воспользуйтесь методом [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md).

{% endlist %}

## Создайте пару ключей SSH {#create-ssh-keys}

Чтобы подключаться к [виртуальной машине](../../compute/concepts/vm.md) по [SSH](../../glossary/ssh-keygen.md), нужна пара ключей: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя. Такой способ более безопасен, чем подключение по логину и паролю.

{% note info %}

В публичных образах Linux, предоставляемых Yandex Cloud, возможность подключения по протоколу SSH с использованием логина и пароля по умолчанию отключена.

{% endnote %}

Чтобы создать пару ключей:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  1. Откройте терминал.
  1. Создайте новый ключ с помощью команды `ssh-keygen`:
  
      ```bash
      ssh-keygen -t ed25519 -C "<опциональный_комментарий>"
      ```
  
      Вы можете передать в параметре `-C` пустую строку, чтобы не добавлять комментарий, или не указывать параметр `-C` вообще — в таком случае будет добавлен комментарий по умолчанию.
  
      После выполнения команды вам будет предложено указать имя и путь к файлам с ключами, а также ввести пароль для закрытого ключа. Если задать только имя, пара ключей будет создана в текущей директории. Открытый ключ будет сохранен в файле с расширением `.pub`, закрытый ключ — в файле без расширения.
  
      По умолчанию команда предлагает сохранить ключ под именем `id_ed25519` в директории `/home/<имя_пользователя>/.ssh`. Если в этой директории уже есть SSH-ключ с именем `id_ed25519`, вы можете случайно перезаписать его и потерять доступ к ресурсам, в которых он используется. Поэтому рекомендуется использовать уникальные имена для всех SSH-ключей.

- Windows 10/11 {#windows}

  Если у вас еще не установлен [OpenSSH](https://ru.wikipedia.org/wiki/OpenSSH), установите его по [инструкции](https://learn.microsoft.com/ru-ru/windows-server/administration/openssh/openssh_install_firstuse).
  
  1. Запустите `cmd.exe` или `powershell.exe` (предварительно обновите PowerShell).
  1. Создайте новый ключ с помощью команды `ssh-keygen`:
  
      ```shell
      ssh-keygen -t ed25519 -C "<опциональный_комментарий>"
      ```
  
      Вы можете передать в параметре `-C` пустую строку, чтобы не добавлять комментарий, или не указывать параметр `-C` вообще — в таком случае будет добавлен комментарий по умолчанию.
  
      После выполнения команды вам будет предложено указать имя и путь к файлам с ключами, а также ввести пароль для закрытого ключа. Если задать только имя, пара ключей будет создана в текущей директории. Открытый ключ будет сохранен в файле с расширением `.pub`, закрытый ключ — в файле без расширения.
  
      По умолчанию команда предлагает сохранить ключ под именем `id_ed25519` в папку `C:\Users\<имя_пользователя>/.ssh`. Если в этой директории уже есть SSH-ключ с именем `id_ed25519`, вы можете случайно перезаписать его и потерять доступ к ресурсам, в которых он используется. Поэтому рекомендуется использовать уникальные имена для всех SSH-ключей.

- Windows 7/8 {#windows7-8}

  Создайте ключи с помощью приложения PuTTY:
  
  1. [Скачайте](https://www.putty.org) и установите PuTTY.
  1. Добавьте папку с PuTTY в переменную `PATH`:
  
      1. Нажмите кнопку **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
      1. Справа снизу нажмите кнопку **Переменные среды...**.
      1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
      1. Добавьте путь к папке в список.
      1. Нажмите кнопку **ОК**.
  
  1. Запустите приложение PuTTYgen.
  1. В качестве типа генерируемой пары выберите **EdDSA**. Нажмите **Generate** и поводите курсором в поле выше до тех пор, пока не закончится создание ключа.
  
      ![ssh_generate_key](../../_assets/compute/ssh-putty/ssh_generate_key.png)
  
  1. В поле **Key passphrase** введите надежный пароль. Повторно введите его в поле ниже.
  1. Нажмите кнопку **Save private key** и сохраните закрытый ключ. Никому не сообщайте ключевую фразу от него.
  1. Нажмите кнопку **Save public key** и сохраните открытый ключ в файле `<имя_ключа>.pub`.

{% endlist %}

## Создайте виртуальную машину {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
  1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `Ubuntu 22.04` и выберите публичный образ [Ubuntu 22.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`.
  1. В блоке **Диски и файловые хранилища** выберите [тип диска](../../compute/concepts/disk.md#disks_types) `SSD` и задайте размер `20 ГБ`.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `2`.
      * **Гарантированная доля vCPU** — `100%`.
      * **RAM** — `4 ГБ`.

  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите подсеть, которая указана в [настройках проекта](../operations/projects/update.md) DataSphere. У подсети должен быть [настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md).
      * В поле **Публичный IP-адрес** оставьте значение `Автоматически`, чтобы назначить ВМ случайный внешний IP-адрес из пула Yandex Cloud, или выберите статический адрес из списка, если вы зарезервировали его заранее.

  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

      * В поле **Логин** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ: `mlflow-vm`.
  1. В блоке **Дополнительно** выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `datasphere-sa`.
  1. Нажмите кнопку **Создать ВМ**.

{% endlist %}

## Создайте управляемую БД {#create-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер БД.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера, например `mlflow-bd`.
  1. В блоке **Класс хоста** выберите конфигурацию `s3-c2-m8`.
  1. В блоке **Размер хранилища** выберите `250 ГБ`.
  1. В блоке **База данных** введите имя пользователя и пароль. Они понадобятся для подключения.
  1. В блоке **Хосты** выберите зону доступности `ru-central1-a`.
  1. Нажмите кнопку **Создать кластер**.
  1. Зайдите в созданную БД и нажмите **Подключиться**.
  1. Сохраните ссылку на хост из поля `host` — она понадобится для подключения.

{% endlist %}

## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Справа сверху нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите имя бакета, например `mlflow-bucket`.
  1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите **С авторизацией**.
  1. Нажмите кнопку **Создать бакет**.
  1. Чтобы создать папку для артефактов MLflow, зайдите в созданный бакет и нажмите **Создать папку**.
  1. Введите имя папки, например `artifacts`.

{% endlist %}

## Установите MLFlow Tracking Server и добавьте его в автозагрузку ВМ {#setup-mlflow}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине через SSH.
1. Скачайте дистрибутив `Anaconda`:

   ```bash
   curl --remote-name https://repo.anaconda.com/archive/Anaconda3-2023.07-1-Linux-x86_64.sh
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
     MLFLOW_S3_ENDPOINT_URL=https://storage.yandexcloud.net/
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
   Environment=MLFLOW_S3_ENDPOINT_URL=https://storage.yandexcloud.net/
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

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В блоке **Ресурсы проекта** нажмите ![secret](../../_assets/console-icons/shield-check.svg)**Секрет**.
1. Нажмите **Создать**.
1. В поле **Имя** задайте имя секрета — `MLFLOW_S3_ENDPOINT_URL`.
1. В поле **Значение** вставьте адрес — `https://storage.yandexcloud.net/`.
1. Нажмите **Создать**.
1. Создайте еще три секрета:
   * `MLFLOW_TRACKING_URI` со значением `http://<внутренний_IP-адрес_виртуальной_машины>:8000`;
   * `AWS_ACCESS_KEY_ID` с идентификатором статического ключа;
   * `AWS_SECRET_ACCESS_KEY` со значением статического ключа.

## Обучите модель {#train-model}

В примере используется набор данных для прогнозирования качества вина на основе количественных характеристик, таких как кислотность, водородный показатель, остаточный сахар и так далее. Чтобы обучить модель, скопируйте код в ячейки ноутбука.

1. Откройте проект DataSphere:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
   1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.

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

1. Создайте эксперимент в MLFlow:

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
* [удалите проект](../operations/projects/delete.md).