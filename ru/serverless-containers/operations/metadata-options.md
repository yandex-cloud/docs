# Настроить параметры сервиса метаданных контейнера

Настроить параметры сервиса метаданных вы можете при [создании ревизии контейнера](manage-revision.md).

{% include [metadata-options](../../_includes/functions/metadata-options.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [контейнер](../../serverless-containers/concepts/container.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Выберите контейнер.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
  1. Разверните блок **Параметры сервиса метаданных**.
  1. Настройте параметры сервиса метаданных контейнера — `{{ ui-key.yacloud.serverless-containers.label_gce_http_endpoint }}` и `{{ ui-key.yacloud.serverless-containers.label_aws_v1_http_endpoint }}`.п
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    Чтобы настроить параметры сервиса метаданных контейнера, выполните команду:

    ```bash
    yc serverless container revision deploy \
      --container-id <идентификатор_контейнера> \
      --image <URL_Docker-образа> \
      --service-account-id <идентификатор_сервисного_аккаунта>
      --metadata-options <опция>=<enabled_или_disabled>
    ```

    Где:
    * `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.
    * `--image` — URL Docker-образа из {{ container-registry-full-name }}.
    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание Docker-образа.
    * `--metadata-options` — настройки параметров сервиса метаданных, например `aws-v1-http-endpoint=disabled`.

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    Чтобы настроить параметры сервиса метаданных контейнера:

    1. Откройте файл конфигурации Terraform и добавьте к описанию контейнера блок `metadata_options`:
      
        ```hcl
        resource "yandex_serverless_container" "metadata_container" {
          name               = "<имя_контейнера>"
          memory             = "<объем_RAM>"
          execution_timeout  = "<максимальное_время_выполнения>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          content {
            zip_filename = "<путь_к_ZIP-архиву>"
          }

          image {
            url = <путь_к_образу_контейнера>
          }

          metadata_options {
            metadata_options.0.gce_http_endpoint = "0_или_1_или_2"
            metadata_options.0.aws_v1_http_endpoint = "0_или_1_или_2"
          }
        }
        ```

        Где:

        * `metadata_options` — настройки параметров сервиса метаданных, например `metadata_options.0.gce_http_endpoint = "1"`. Укажите:
            * `0` — если хотите оставить значение по молчанию.
            * `1` — чтобы включить параметр.
            * `2` — чтобы выключить параметр.

        Более подробную информацию о параметрах ресурса `yandex_serverless_container` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).

   1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   Проверить, что контейнер и его настройки изменились, можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

   ```bash
   yc serverless container revision get <идентификатор_ревизии_контейнера>
   ```

- API {#api}

    Чтобы настроить параметры сервиса метаданных контейнера, воспользуйтесь методом REST API [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}
