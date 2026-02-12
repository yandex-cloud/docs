---
title: Получение правил доступа в {{ mtr-name }}
description: Вы можете узнать, какие правила доступа назначены для кластера {{ mtr-name }}.
---

# Получение правил доступа в {{ mtr-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите в блок **{{ ui-key.yacloud.trino.ClusterView.RBACView.label_rbac-settings_o2F64 }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы узнать, какие правила доступа назначены для кластера {{ mtr-name }}, выполните команду:

  ```bash
  {{ yc-mdb-tr }} cluster get-access-control <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

  Чтобы узнать, какие правила доступа назначены для кластера {{ mtr-name }}, [получите детальную информацию](cluster-list.md#get-cluster) об этом кластере.

{% endlist %}
