# Добавить настройки масштабирования контейнеру

Вы можете задать:

{% include [scaling-settings](../../_includes/serverless-containers/scaling-settings.md) %}

{% include [provisioned-instances-price](../../_includes/serverless-containers/provisioned-instances-price.md) %}

Настройки масштабирования не могут превышать [квоты](../concepts/limits.md#serverless-containers-quotas).

{% note info %}

{% include [provisioned-instances-time](../../_includes/functions/provisioned-instances-time.md)%}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-containers.section_parameters }}** задайте настройки масштабирования.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы задать настройки масштабирования, выполните команду:

    ```bash
    yc serverless container revision deploy \
      --container-id <идентификатор_контейнера> \
      --image <URL_Docker-образа> \
      --min-instances 3 \
      --zone-instances-limit 2 \
      --zone-requests-limit 1 \
      --service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:
    * `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.
    * `--image` — URL [Docker-образа](../../container-registry/concepts/docker-image.md).
    * `--min-instances` — количество подготовленных экземпляров.
    * `--zone-instances-limit` — максимальное количество экземпляров контейнера в зоне доступности.
    * `--zone-requests-limit` — максимальное количество одновременно выполняемых вызовов контейнера в зоне доступности.
    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание Docker-образа.

    Результат:

    ```
    done (3s)
    id: bbalbpl7k8hmn********
    container_id: bbab5i36nvda********
    created_at: "2026-04-01T13:46:38.069Z"
    image:
      image_url: cr.yandex/crpp35hht729********/ubuntu:hello
      image_digest: sha256:f6f34c6cf5f56e594e9828274592f1cc4d9383b1689057ccaf188d41********
    resources:
      memory: "134217728"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 3s
    concurrency: "1"
    service_account_id: aje07l4q4vmo********
    status: ACTIVE
    provision_policy:
      min_instances: "1"
    scaling_policy:
      zone_instances_limit: "2"
      zone_requests_limit: "1"
    log_options:
      folder_id: b1gc1t4cb638********
    runtime:
      http: {}
    metadata_options: {}
    ```

    Более подробную информацию о команде смотрите в [справочнике CLI](../../../cli/cli-ref/serverless/cli-ref/container/revision/deploy).

- {{ TF }} {#tf}
  
    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
    
    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Чтобы задать количество подготовленных экземпляров, опишите в конфигурационном файле параметр `min_instances`.

        Другие настройки масштабирования можно задать с помощью консоли управления, {{ yandex-cloud }} CLI или API.
        
        Пример структуры конфигурационного файла:
        
        ```
        resource "yandex_serverless_container" "container" {
          name               = "container"
          service_account_id = "ajeh91ebakk1********"
          memory             = 128
          image {
            url = "cr.yandex/crpnj09pj62e********/ubuntu:hello"
          }
          provision_policy {
            min_instances = 2
          }
        }
        ```

        Где:
        * `name` — имя контейнера.
        * `service_account_id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание Docker-образа.
        * `memory` — требуемая память. По умолчанию — 128 МБ.
        * `url` — URL [Docker-образа](../../container-registry/concepts/docker-image.md).
        * `min_instances` — количество подготовленных экземпляров.
       
       Более подробную информацию о параметрах ресурса `yandex_serverless_container` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).

    1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

        В терминале будет выведен список параметров ресурса. Это проверочный этап: ресурс не будет изменен. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Примените изменения конфигурации:

        ```
        terraform apply
        ```

    1. Подтвердите изменения ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

    Чтобы добавить настройки масштабирования для контейнера, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}
