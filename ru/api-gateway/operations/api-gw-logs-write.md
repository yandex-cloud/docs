---
title: Запись логов в журнал выполнения в {{ api-gw-full-name }}
description: Следуя данной инструкции, вы сможете настроить логирование API-шлюза.
---

# Записать логи в журнал выполнения в {{ api-gw-name }}

{% include [logging-note](../../_includes/functions/logging-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится API-шлюз.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз, для которого хотите настроить логирование.
    1. В верхней части страницы нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.serverless-functions.gateways.overview.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.logging.label_title }}** в поле **{{ ui-key.yacloud.logging.label_destination }}** выберите:
        * `{{ ui-key.yacloud.serverless-functions.item.editor.option_queues-unset }}` — чтобы выключить логирование.
        * `{{ ui-key.yacloud.common.folder }}` — чтобы записывать логи в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для каталога, в котором находится API-шлюз.
            1. (Опционально) В поле **{{ ui-key.yacloud.logging.label_minlevel }}** выберите минимальный уровень логирования.
        * `{{ ui-key.yacloud.logging.label_loggroup }}` — чтобы записывать логи в пользовательскую лог-группу.
            1. (Опционально) В поле **{{ ui-key.yacloud.logging.label_minlevel }}** выберите минимальный уровень логирования.
            1. В поле **{{ ui-key.yacloud.logging.label_loggroup }}** выберите лог-группу, в которую будут записываться логи. Если у вас нет лог-группы, [создайте ее](../../logging/operations/create-group.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**. 
    
    {% include [min-log-level](../../_includes/api-gateway/min-log-level.md) %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    ## Назначение логирования {#destination}

    {% include [logging-destination](../../_includes/api-gateway/logging-destination.md) %}

    Чтобы записывать логи в пользовательскую лог-группу, укажите идентификатор лог-группы в параметре `--log-group-id` при [создании](api-gw-create.md) или [изменении](api-gw-update.md) API-шлюза. Лог-группа должна находиться в том же каталоге, в котором находится API-шлюз.

    ## Минимальный уровень логирования {#log-level}

    Чтобы задать минимальный уровень логирования, укажите его в параметре `--min-log-level` при создании или изменении API-шлюза. 

    {% include [min-log-level](../../_includes/api-gateway/min-log-level.md) %}

    ## Отключение логирования {#disabled}

    Чтобы отключить логирование, при создании или изменении API-шлюза укажите параметр `--no-logging`.

    ## Пример команды {#example}

    Чтобы записывать логи в пользовательскую лог-группу, выполните команду:

    ```bash
    {{ yc-serverless }} api-gateway update <имя_или_идентификатор_API-шлюза> \
      --log-group-id <идентификатор_лог-группы> \
      --min-log-level <минимальный_уровень_логирования>
    ```

    Где:
    * `--log-group-id` — идентификатор лог-группы, в которую будут записываться логи.
    * `--min-log-level` — минимальный уровень логирования. Доступные уровни логирования: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Необязательный параметр.

    Результат:

    ```text
    id: d5dr8k465604********
    folder_id: b1g3f9i71bpm********
    created_at: "2024-01-26T09:18:55.985Z"
    name: example_gateway
    status: ACTIVE
    domain: d5dr8k465604********.apigw.yandexcloud.net
    log_group_id: ckgsh1kdbvj1********
    connectivity: {}
    log_options:
      log_group_id: e23u2vn449av********
      min_level: ERROR
    ```

- {{ TF }} {#tf}
    
    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
    
    {% include [terraform-install](../../_includes/terraform-install.md) %}

    ## Назначение логирования {#destination}

    {% include [logging-destination](../../_includes/api-gateway/logging-destination.md) %}

    Чтобы записывать логи в пользовательскую лог-группу, в блоке `log_options` укажите идентификатор лог-группы в параметре `log_group_id` при [создании](api-gw-create.md) или [изменении](api-gw-update.md) API-шлюза. Лог-группа должна находиться в том же каталоге, в котором находится API-шлюз.

    ## Минимальный уровень логирования {#log-level}

    Чтобы задать минимальный уровень логирования, укажите его в параметре `log_group_id` блока `log_options` при создании или изменении API-шлюза. 

    {% include [min-log-level](../../_includes/api-gateway/min-log-level.md) %}

    ## Отключение логирования {#disabled}

    Чтобы отключить логирование, при создании или изменении API-шлюза в блоке `log_options` укажите параметр `disabled` со значением `true`.

    ## Пример {#example}

    Чтобы записывать логи в пользовательскую лог-группу:

    1. Откройте файл конфигурации {{ TF }} и добавьте к описанию ресурса `yandex_api_gateway` блок `log_options`:

        Пример структуры конфигурационного файла:
        
        ```hcl
        resource "yandex_api_gateway" "<имя_API-шлюза>" {
          ...
          log_options {
            folder_id = "<идентификатор_каталога>"
            min_level = "<минимальный_уровень_логирования>"
          }
          ...
        }
        ```

        Где:
        * `folder_id` — идентификатор каталога.
        * `min_level` — минимальный уровень логирования. Доступные уровни логирования: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Необязательный параметр.

        Более подробную информацию о параметрах ресурса `yandex_api_gateway` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/api_gateway).
    
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

- API {#api}

    Чтобы записывать логи в журнал выполнения в {{ api-gw-full-name }} воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

{% endlist %}
