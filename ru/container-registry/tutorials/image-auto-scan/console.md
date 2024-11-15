---
title: Как автоматически просканировать Docker-образ при загрузке с помощью консоли управления, CLI и API
description: Следуя данному руководству, вы сможете автоматически просканировать Docker-образ при загрузке в {{ container-registry-full-name }} с помощью консоли управления, CLI и API.
---

# Автоматическое сканирование Docker-образа при загрузке с помощью консоли управления, CLI и API


{% note info %}

Автоматическое [сканирование](../../concepts/vulnerability-scanner.md) [Docker-образов](../../concepts/docker-image.md) на наличие уязвимостей при загрузке в [{{ container-registry-full-name }}](../../../container-registry/) можно включить в [настройках сканера уязвимостей](../../operations/scanning-docker-image.md#automatically) без создания [функций](../../../functions/concepts/function.md) и [триггеров](../../../functions/concepts/trigger/index.md) [{{ sf-full-name }}](../../../functions/).

{% endnote %}

Чтобы настроить автоматическое [сканирование](../../concepts/vulnerability-scanner.md) [Docker-образов](index.md) на наличие уязвимостей при загрузке в [{{ container-registry-full-name }}](../../../container-registry/), выполните следующие шаги:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение](#prepare).
1. [Создайте функцию](#create-function).
1. [Создайте триггер](#create-trigger).
1. [Загрузите Docker-образ](#download-image).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../../_tutorials/_tutorials_includes/image-auto-scan/paid-resources.md) %}

## Подготовьте окружение {#prepare}

{% include [cli-install](../../../_includes/cli-install.md) %}

1. [Установите и настройте](../../operations/configure-docker.md) Docker.
1. Создайте реестр для загрузки Docker-образа.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан реестр.
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

   - API {#api}

     Воспользуйтесь методом [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/).

   {% endlist %}

1. Создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с именем `scanner` и назначьте ему [роль](../../../iam/concepts/access-control/roles.md) `container-registry.images.scanner` на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали реестр.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сервисный аккаунт.
     1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
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

   - API {#api}

     Воспользуйтесь методами [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/) и [updateAccessBindings](../../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/).

   {% endlist %}

1. Аналогичным способом создайте сервисный аккаунт с именем `invoker` и назначьте ему роль `{{ roles-functions-invoker }}` на каталог, в котором создали реестр.

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

     {% include [handler-sh-function](../../../_tutorials/_tutorials_includes/handler-sh-function.md) %}

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

- API {#api}

  Воспользуйтесь методами [create](../../../functions/functions/api-ref/Function/create) и [createVersion](../../../functions/functions/api-ref/Function/createVersion) для ресурса [Function](../../../functions/functions/api-ref/Function/).

{% endlist %}

## Создайте триггер {#create-trigger}

Создайте триггер, который будет вызывать вашу функцию при создании [тега](../../concepts/docker-image.md#version) Docker-образа.

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
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** выберите [событие](../../../functions/concepts/trigger/cr-trigger.md#event) `{{ ui-key.yacloud.serverless-functions.triggers.form.value_event-type-create-image-tag }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:
     * Выберите функцию `scan-on-push`.
     * Укажите [тег версии функции](../../../functions/concepts/function.md#tag) `$latest`.
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
  * `--registry-id` — [идентификатор реестра](../../operations/registry/registry-list.md), в который будете загружать Docker-образ.
  * `--events` — [события](../../../functions/concepts/trigger/cr-trigger.md#event), после наступления которых триггер запускается.
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

  Воспользуйтесь методом [create](../../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../../functions/triggers/api-ref/Trigger/).

{% endlist %}

## Загрузите Docker-образ {#download-image}

{% include [upload-image](../../../_tutorials/_tutorials_includes/image-auto-scan/upload-image.md) %}

## Проверьте результат {#check-result}

{% include [check-result](../../../_tutorials/_tutorials_includes/image-auto-scan/check-result.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите Docker-образ](../../../container-registry/operations/docker-image/docker-image-delete.md), который хранится в [{{ cos-full-name }}](../../../cos/) и [реестр](../../../container-registry/operations/registry/registry-delete.md).
1. [Удалите](../../../functions/operations/function/function-delete.md) функцию {{ sf-name }}.
1. [Удалите](../../../functions/operations/function/function-delete.md) триггер {{ sf-name }}.

#### См. также {#see-also}

* [{#T}](terraform.md)