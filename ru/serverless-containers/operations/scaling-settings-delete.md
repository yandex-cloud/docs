---
title: Удалить настройки масштабирования контейнера
description: Следуя данной инструкции, вы сможете удалить настройки масштабирования контейнера.
---

# Удалить настройки масштабирования контейнера

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-containers.section_parameters }}** укажите количество подготовленных экземпляров равным `0`.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    Чтобы удалить настройки масштабирования для контейнера, создайте новую ревизию контейнера и укажите параметр `min-instances` равным `0`:

    ```bash
    yc serverless container revision deploy \
	  --container-id <идентификатор_контейнера> \
	  --image <URL_Docker-образа> \
	  --cores 1 \
	  --memory 1GB \
	  --execution-timeout 3s \
	  --service-account-id <идентификатор_сервисного_аккаунта> \
	  --min-instances 0
    ```

    Где:
    * `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.
    * `--cores` — количество ядер, которые доступны контейнеру.
    * `--memory` — требуемая память. По умолчанию — 128 МБ.
    * `--execution-timeout` — таймаут. По умолчанию — 3 секунды.
    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание образа.
    * `--min-instances` — количество подготовленных экземпляров.

    Результат:

    ```text
    id: bbajn5q2d74c********
	container_id: bba3fva6ka5g********
	created_at: "2021-07-09T15:04:55.135Z"
	image:
	  image_url: {{ registry }}/crpd3cicopk7********/test-container:latest
	  image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
	resources:
	  memory: "1073741824"
	  cores: "1"
	execution_timeout: 3s
	service_account_id: ajeqnasj95o7********
	status: ACTIVE
    ```

- API {#api}

  Чтобы удалить настройки масштабирования контейнера, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}
