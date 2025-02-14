# Развертывание сервиса на основе Docker-образа с FastAPI

В этом практическом руководстве вы развернете сервис FastAPI на основе [Docker-образа](../../datasphere/concepts/deploy/index.md#docker-node). Сервис передает метрики в текстовом формате [Prometheus](https://prometheus.io/docs/instrumenting/exposition_formats/#text-based-format). Сервис будет запускаться на IP-адресе `0.0.0.0` и порте `9875`.

Чтобы развернуть сервис на основе Docker-образа с FastAPI:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте Docker-образ для развертывания сервиса](#docker).
1. [Разверните сервис в {{ ml-platform-name }}](#deploy).
1. [Проверьте работу развернутого сервиса](#check-node).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания сервиса на основе Docker-образа входят:

* плата за постоянно запущенные инстансы ноды (см. [тарифы {{ ml-platform-name }}](../../datasphere/pricing.md));
* плата за запуск ячеек с кодом для проверки работы развернутого сервиса;
* объем хранилища, занятый данными {{ container-registry-full-name }} (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

{% note info %}

В примере инфраструктура {{ yandex-cloud }} и развернутый сервис работают в одном каталоге {{ yandex-cloud }}, однако это не обязательно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте реестр {{ container-registry-name }} {#create-registry}

{{ ml-platform-name }} может создать ноду из Docker-образа, который хранится в [{{ container-registry-full-name }}](../../container-registry/). Чтобы загрузить образ, создайте реестр:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `data-folder`.
  1. В списке сервисов выберите **{{ container-registry-name }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. Задайте имя реестра, например `datasphere-registry`, и нажмите кнопку **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

{% endlist %} 

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `sa-for-datasphere`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `container-registry.images.puller` — чтобы разрешить {{ ml-platform-name }} скачивать ваш Docker-образ для создания ноды.
      * `vpc.user` — для работы с сетью {{ ml-platform-name }}.
      * `datasphere.user` — чтобы отправлять запросы в ноду.

   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Создайте авторизованный ключ для сервисного аккаунта {#create-key}

Чтобы сервисный аккаунт мог [аутентифицироваться в {{ container-registry-full-name }}](../../container-registry/operations/authentication.md), создайте авторизованный ключ.

{% include [disclaimer](../../_includes/iam/authorized-keys-disclaimer.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите сервисный аккаунт `sa-for-datasphere`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели.
  1. Выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Выберите алгоритм шифрования.
  1. Сохраните открытый и закрытый ключи: закрытый ключ не сохраняется в {{ yandex-cloud }}, открытый ключ нельзя будет посмотреть в консоли управления.

     {% note tip %}

     Вы можете сохранить файл с ключом на свой компьютер. Его содержимое понадобится позднее при создании секрета для доступа {{ ml-platform-name }} в {{ container-registry-name }}.

     {% endnote %}

{% endlist %}

## Подготовьте Docker-образ для развертывания сервиса {#docker}

Если у вас еще нет Docker, [установите](https://docs.docker.com/install/) его.

### Создайте Docker-образ сервиса {#create-docker}

1. Создайте папку, в которой будет храниться конфигурация Docker-образа и все необходимые файлы, например `/home/docker-images`.
1. Склонируйте [репозиторий на GitHub](https://github.com/yandex-cloud-examples/yc-datasphere-fastapi-service-deploy) и поместите файлы в созданную папку.
1. Запустите [Docker Desktop](https://docs.docker.com/desktop/).
1. В командной оболочке перейдите в папку, где хранится созданный вами Dockerfile.

   ```bash
   cd docker-images
   ```

1. Соберите Docker-образ:

   ```bash
   docker build --platform linux/amd64 -t fastapi-docker .
   ```

### Загрузите Docker-образ в {{ container-registry-name }} {#push-docker}

{% include [install cli](../../_includes/cli-install.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

   1. [Задайте](../../cli/operations/profile/manage-properties.md) каталог `data-folder` каталогом по умолчанию:

      ```bash
      yc config set folder-id <идентификатор_каталога>
      ```

   1. [Аутентифицируйтесь в {{ container-registry-name }}](../../container-registry).

      1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для своего пользовательского аккаунта:

      ```bash
      yc iam create-token
      ```
      
      В ответе будет IAM-токен. Если вы аутентифицируетесь от имени федеративного аккаунта, CLI перенаправит вас в консоль управления для аутентификации, а после этого пришлет IAM-токен.

      {% note info %}

      {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. Выполните команду, подставив вместо `<IAM-токен>` значение токена, которое вы получили на предыдущем шаге:

      ```bash
      docker login \
        --username iam \
        --password <IAM-токен> \
        {{ registry }}
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

   1. Загрузите Docker-образ в {{ container-registry-name }}, подставив идентификатор вашего реестра `datasphere-registry`:

      ```bash
      docker tag fastapi-docker {{ registry }}/<идентификатор_реестра>/fastapi:v1
      docker push {{ registry }}/<идентификатор_реестра>/fastapi:v1
      ```

{% endlist %}

## Разверните сервис в {{ ml-platform-name }} {#deploy}

1. {% include [ui-find-community](../../_includes/datasphere/ui-find-community.md) %}
1. Выберите сообщество с привязанным платежным аккаунтом.
1. [Создайте проект](../../datasphere/operations/projects/create.md) `Node from Docker`.
1. [В настройках проекта](../../datasphere/operations/projects/update.md) укажите:
   *  **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}** — `data-folder`.
   *  **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}** — `sa-for-datasphere`.
1. [Создайте секрет](../../datasphere/operations/data/secrets.md) `key-for-sa`, добавив в него содержимое файла с авторизованным ключом для сервисного аккаунта `sa-for-datasphere` полностью без каких-либо изменений. 
1. Создайте ноду. Для этого на странице проекта в правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**. Укажите настройки ноды:
   1. В поле **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** введите имя ноды — `fastapi`.
   1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.docker-image }}**:
      * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}** — выберите **{{ ui-key.yc-ui-datasphere.common.docker }}**.
      * **{{ ui-key.yc-ui-datasphere.new-node.source }}** — выберите **{{ ui-key.yc-ui-datasphere.new-node.ycr }}**.
      * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.image-path }}** — задайте путь к образу {{ container-registry-name }} вида `{{ registry }}/<идентификатор_реестра>/<имя_образа>:<тег>`. Его можно получить в консоли управления, скопировав полное значение на странице репозитория. Также вы можете заполнить поле вручную. Идентификатор реестра можно получить в CLI, выполнив команду `yc container registry list`.      
      * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}** — выберите `key-for-sa`.
   1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.endpoint }}**:
      * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.type }}** — выберите протокол **HTTP**.
      * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.port }}** — 9875.
   1. Включите опцию **{{ ui-key.yc-ui-datasphere.new-node.title.telemetry }}** и укажите:
      * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}** — выберите **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.prometheus }}**.
      * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.http-path }}** — `/metrics`.
      * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.port }}** — 9875.
   1. Включите опцию **{{ ui-key.yc-ui-datasphere.new-node.title.healthcheck }}** и укажите:
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.type }}** — выберите **HTTP**.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.path }}** — `/`.
      * **{{ ui-key.yc-ui-datasphere.common.port }}** — 9875.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.timeout }}** — 1.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.interval }}** — 15.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.fails-threshold }}** — 3.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.passes-threshold }}** — 3.
   1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}** выберите каталог `data-folder`.
   1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}** выберите [конфигурацию](../../datasphere/concepts/configurations.md) `g1.1`.
   1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.

## Проверьте работу развернутого сервиса {#check-node}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В списке ресурсов выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Нажмите на созданную ноду `Node from Docker`.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}**.
1. В форме **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}** выберите метод `GET`.
1. В поле **Path** введите `/urls`.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.execute }}**, чтобы получить полный список URI для проверки работоспособности и метрик.

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

{% include [node warning](../../_includes/datasphere/nodes-pricing-warn.md) %}

1. [Удалите ноду](../../datasphere/operations/deploy/node-delete.md).
1. [Удалите секрет](../../datasphere/operations/data/secrets.md#delete).
1. [Удалите авторизованный ключ](../../iam/operations/authorized-key/delete.md) сервисного аккаунта.
1. [Удалите Docker-образ](../../container-registry/operations/docker-image/docker-image-delete.md).
1. [Удалите реестр](../../container-registry/operations/registry/registry-delete.md) {{ container-registry-name }}.