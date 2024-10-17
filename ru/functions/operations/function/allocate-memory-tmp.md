---
title: Выделить память для директории /tmp
description: Из статьи вы узнаете, как в функции выделить часть оперативной памяти для директории /tmp.
---

# Выделить память для директории /tmp

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
    1. В блоке **Дополнительные настройки**, в разделе **Память**, включите опцию **Выделять память для директории /tmp**.
    1. В поле **Выделенная память** укажите объем выделяемой памяти.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы выделить часть оперативной памяти для директории `/tmp`, выполните команду:

    ```bash
    yc serverless function version create \
      --function-name=<имя_функции> \
      --runtime <среда_выполнения> \
      --entrypoint <точка_входа> \
      --memory <объем_RAM> \
      --source-version-id <идентификатор_версии> \
      --tmpfs-size <объем_RAM_для_tmp>
    ```

    Где:

    * `--function-name` — имя функции.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
    * `--memory` — объем оперативной памяти (RAM).
    * `--source-version-id` — идентификатор версии функции, код которой вы хотите скопировать.
    * `--tmpfs-size` — объем оперативной памяти, который вы хотите выделить для директории `/tmp`.

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    Чтобы выделить часть оперативной памяти для директории `/tmp`:

    1. В конфигурационном файле добавьте аргумент `tmpfs_size` для ресурса `yandex_function` и укажите объем выделяемой памяти.

       Пример описания функции в конфигурации {{ TF }}:

        ```hcl
        resource "yandex_function" "test-function" {
            name               = "<имя_функции>"
            user_hash          = "<хеш>"
            runtime            = "<среда_выполнения>"
            entrypoint         = "<точка_входа>"
            memory             = "<объем_RAM>"
            tmpfs_size         = "<объем_RAM_для_tmp>"
            
            content {
                zip_filename = "<путь_к_ZIP-архиву>"
            }
        }
        ```

        Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

    1. Проверьте конфигурацию командой:

       ```bash
       terraform validate
       ```

       Если конфигурация является корректной, появится сообщение:

       ```text
       Success! The configuration is valid.
       ```

    1. Выполните команду:

       ```bash
       terraform plan
       ```

       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Примените изменения конфигурации:

       ```bash
       terraform apply
       ```

    1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

    Проверить выделение памяти для директории `/tmp` можно в [консоли управления]({{ link-console-main }}).

- API {#api}

    Чтобы выделить часть оперативной памяти для директории `/tmp`, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}

## См. также {#see-also}

* [Пользовательские файлы](../../concepts/runtime/environment-variables.md#files)
