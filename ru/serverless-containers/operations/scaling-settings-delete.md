---
title: Удалить настройки масштабирования контейнера
description: Следуя данной инструкции, вы сможете удалить настройки масштабирования контейнера.
---

# Удалить настройки масштабирования контейнера

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-containers.section_parameters }}** укажите:
       * **{{ ui-key.yacloud.serverless-containers.label_min-instances }}** — `0`.
       * **{{ ui-key.yacloud.serverless-containers.label_zone-instances-limit }}** — `0`.
       * **{{ ui-key.yacloud.serverless-containers.label_zone-requests-limit }}** — `0`.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить настройки масштабирования, создайте новую ревизию контейнера, не указывая настройки масштабирования:

    ```bash
    yc serverless container revision deploy \
      --container-id <идентификатор_контейнера> \
      --image <URL_Docker-образа> \
      --service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:
    * `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.
    * `--image` — URL [Docker-образа](../../container-registry/concepts/docker-image.md).
    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание образа.

    Результат:

    ```
    done (2s)
    id: bbam2cv903iv********
    container_id: bbab5i36nvda********
    created_at: "2026-04-01T13:31:11.459Z"
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
    log_options:
      folder_id: b1gc1t4cb638********
    runtime:
      http: {}
    metadata_options: {}
    ```

    Более подробную информацию о команде смотрите в [справочнике CLI](../../../cli/cli-ref/managed-services/serverless/container/revision/deploy).

- API {#api}

  Чтобы удалить настройки масштабирования контейнера, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}
