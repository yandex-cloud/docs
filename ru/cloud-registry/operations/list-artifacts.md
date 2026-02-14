---
title: Листинг артефактов в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы получите список артефактов, загруженных в {{ cloud-registry-name }}.
---

# Листинг артефактов в {{ cloud-registry-name }}

Вы можете получить список всех [артефактов](../../concepts/artifacts.md), загруженных в [реестр](../../concepts/registry.md) {{ cloud-registry-name }}, включая Docker-образы, Helm-чарты и другие типы артефактов.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы посмотреть список артефактов, загруженных в {{ cloud-registry-name }}, выполните команду:

  ```bash
  yc cloud-registry registry list-artifacts <registry-id> --node-path=<путь внутри реестра>
  ```

{% endlist %}
