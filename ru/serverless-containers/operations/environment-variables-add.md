# Добавить переменные окружения контейнеру

При добавлении переменных окружения создается новая ревизия контейнера. В существующую ревизию переменные окружения добавить нельзя.

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер, для ревизии которого хотите добавить переменную окружения.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В открывшемся окне, в блоке **{{ ui-key.yacloud.serverless-containers.section_image }}**, укажите переменную окружения и нажмите **{{ ui-key.yacloud.common.add }}**. Можно добавить несколько переменных окружения.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**. Будет создана новая ревизия контейнера с указанными переменными окружения.
    
- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы добавить переменные окружения, выполните команду:

    {% note warning %}

    Если в прошлой ревизии уже были переменные окружения, они перезапишутся.

    {% endnote %}

    ```
    yc serverless container revision deploy \
      --container-name <имя_контейнера> \
      --image <URL_Docker-образа> \
      --cores 1 \
      --memory 1GB \
      --service-account-id <идентификатор_сервисного_аккаунта> \
      --environment <переменные_окружения>
    ```

    Где:

    * `--cores` — количество ядер, которые доступны контейнеру.
    * `--memory` — требуемая память. По умолчанию — 128 МБ.
    * `--environment` — переменные окружения в формате `key=value`. Можно указать несколько пар через запятую.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы добавить переменные окружения:

  1. Откройте файл конфигурации {{ TF }} и для ресурса `yandex_serverless_container` в блок `image` добавьте список `environment` с переменными окружения:

     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name               = "my-container"
       memory             = 256
       service_account_id = "ajec........34ova"
       image {
           url = "{{ registry }}/yc/test-image:v1"
           environment = {
               <ключ> = "<значение>"
           }
       }
     }
     ...
     ```

     Где `--environment` — переменные окружения в формате `key="value"`. Можно указать несколько пар.

	 Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить создание переменных окружения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```
  yc serverless container revision get <идентификатор_ревизии>
  ```

- API {#api}

  Чтобы добавить переменную окружения в ревизию контейнера, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/container_service.md#DeployRevision).

{% endlist %}

## См. также

* [Переменные окружения](../concepts/runtime.md#environment-variables).