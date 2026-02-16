---
title: Получить информацию о виртуальной машине
description: Следуя данной инструкции, вы сможете получить информацию о виртуальной машине.
---

# Получить информацию о виртуальной машине


Вы можете получить основную информацию о каждой созданной вами [виртуальной машине](../../concepts/vm.md) на странице ВМ в [консоли управления]({{ link-console-main }}). Чтобы получить детальную информацию вместе с пользовательскими [метаданными](../../concepts/vm-metadata.md), воспользуйтесь [CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md) или [API](../../api-ref/Instance/get.md).

Также основную информацию и метаданные можно получить [изнутри ВМ](#inside-instance).

## Получить информацию снаружи ВМ {#outside-instance}

{% include [metadata-external-access](../../../_includes/compute/metadata-external-access.md) %}

## Получить информацию изнутри ВМ {#inside-instance}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

### HTTP-запрос {#gce-http}

{% include [internal-http-request](../../../_includes/compute/metadata/internal-http-request.md) %}

### Примеры запросов {#request-examples}

{% include [internal-request-examples](../../../_includes/compute/metadata/internal-request-examples.md) %}