---
title: Как получить метаданные виртуальной машины
description: Следуя данной инструкции, вы сможете получить метаданные изнутри и извне виртуальной машины.
---

# Получить метаданные виртуальной машины

[Сервис метаданных](../../../compute/concepts/vm-metadata.md) позволяет читать метаданные как [снаружи](#external-access), так и [изнутри](#internal-access) виртуальных машин.

## Доступ к метаданным снаружи ВМ {#external-access}

{% include [metadata-external-access](../../../_includes/compute/metadata-external-access.md) %}

## Доступ к метаданным изнутри ВМ {#internal-access}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

### HTTP-запрос {#gce-http}

{% include [internal-http-request](../../../_includes/compute/metadata/internal-http-request.md) %}

### Примеры запросов {#request-examples}

{% include [internal-request-examples](../../../_includes/compute/metadata/internal-request-examples.md) %}