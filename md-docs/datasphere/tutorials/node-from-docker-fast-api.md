# Развертывание сервиса на основе Docker-образа с FastAPI

В этом практическом руководстве вы развернете сервис FastAPI на основе [Docker-образа](../concepts/deploy/index.md#docker-node). Сервис передает метрики в текстовом формате [Prometheus](https://prometheus.io/docs/instrumenting/exposition_formats/#text-based-format). Сервис будет запускаться на IP-адресе `0.0.0.0` и порте `9875`.

Чтобы развернуть сервис на основе Docker-образа с FastAPI:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте Docker-образ для развертывания сервиса](#docker).
1. [Разверните сервис в DataSphere](#deploy).
1. [Проверьте работу развернутого сервиса](#check-node).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../operations/community/create.md).
1. [Привяжите платежный аккаунт](../operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.

### Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания сервиса на основе Docker-образа входят:

* плата за постоянно запущенные инстансы ноды ([тарифы DataSphere](../../datasphere/pricing.md));
* плата за запуск ячеек с кодом для проверки работы развернутого сервиса;
* объем хранилища, занятый данными Yandex Container Registry ([тарифы Container Registry](../../container-registry/pricing.md)).

## Подготовьте инфраструктуру {#infra}

Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud и выберите организацию, в которой вы работаете с DataSphere. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен платежный аккаунт.

Если у вас есть активный платежный аккаунт, на [странице облака](https://console.yandex.cloud/cloud) вы можете создать или выбрать каталог, в котором будет работать ваша инфраструктура.

{% note info %}

Если вы работаете с Yandex Cloud через [федерацию удостоверений](../../organization/concepts/add-federation.md), вам может быть недоступна платежная информация. В этом случае обратитесь к администратору вашей организации в Yandex Cloud.

{% endnote %}

### Создайте каталог {#create-folder}

{% note info %}

В примере инфраструктура Yandex Cloud и развернутый сервис работают в одном каталоге Yandex Cloud, однако это не обязательно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**Создать каталог**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте реестр Container Registry {#create-registry}

DataSphere может создать ноду из Docker-образа, который хранится в [Yandex Container Registry](../../container-registry/index.md). Чтобы загрузить образ, создайте реестр:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Container Registry**.
  1. Нажмите кнопку **Создать реестр**.
  1. Задайте имя реестра, например `datasphere-registry`, и нажмите кнопку **Создать реестр**.

{% endlist %} 

### Создайте сервисный аккаунт для проекта DataSphere {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
   1. Нажмите кнопку **Создать сервисный аккаунт**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `sa-for-datasphere`.
   1. Нажмите **Добавить роль** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `container-registry.images.puller` — чтобы разрешить DataSphere скачивать ваш Docker-образ для создания ноды.
      * `vpc.user` — для работы с сетью DataSphere.
      * `datasphere.user` — чтобы отправлять запросы в ноду.

   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте авторизованный ключ для сервисного аккаунта {#create-key}

Чтобы сервисный аккаунт мог [аутентифицироваться в Yandex Container Registry](../../container-registry/operations/authentication.md), создайте авторизованный ключ.

{% note info %}

Срок жизни авторизованных ключей не ограничен, но вы всегда можете получить новые авторизованные ключи и повторить процедуру аутентификации, если что-то пошло не так.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В открывшемся списке выберите сервисный аккаунт `sa-for-datasphere`.
  1. Нажмите кнопку **Создать новый ключ** на верхней панели.
  1. Выберите пункт **Создать авторизованный ключ**.
  1. Выберите алгоритм шифрования.
  1. Сохраните открытый и закрытый ключи: закрытый ключ не сохраняется в Yandex Cloud, открытый ключ нельзя будет посмотреть в консоли управления.

     {% note tip %}

     Вы можете сохранить файл с ключом на свой компьютер. Его содержимое понадобится позднее при создании секрета для доступа DataSphere в Container Registry.

     {% endnote %}

{% endlist %}

## Подготовьте Docker-образ для развертывания сервиса {#docker}

Если у вас еще нет Docker, [установите](https://docs.docker.com/install/) его.

### Создайте Docker-образ сервиса {#create-docker}

1. Создайте папку, в которой будет храниться конфигурация Docker-образа и все необходимые файлы, например `/home/docker-images`.
1. Склонируйте [репозиторий на GitHub](https://github.com/yandex-cloud-examples/yc-datasphere-fastapi-service-deploy) и поместите файлы в созданную папку.
1. Запустите [Docker Desktop](https://docs.docker.com/desktop/).
1. В командной оболочке перейдите в папку, где хранится склонированный репозиторий:

   ```bash
   cd docker-images
   ```

1. Соберите Docker-образ:

   ```bash
   docker build --platform linux/amd64 -t fastapi-docker .
   ```

### Загрузите Docker-образ в Container Registry {#push-docker}

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

{% list tabs group=instructions %}

- CLI {#cli}

   1. [Задайте](../../cli/operations/profile/manage-properties.md) каталог `data-folder` каталогом по умолчанию:

      ```bash
      yc config set folder-id <идентификатор_каталога>
      ```

   1. [Аутентифицируйтесь в Container Registry](../../container-registry/index.md).

      1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для своего пользовательского аккаунта:

      ```bash
      yc iam create-token
      ```
      
      В ответе будет IAM-токен. Если вы аутентифицируетесь от имени федеративного аккаунта, CLI перенаправит вас в консоль управления для аутентификации, а после этого пришлет IAM-токен.

      {% note info %}

      У IAM-токена короткое [время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) — не более  12 часов. Поэтому такой способ подойдет для приложений, которые будут запрашивать IAM-токен автоматически.

      {% endnote %}

      1. Выполните команду, подставив вместо `<IAM-токен>` значение токена, которое вы получили на предыдущем шаге:

      ```bash
      docker login \
        --username iam \
        --password <IAM-токен> \
        cr.yandex
      ```

   1. Получите список реестров каталога `data-folder`:

      ```bash
      yc container registry list
      ```

      Идентификатор реестра понадобится вам на следующем шаге. Пример вывода команды:

      ```text
      +----------------------+---------------------+----------------------+
      |          ID          |        NAME         |      FOLDER ID       |
      +----------------------+---------------------+----------------------+
      | crp86bmgl1da******** | datasphere-registry | b1g4bh24c406******** |
      +----------------------+---------------------+----------------------+
      ```

   1. Загрузите Docker-образ в Container Registry, подставив идентификатор вашего реестра `datasphere-registry`:

      ```bash
      docker tag fastapi-docker cr.yandex/<идентификатор_реестра>/fastapi:v1
      docker push cr.yandex/<идентификатор_реестра>/fastapi:v1
      ```

{% endlist %}

## Разверните сервис в DataSphere {#deploy}

1. Откройте [главную страницу](https://datasphere.yandex.cloud) DataSphere. На панели слева выберите ![community-panel](../../_assets/console-icons/circles-concentric.svg) **Сообщества**.
1. Выберите сообщество с привязанным платежным аккаунтом.
1. [Создайте проект](../operations/projects/create.md) `Node from Docker`.
1. [В настройках проекта](../operations/projects/update.md) укажите:
   *  **Каталог по умолчанию** — `data-folder`.
   *  **Сервисный аккаунт** — `sa-for-datasphere`.
1. [Создайте секрет](../operations/data/secrets.md) `key-for-sa`, добавив в него содержимое файла с авторизованным ключом для сервисного аккаунта `sa-for-datasphere` полностью без каких-либо изменений. 
1. Создайте ноду. Для этого на странице проекта в правом верхнем углу нажмите кнопку **Создать ресурс**. Во всплывающем окне выберите **Нода**. Укажите настройки ноды:
   1. В поле **Имя** введите имя ноды — `fastapi`.
   1. В блоке **Образ Docker**:
      * **Тип** — выберите **Docker-образ**.
      * **Хранилище Docker-образов** — выберите **Yandex Container Registry**.
      * **Путь к образу** — задайте путь к образу Container Registry вида `cr.yandex/<идентификатор_реестра>/<имя_образа>:<тег>`. Его можно получить в консоли управления, скопировав полное значение на странице репозитория. Также вы можете заполнить поле вручную. Идентификатор реестра можно получить в CLI, выполнив команду `yc container registry list`.      
      * **Секрет с паролем** — выберите `key-for-sa`.
   1. В блоке **Эндпоинт**:
      * **Тип** — выберите протокол **HTTP**.
      * **Порт** — 9875.
   1. Включите опцию **Телеметрия** и укажите:
      * **Тип** — выберите **Prometheus**.
      * **HTTP-адрес** — `/metrics`.
      * **Порт** — 9875.
   1. Включите опцию **Проверка** и укажите:
      * **Тип** — выберите **HTTP**.
      * **Путь** — `/`.
      * **Порт** — 9875.
      * **Таймаут** — 1.
      * **Интервал** — 15.
      * **Неудачные проверки** — 3.
      * **Пройденные проверки** — 3.
   1. В блоке **Каталог** выберите каталог `data-folder`.
   1. В блоке **Обеспечение** выберите [конфигурацию](../concepts/configurations.md) `g1.1`.
   1. Нажмите кнопку **Создать**.

## Проверьте работу развернутого сервиса {#check-node}

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В списке ресурсов выберите **Нода**.
1. Нажмите на созданную ноду `Node from Docker`.
1. Перейдите на вкладку **Запрос**.
1. В форме **Создать тестовый запрос** выберите метод `GET`.
1. В поле **Path** введите `/urls`.
1. Нажмите кнопку **Выполнить**, чтобы получить полный список URI для проверки работоспособности и метрик.

   Результат:

   ```json
   [
   {
      "path": "/openapi.json",
      "name": "openapi"
   },
   {
      "path": "/docs",
      "name": "swagger_ui_html"
   },
   {
      "path": "/docs/oauth2-redirect",
      "name": "swagger_ui_redirect"
   },
   {
      "path": "/redoc",
      "name": "redoc_html"
   },
   {
      "path": "/metrics",
      "name": "metrics"
   },
   {
      "path": "/",
      "name": "root"
   },
   {
      "path": "/urls",
      "name": "get_all_urls"
   },
   {
      "path": "/health-check",
      "name": "healthcheck"
   }
   ]
   ```

## Как удалить созданные ресурсы {#clear-out}

При развертывании и эксплуатации моделей вы платите за время работы каждого инстанса ноды — от момента запуска до момента удаления.

Если развернутый сервис вам больше не нужен, удалите ноду.

1. [Удалите ноду](../operations/deploy/node-delete.md).
1. [Удалите секрет](../operations/data/secrets.md#delete).
1. [Удалите авторизованный ключ](../../iam/operations/authentication/manage-authorized-keys.md#delete-authorized-key) сервисного аккаунта.
1. [Удалите Docker-образ](../../container-registry/operations/docker-image/docker-image-delete.md).
1. [Удалите реестр](../../container-registry/operations/registry/registry-delete.md) Container Registry.