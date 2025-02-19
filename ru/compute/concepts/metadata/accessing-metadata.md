---
title: Получение метаданных виртуальных машин {{ compute-name }}
description: Из этой статьи вы узнаете о способах получения метаданных виртуальных машин {{ compute-full-name }}.
---

# Доступ к метаданным виртуальных машин

[Сервис метаданных](../vm-metadata.md) позволяет [читать](../../operations/vm-metadata/get-vm-metadata.md) метаданные как [снаружи](#external-access), так и [изнутри](#internal-access) виртуальных машин.

## Доступ к метаданным снаружи ВМ {#external-access}

Извне доступ к метаданным виртуальных машин можно [получить](../../operations/vm-metadata/get-vm-metadata.md#external-access) с помощью инструментов {{ yandex-cloud }}: [консоли управления]({{ link-console-main }}), [CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md), [{{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md) и [API](../../api-ref/Instance/get.md). 

{% include [external-access-directories](../../../_includes/compute/metadata/external-access-directories.md) %}

## Доступ к метаданным изнутри ВМ {#internal-access}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

Подробнее о получении метаданных изнутри ВМ см. в разделе [Примеры запросов к сервису метаданных изнутри ВМ](../../operations/vm-metadata/get-vm-metadata.md#request-examples).

#### См. также {#see-also}

* [Получение метаданных виртуальной машины](../../operations/vm-metadata/get-vm-metadata.md)
* [{#T}](../vm-metadata.md)
* [{#T}](./directories.md)
* [{#T}](./public-image-keys.md)
* [{#T}](./sending-metadata.md)
* [{#T}](./identity-document.md)