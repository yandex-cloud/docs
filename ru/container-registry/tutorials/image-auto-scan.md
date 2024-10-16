---
title: Как автоматически просканировать Docker-образ при загрузке
description: Следуя данному руководству, вы сможете автоматически просканировать Docker-образ при загрузке.
---

# Автоматическое сканирование Docker-образа при загрузке


{% note info %}

Автоматическое [сканирование](../concepts/vulnerability-scanner.md) [Docker-образов](../concepts/docker-image.md) на наличие уязвимостей при загрузке в {{ container-registry-name }} можно включить в [настройках сканера уязвимостей](../operations/scanning-docker-image.md#automatically) без создания [функций](../../functions/concepts/function.md) и [триггеров](../../functions/concepts/trigger/index.md) [{{ sf-full-name }}](../../functions/).

{% endnote %}

В этом руководстве вы создадите [реестр](../concepts/registry.md) {{ container-registry-name }} для хранения Docker-образа и настроите автоматическое сканирование на уязвимости, при загрузке образа в реестр. С помощью триггера {{ sf-name}} будут отслеживаться изменения в реестре и при загрузке Docker-образа в реестр, будет вызываться функция для запуска сканирования.

Чтобы настроить автоматическое сканирование Docker-образа при загрузке:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение](#prepare).
1. [Создайте функцию](#create-function).
1. [Создайте триггер](#create-trigger).
1. [Загрузите Docker-образ](#download-image).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также инфраструктуру для автоматического сканирования Docker-образа при загрузке можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Подготовьте окружение {#prepare}

{% include [cli-install](../../_includes/cli-install.md) %}

1. [Установите и настройте](../operations/configure-docker.md) Docker.
1. Создайте реестр для загрузки Docker-образа.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан реестр.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.button_create }}**.
     1. Задайте имя реестра.
     1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

   - CLI {#cli}

     Выполните команду:

     ```bash
     yc container registry create --name my-reg
     ```

     Результат:

     ```text
     done
     id: crpd50616s9a********
     folder_id: b1g88tflru0e********
     name: my-reg
     status: ACTIVE
     created_at: "2019-01-09T14:34:06.601Z"
     ```

   - {{ TF }} {#tf}

     См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

   - API {#api}

     Воспользуйтесь методом [create](../api-ref/Registry/create.md) для ресурса [Registry](../api-ref/Registry/).

   {% endlist %}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с именем `scanner` и назначьте ему [роль](../../iam/concepts/access-control/roles.md) `container-registry.images.scanner` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали реестр.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сервисный аккаунт.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Введите имя сервисного аккаунта.
     1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `container-registry.images.scanner`.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

     1. Создайте сервисный аккаунт:

        ```bash
        yc iam service-account create --name service-acc
        ```

        Результат:

        ```text
        id: ajelabcde12f********
        folder_id: b0g12ga82bcv********
        created_at: "2021-05-17T14:32:18.900092Z"
        name: service-acc
        ```

     1. Назначьте роль сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding <идентификатор_каталога> \
          --role container-registry.images.scanner \
          --subject serviceAccount:<идентификатор_сервисного_аккаунта>
        ```

   - {{ TF }} {#tf}

     См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

   - API {#api}

     Воспользуйтесь методами [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/) и [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/).

   {% endlist %}

1. Аналогичным способом создайте сервисный аккаунт с именем `invoker` и назначьте ему роль `{{ roles-functions-invoker }}` на каталог, в котором создали реестр.
1. Установите Docker.

## Создайте функцию {#create-function}

Создайте функцию в сервисе {{ sf-name }} с именем `scan-on-push`, которая будет запускать сканирование Docker-образа:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Введите имя `scan-on-push` и описание функции.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** и создайте версию функции:
     1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**:
        * Выберите среду исполнения `Bash` и нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        * Выберите способ редактирования функции `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
        * В окне для редактирования функции нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**. В открывшемся окне введите имя файла `handler.sh` и нажмите **{{ ui-key.yacloud.common.create }}**.
        * Скопируйте в файл `handler.sh` следующий код:

          ```bash
          DATA=$(cat | jq -sr '.[0].messages[0].details')
          ID=$(echo $DATA | jq -r '.image_id')
          NAME=$(echo $DATA | jq -r '.repository_name')
          TAG=$(echo $DATA | jq -r '.tag')
          yc container image scan --id ${ID} --async 1>&2
          ```

        * Укажите точку входа — `handler.sh`.
     1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** – `60`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** – `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** – `scanner`.
     1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  1. Создайте функцию с именем `scan-on-push`:

     ```bash
     yc serverless function create --name=scan-on-push
     ```

     Результат:

     ```text
     id: d4ejb1799eko********
     folder_id: aoek49ghmknn********
     created_at: "2021-17-05T14:07:32.134Z"
     name: scan-on-push
     log_group_id: eolm8aoq9vcp********
     http_invoke_url: https://{{ sf-url }}/d4ejb1799eko********
     status: ACTIVE
     ```

  1. Создайте файл `handler.sh` и скопируйте в него следующий код:

     {% include [handler-sh-function](../../_tutorials/_tutorials_includes/handler-sh-function.md) %}

  1. Создайте версию функции `scan-on-push`:

     ```bash
     yc serverless function version create \
       --function-name=scan-on-push \
       --runtime bash \
       --entrypoint handler.sh \
       --memory 128m \
       --execution-timeout 60s \
       --source-path handler.sh \
       --service-account-id <идентификатор_сервисного_аккаунта>
     ```

     Где:
     * `--function-name` — имя функции, версию которой вы хотите создать.
     * `--runtime` — среда выполнения.
     * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
     * `--memory` — объем RAM.
     * `--execution-timeout` — максимальное время выполнения функции до таймаута.
     * `--source-path` — файл с кодом функции.
     * `--service-account-id` — идентификатор сервисного аккаунта.

     Результат:

     ```text
     done (1s)
     id: d4egi3pmsd1q********
     function_id: d4e275oj7jtp********
     ...
     tags:
     - $latest
     log_group_id: ckg6nb0c7uf1********
     ```

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API {#api}

  Воспользуйтесь методами [create](../../functions/functions/api-ref/Function/create) и [createVersion](../../functions/functions/api-ref/Function/createVersion) для ресурса [Function](../../functions/functions/api-ref/Function/).

{% endlist %}

## Создайте триггер {#create-trigger}

Создайте триггер, который будет вызывать вашу функцию при создании тега](../concepts/docker-image.md#version) Docker-образа.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * Введите имя и описание триггера.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container-registry }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container-registry }}**:
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_container-registry }}** выберите реестр, в который будете загружать Docker-образ.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** выберите [событие](../../functions/concepts/trigger/cr-trigger.md#event) `{{ ui-key.yacloud.serverless-functions.triggers.form.value_event-type-create-image-tag }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:
     * Выберите функцию `scan-on-push`.
     * Укажите [тег версии функции](../../functions/concepts/function.md#tag) `$latest`.
     * Укажите сервисный аккаунт `invoker`, от имени которого будет вызываться функция.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  Чтобы создать триггер, выполните команду:

  ```bash
  yc serverless trigger create container-registry \
    --name <имя_триггера> \
    --registry-id <идентификатор_реестра> \
    --events 'create-image-tag' \
    --invoke-function-id <идентификатор_функции> \
    --invoke-function-service-account-id <идентификатор_сервисного_аккаунта>
  ```

  Где:
  * `--name` — имя триггера.
  * `--registry-id` — [идентификатор реестра](../operations/registry/registry-list.md), в который будете загружать Docker-образ.
  * `--events` — [события](../../functions/concepts/trigger/cr-trigger.md#event), после наступления которых триггер запускается.
  * `--invoke-function-id` — идентификатор функции.
  * `--invoke-function-service-account-id` — идентификатор сервисного аккаунта с правами на вызов функции.

  Результат:

  ```text
  id: a1spt834cjmk********
  folder_id: b1g86q4m5vej********
  created_at: "2021-05-18T20:42:54.898949653Z"
  ...
        function_tag: $latest
        service_account_id: aje1insoe23e********
  status: ACTIVE
  ```

- API {#api}

  Воспользуйтесь методом [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/).

{% endlist %}

## Загрузите Docker-образ {#download-image}

1. Запустите Docker Desktop.
1. Аутентифицируйтесь в реестре от своего имени:

   {% list tabs group=registry_auth %}

   - С помощью Docker Credential helper {#docker}

     1. Сконфигурируйте Docker для использования `docker-credential-yc`:

        ```bash
        yc container registry configure-docker
        ```

        Результат:

        ```text
        Credential helper is configured in '/home/<user>/.docker/config.json'
        ```

        Настройки сохраняются в профиле текущего пользователя.

        {% note warning %}

        Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo` читайте в [официальной документации Docker](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

        {% endnote %}

     1. Проверьте, что Docker сконфигурирован.

        В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

        ```json
        "{{ registry }}": "yc"
        ```

     1. Docker готов к использованию, например, для [загрузки Docker-образов](../operations/docker-image/docker-image-push.md). При этом выполнять команду `docker login` не надо.

   - С помощью OAuth-токена {#oauth-token}

     1. Если у вас еще нет [OAuth-токена](../../iam/concepts/authorization/oauth-token.md), получите его по [ссылке]({{ link-cloud-oauth }}).
     1. Выполните команду:

        ```bash
        echo <OAuth-токен> | docker login --username oauth --password-stdin {{ registry }}
        ```

        Результат:

        ```text
        Login Succeeded
        ```

   - С помощью {{ iam-full-name }}-токена {#iam-token}

     {% note info %}

     {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

     {% endnote %}

     1. [Получите](../../iam/operations/iam-token/create.md) [{{ iam-name }}-токен](../../iam/concepts/authorization/iam-token.md).
     1. Выполните команду:

        ```bash
        yc iam create-token | docker login --username iam --password-stdin {{ registry }}
        ```

        Результат:

        ```text
        Login Succeeded
        ```

   {% endlist %}

1. Скачайте Docker-образ с [Docker Hub](https://hub.docker.com/):

   ```bash
   docker pull ubuntu:20.04
   ```

   Результат:

   ```text
   20.04: Pulling from library/ubuntu
   Digest: sha256:cf31af331f38d1d7158470e095b132acd126a7180a54f263d386da88********
   Status: Image is up to date for ubuntu:20.04
   docker.io/library/ubuntu:20.04
   ```

1. Присвойте тег Docker-образу:

   ```bash
   docker tag ubuntu:20.04 {{ registry }}/<идентификатор_реестра>/ubuntu:20.04
   ```

1. Загрузите Docker-образ в {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/<идентификатор_реестра>/ubuntu:20.04
   ```

   Результат:

   ```text
   The push refers to repository [{{ registry }}/crpu20rpdc2f********/ubuntu]
   2f140462f3bc: Layer already exists
   63c99163f472: Layer already exists
   ccdbb80308cc: Layer already exists
   20.04: digest: sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673f******** size: 943
   ```

## Проверьте результат {#check-result}

1. Просмотрите логи функции `scan-on-push` и убедитесь, что она выполнилась.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
     1. Перейдите в раздел **{{ ui-key.yacloud.serverless-functions.switch_list }}** и выберите функцию `scan-on-push`.
     1. В открывшемся окне перейдите в раздел **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** и укажите период. По умолчанию задан период за 1 час.

   - CLI {#cli}

     {% include [function-list-note](../../_includes/functions/function-list-note.md) %}

     Посмотрите журнал выполнения функции:

     ```bash
     yc serverless function logs scan-on-push
     ```

     Результат:

     ```text
     2021-05-18 09:27:43  START RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Version: b09i2s85a0c1********
     2021-05-18 09:27:43  END RequestID: 34dc9533-ed6e-4468-b9f2-2aa0********
     2021-05-18 09:27:43  REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
     2021-05-18 09:29:25  START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Version: b09i2s85a0c1********
     2021-05-18 09:29:26  END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f********
     2021-05-18 09:29:26  REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
     ...
     ```

   {% endlist %}

1. Проверьте, что при загрузке Docker-образа запустилось новое сканирование.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр, содержащий Docker-образ.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
     1. Выберите реестр, в который загрузили Docker-образ.
     1. Откройте репозиторий, в котором находится Docker-образ.
     1. Выберите нужный Docker-образ и проверьте значение параметра **{{ ui-key.yacloud.cr.image.label_last-scan-time }}**.

   - CLI {#cli}

     Чтобы посмотреть запуски сканирования по Docker-образу, выполните команду:

     ```bash
     yc container image list-scan-results --repository-name=<идентификатор_реестра>/<имя_Docker-образа>
     ```

     Результат:

     ```text
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     | crpu20rpdc2f******** | crpqmsqp5mtb******** | 2021-05-18 14:34:02 | READY  | medium:6, low:13, negligible:3 |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     ```

   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите Docker-образ](../../container-registry/operations/docker-image/docker-image-delete.md), который хранится в [{{ cos-full-name }}](../../cos/) и [реестр](../../container-registry/operations/registry/registry-delete.md).
* [Удалите](../../functions/operations/function/function-delete.md) функцию {{ sf-name }}.
* [Удалите](../../functions/operations/function/function-delete.md) триггер {{ sf-name }}.

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

Чтобы настроить автоматическое сканирование Docker-образа при загрузке с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
1. Укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файлов.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/image-auto-scan-tf.zip) (2 КБ).
     1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `image-auto-scan.tf`, файл с пользовательскими данными `image-auto-scan.auto.tfvars` и zip-архив с кодом функции `function.zip`.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке конфигурационный файл `image-auto-scan.tf`:

        {% cut "image-auto-scan.tf" %}

        {% include [image-auto-scan-tf-config](../../_includes/web/image-auto-scan-tf-config.md) %}

        {% endcut %}

     1. Создайте файл с пользовательскими данными `image-auto-scan.auto.tfvars`:

        {% cut "image-auto-scan.auto.tfvars" %}

        {% include [image-auto-scan-tf-variables](../../_includes/web/image-auto-scan-tf-variables.md) %}

        {% endcut %}

     1. Подготовьте zip-архив с кодом функции.
        1. Создайте файл `handler.sh` и скопируйте в него следующий код:

           {% cut "handler.sh" %}

           {% include [warning-unix-lines](../../_tutorials/_tutorials_includes/warning-unix-lines.md) %}

           {% include [handler-sh-function](../../_tutorials/_tutorials_includes/handler-sh-function.md) %}

           {% endcut %}

        1. Создайте zip-архив `function.zip` с файлом `handler.sh`.

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [yandex_iam_service_account]({{ tf-provider-resources-link }}/yandex_iam_service_account)
   * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/yandex_resourcemanager_folder_iam_member)
   * [yandex_container_registry]({{ tf-provider-resources-link }}/yandex_container_registry)
   * [yandex_function]({{ tf-provider-resources-link }}/yandex_function)
1. В файле `image-auto-scan.auto.tfvars` задайте пользовательские параметры:
   * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой будет создана инфраструктура.
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет создана инфраструктура.
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Создайте триггер](#create-trigger).
1. [Загрузите образ](#download-image).
1. [Проверьте результат](#check-result).