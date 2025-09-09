---
title: Вызвать контейнер асинхронно в {{ serverless-containers-full-name }}
description: Следуя данной инструкции, вы сможете настроить и выполнить асинхронный вызов контейнера в {{ serverless-containers-name }}.
---

# Вызвать контейнер асинхронно

{% include [note-preview](../../_includes/note-preview.md) %}

## Настройте асинхронный вызов {#async}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [контейнер](../concepts/container.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Выберите контейнер, [ревизию](../concepts/container.md#revision) которого хотите создать.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
  1. В блоке **Асинхронный вызов**:

      1. Включите асинхронный вызов.
      1. Укажите сервисный аккаунт для асинхронного вызова, у которого есть [роль](../security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker`.

  1. Нажмите **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы настроить асинхронный вызов, выполните команду:

    ```bash
    yc serverless container revision deploy \
      --container-name <имя_контейнера> \
      --image <URL_Docker-образа> \
      --service-account-id <идентификатор_сервисного_аккаунта> \
      --async-service-account-id <идентификатор_сервисного_аккаунта_для_асинхронного_вызова>
    ```


    Где:

    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть [роль](../security/index.md#serverless-containers-editor) `serverless-containers.editor` или выше.
    * `--async-service-account-id` — идентификатор сервисного аккаунта для асинхронного вызова, у которого есть [роль](../security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker`.

    Результат:

    ```text
    done (6s)
    id: bba1r76l8f73********
    container_id: bbado1g2mtqj********
    created_at: "2025-09-08T12:03:32.797Z"
    image:
      image_url: cr.yandex/crpmfvcgnl26********/ubuntu:hello
      image_digest: sha256:96ab2d89a82fcfc63e24b9ef26de8b3b11ed1043cec41d4359a8de8b********
    resources:
      memory: "134217728"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 3s
    concurrency: "1"
    service_account_id: ajelprpohp7r********
    status: ACTIVE
    log_options:
      folder_id: b1g681qpemb4********
    runtime:
      http: {}
    async_invocation_config:
      service_account_id: ajeaim70pe1u********
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы настроить асинхронный вызов:

  1. Откройте файл конфигурации {{ TF }} и добавьте к описанию контейнера блок `async_invocation`:

      ```hcl
      resource "yandex_serverless_container" "test-container" {
        name               = "<имя_контейнера>"
        memory             = "<объем_RAM>"
        execution_timeout  = "<максимальное_время_выполнения>"
        service_account_id = "<идентификатор_сервисного_аккаунта>"

        image {
          url = <путь_к_образу_контейнера>
        }

        async_invocation {
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      }
      ```

      Где:

      * `async_invocation` — параметры асинхронного вызова:

          * `service_account_id` — сервисный аккаунт, у которого есть [роль](../security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker`.

      Более подробную информацию о параметрах ресурса `yandex_serverless_container` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение контейнера и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```bash
  yc serverless serverless-container revision get <идентификатор_ревизии_контейнера>
  ```

- API {#api}

  Чтобы настроить асинхронный вызов, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}


## Вызовите контейнер {#invoke}

[Вызовите](invoke.md) контейнер по HTTP, указав при вызове заголовок `X-Ycf-Container-Integration-Type: async`.


## См. также {#see-also}

* [{#T}](../concepts/invoke-async.md)
