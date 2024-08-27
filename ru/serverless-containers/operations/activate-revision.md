---
title: "Сделать ревизию активной"
description: "Следуя данной инструкции, вы сможете сделать ревизию контейнера активной."
---

# Сделать ревизию активной

{% include [active-revision](../../_includes/serverless-containers/active-revision.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Выберите контейнер.
  1. В строке с нужной ревизией нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и в выпадающем списке выберите **{{ ui-key.yacloud.serverless-containers.label_edit-active-revision }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.serverless-containers.popup-confirm-edit-active-revision_button_confirm }}**. Статус ревизии изменится с `Obsolete` на `Active`.
  

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% include [get-revision-list](../../_includes/serverless-containers/get-revision-list.md) %}

  Чтобы сделать ревизию контейнера активной, выполните команду:

  ```bash
  yc serverless containers rollback \
   --name <имя_контейнера> \
   --revision-id <идентификатор_ревизии>
  ```

  Где:

  * `--name` — имя контейнера, активную ревизию которого вы хотите изменить.
  * `--revision-id` — идентификатор ревизии контейнера, которую вы хотите сделать активной.

  Результат:

  ```text
  id: bba610kqnj8b********
  folder_id: b1g3f9i71bpm********
  created_at: "2023-11-15T12:49:49.795Z"
  name: container
  url: https://bba610kqnj8b********.containers.yandexcloud.net/
  status: ACTIVE
  ```

- API {#api}

  Чтобы сделать ревизию контейнера активной, воспользуйтесь методом REST API [rollback](../../serverless-containers/containers/api-ref/Container/rollback.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Rollback](../../serverless-containers/containers/api-ref/grpc/container_service.md#Rollback).

{% endlist %}