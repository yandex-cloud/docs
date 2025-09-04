---
title: Как остановить и запустить кластер {{ metastore-full-name }}
description: Следуя данной инструкции, вы сможете остановить и запустить кластер {{ metastore-full-name }}.
---

# Остановка и запуск кластера {{ metastore-full-name }}

{% include [Preview](../../../_includes/note-preview.md) %}

При необходимости вы можете остановить кластер {{ metastore-name }} и запустить его заново. При остановке кластера все данные в нем сохранятся: они снова станут доступны, когда вы запустите кластер.

## Остановка кластера {#stop-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы остановить кластер {{ metastore-name }}, выполните команду:

  ```bash
  {{ yc-metastore }} cluster stop <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Запуск кластера {#stop-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы запустить кластер {{ metastore-name }}, выполните команду:

  ```bash
  {{ yc-metastore }} cluster start <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

