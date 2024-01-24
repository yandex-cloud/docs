---
title: "Как указать облачную сеть, в которой будет исполняться контейнер"
description: "Следуя данной инструкции, вы сможете указать облачную сеть, в которой будет исполняться контейнер."
---

# Указать облачную сеть, в которой будет исполняться контейнер

{% include [note-preview](../../_includes/note-preview.md) %}

Вы можете указать [облачную сеть](../../vpc/concepts/network.md#network), в которой будет исполняться контейнер.

{% include [network](../../_includes/functions/network.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-containers.section_parameters }}**, в поле **{{ ui-key.yacloud.vpc.label_network }}**, укажите облачную сеть, в которой будет исполняться контейнер.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- API {#api}

  Чтобы указать облачную сеть, в которой будет исполняться контейнер, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/container_service.md#DeployRevision).

{% endlist %}

## См. также

* [Сетевое взаимодействие в {{ serverless-containers-name }}](../concepts/networking.md).
