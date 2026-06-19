Чтобы добавить навык Алисы на основе [функции](*functions):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте код навыка](#prepare-code).
1. [Создайте функцию и версию функции](#create-function).
1. [Добавьте ссылку на функцию в навык Алисы](#add-link).
1. [Протестируйте работу навыка](#test).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

Подробнее о [разработке навыка Алисы](https://yandex.ru/dev/dialogs/alice/doc/development-docpage/#test__dev-cycle).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Подготовьте код для навыка Алисы {#prepare-code}

Чтобы создать [версию](*function_version) функции, вы можете воспользоваться одним из [форматов загрузки кода](*upload_formats). В данном примере код будет загружен в {{ sf-full-name }} в формате ZIP-архива.

{% include [prepare-code](../../_tutorials_includes/alice-skill/prepare-code.md) %}

## Создайте функцию и версию функции {#create-function}

После создания функция будет содержать только информацию о себе: имя, описание, уникальный идентификатор и т.д. Непосредственно код навыка будет добавлен в версию функции.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](*folder), в котором будет создана функция.
  1. Нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите ![curly-brackets-function](../../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_serverless-functions }}**.
  1. Задайте [имя](*naming) функции. Например: `my-parrot-function`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте версию функции:

      {% list tabs group=programming_language %}

      - Python {#python}

        1. В списке языков программирования выберите `{{ python-full-ver }}`.
        1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        1. Подготовьте код функции:

            * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` и прикрепите созданный ранее архив `parrot-py.zip`.
            * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `parrot.handler`.
        1. Задайте параметры версии:

            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`.
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.
            * Значение остальных параметров оставьте по умолчанию.
        1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

      - Node.js {#node}

        1. В списке языков программирования выберите `{{ nodejs-full-ver }}`.
        1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        1. Подготовьте код функции:

            * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` и прикрепите созданный ранее архив `parrot-js.zip`.
            * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `index.handler`.
        1. Задайте параметры версии:

            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`.
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.
            * Значение остальных параметров оставьте по умолчанию.
        1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

      {% endlist %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Чтобы создать функцию, выполните команду:

      ```bash
      yc serverless function create \
        --name my-parrot-function
      ```

      Результат:

      ```text
      id: d4el0mi6ps6s********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-06-15T08:16:02.695Z"
      name: my-parrot-function
      http_invoke_url: https://{{ sf-url }}/d4el0mi6ps6s********
      status: ACTIVE
      ```

  1. Чтобы создать версию функции, выполните команду:

      {% list tabs group=programming_language %}

      - Python {#python}

        ```
        yc serverless function version create \
          --function-name my-parrot-function \
          --runtime {{ python-cli-ver }} \
          --entrypoint index.handler \
          --memory 128m \
          --execution-timeout 5s \
          --source-path ./parrot-py.zip
        ```

        Результат:

        ```text
        done (2s)
        id: d4easr8ok281********
        function_id: d4el0mi6ps6s********
        created_at: "2026-06-15T08:42:20.771Z"
        runtime: {{ python-cli-ver }}
        entrypoint: index.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
          - $latest
        concurrency: "1"
        log_options:
          folder_id: b1g5bhjofg7o********
        ```

      - Node.js {#node}

        ```
        yc serverless function version create \
          --function-name my-parrot-function \
          --runtime {{ nodejs-cli-ver }} \
          --entrypoint index.handler \
          --memory 128m \
          --execution-timeout 5s \
          --source-path ./parrot-js.zip
        ```

        Результат:

        ```text
        done (2s)
        id: d4etv45m1vor********
        function_id: d4el0mi6ps6s********
        created_at: "2026-06-15T08:45:25.313Z"
        runtime: {{ nodejs-cli-ver }}
        entrypoint: index.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
          - $latest
        concurrency: "1"
        log_options:
          folder_id: b1g5bhjofg7o********
        ```

      {% endlist %}

- API {#api}

  Чтобы создать функцию, воспользуйтесь методом REST API [create](../../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../../functions/functions/api-ref/grpc/Function/create.md).

  Чтобы создать версию функции, воспользуйтесь методом REST API [createVersion](../../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../../functions/functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}

{% include [add-link](../../_tutorials_includes/alice-skill/add-link.md) %}

{% include [test](../../_tutorials_includes/alice-skill/test.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы прекратить работу навыка, [удалите](../../../functions/operations/function/function-delete.md) функцию.

[*functions]: Функции {{ sf-full-name }} позволяют размещать в {{ yandex-cloud }} код, который можно запускать по запросу или триггеру. Подробнее читайте в разделе [{#T}](../../../functions/concepts/function.md).

[*folder]: Каталог — это логическое пространство, в котором создаются и группируются ресурсы {{ yandex-cloud }}. Как и каталоги в файловой системе, каталоги в {{ yandex-cloud }} упрощают управление ресурсами. Подробнее читайте в разделе [{#T}](../../../resource-manager/concepts/resources-hierarchy.md#folder).

[*naming]: Требования к имени:
* длина — от 3 до 63 символов;
* может содержать строчные буквы латинского алфавита, цифры и дефисы;
* первый символ — буква, последний — не дефис.

[*function_version]: Версия содержит код функции, параметры запуска, а также все необходимые зависимости. На разных стадиях процесса разработки вы можете работать с разными версиями одной функции. Подробнее читайте в разделе [{#T}](../../../functions/concepts/function.md#version).

[*upload_formats]: Загружать код версии функции можно несколькими способами: в редакторе в консоли управления, из локальных файлов и директорий или в виде архива. Подробнее читайте в разделе [{#T}](../../../functions/concepts/function.md#upload).