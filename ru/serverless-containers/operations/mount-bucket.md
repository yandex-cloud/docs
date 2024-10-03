---
title: Как смонтировать бакеты в контейнер {{ serverless-containers-full-name }}
description: Следуя данной инструкции, вы сможете смонтировать бакеты в контейнер {{ serverless-containers-name }}.
---

# Смонтировать бакеты в контейнер

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-containers.section_parameters }}** выберите или создайте новый [сервисный аккаунт](../../iam/concepts/users/service-accounts) с ролью:
       * `storage.viewer`, чтобы только читать данные из смонтированного бакета.
       * `storage.uploader`, чтобы читать данные из смонтированного бакета и записывать их в него.
    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.title_mount-files }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}**.
    1. Укажите в поле:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-path }}** — путь монтирования. Директория, к которой смонтируется бакет, будет доступна по указанному пути.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket }}** — имя бакета, который хотите смонтировать, или создайте новый.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket-prefix }}** — [папку](../../storage/concepts/object.md#folder) в бакете. Если поле пустое, смонтируется весь бакет.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- API {#api}

  Чтобы смонтировать бакет, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/container_service.md#DeployRevision).

{% endlist %}

## См. также {#see-also}

* [Монтирование файловых систем в контейнер](../concepts/mounting.md)
* [Монтирование файловых систем в функцию](../../functions/concepts/mounting.md)
