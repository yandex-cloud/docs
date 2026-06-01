---
title: Посмотреть настройки масштабирования контейнера
description: Следуя данной инструкции, вы сможете посмотреть настройки масштабирования контейнера.
---

# Посмотреть настройки масштабирования контейнера

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер. В блоке **{{ ui-key.yacloud.serverless-containers.section-revisions }}** в строке с ревизией контейнера отобразится количество подготовленных экземпляров.

        Информацию о количестве экземпляров контейнера в зоне доступности и количестве одновременно выполняемых вызовов контейнера в зоне доступности можно посмотреть, [получив](revision-info.md) информацию о ревизии контейнера.

- CLI {#cli}

    Чтобы посмотреть настройки масштабирования контейнера, [получите](revision-info.md) информацию о ревизии контейнера. Настройки масштабирования отобразятся в следующих параметрах:

    * `min_instances` — количество подготовленных экземпляров контейнера.
    * `zone_instances_limit` — количество экземпляров контейнера в зоне доступности.
    * `zone_requests_limit` — количество одновременно выполняемых вызовов контейнера в зоне доступности. 
  
- API {#api}

  Чтобы посмотреть настройки масштабирования контейнера, воспользуйтесь методом REST API [getRevision](../containers/api-ref/Container/getRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/GetRevision](../containers/api-ref/grpc/Container/getRevision.md).

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}
