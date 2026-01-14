---
title: Получение правил доступа в {{ mtr-name }}
description: Вы можете узнать, какие правила доступа назначены для кластера {{ mtr-name }}.
---

# Получение правил доступа в {{ mtr-name }}

{% list tabs group=instructions %}

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
