---
title: "Как создать сервисное подключение в {{ vpc-full-name }}"
description: "Следуя данной инструкции, вы сможете создать сервисное подключение (Private Endpoint) в VPC." 
---

# Создать сервисное подключение

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}


{% include [private-endpoint-create-roles](../../_includes/vpc/private-endpoint-create-roles.md) %}

Чтобы создать сервисное подключение:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [private-endpoint-create-cli](../../_includes/vpc/private-endpoint-create-cli.md) %}

{% endlist %}
