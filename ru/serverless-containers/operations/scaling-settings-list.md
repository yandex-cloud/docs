---
title: Посмотреть настройки масштабирования контейнера
description: Следуя данной инструкции, вы сможете посмотреть настройки масштабирования контейнера.
---

# Посмотреть настройки масштабирования контейнера

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер. Количество подготовленных экземпляров отображается в блоке **{{ ui-key.yacloud.serverless-containers.section-revisions }}**, в строке с активной ревизией контейнера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы посмотреть настройки масштабирования контейнера, выполните команду:

    ```bash
    yc serverless container revision get container-id=flhqle7d5oh2********
    ```

    Где `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.

    Результат:

    ```text
    id: flhqle7d5oh2********
	container_id: flhqle7d5oh2********
	created_at: "2022-09-14T12:48:55.914Z"
	image:
	  image_url: {{ registry }}/crtrvt9l6fh2********/billing-test
	  image_digest: sha256:e3aaa4c9af7d99ea5e4e4236bc540a3cc826d1f1344a601ddb9cbch2********
	resources:
	  memory: "134217728"
	  cores: "1"
	  core_fraction: "100"
	execution_timeout: 10s
	service_account_id: bfbdkhbl8fh2********
	status: ACTIVE
	provision_policy:
	  min_instances: "1"
    ```

    Количество подготовленных экземпляров отображается в поле `min_instances`.

- API {#api}

  Чтобы посмотреть настройки масштабирования контейнера, воспользуйтесь методом REST API [getRevision](../containers/api-ref/Container/getRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/GetRevision](../containers/api-ref/grpc/container_service.md#GetRevision).

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}