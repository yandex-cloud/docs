---
title: Поддержка версий {{ k8s }} в {{ managed-k8s-full-name }}
description: Из статьи вы узнаете какие версии {{ k8s }} поддерживаются в различных каналах {{ managed-k8s-name }}.
---

# Поддержка версий {{ k8s }} в {{ managed-k8s-full-name }}

В таблице ниже приведены поддерживаемые версии {{ k8s }} для различных [релизных каналов](./release-channels-and-updates.md) {{ managed-k8s-name }}, даты релизов и сроки прекращения поддержки.

#|
|| **Версия {{ k8s }}**

([Даты релизов](https://kubernetes.io/releases/)) {.cell-align-center} | **Релизный канал** {.cell-align-center} | > | > | **Прекращение поддержки** {.cell-align-center} ||
|| ^ | `RAPID` {.cell-align-center} | `REGULAR` {.cell-align-center} | `STABLE` {.cell-align-center} | ^ ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|| {{ version.name }} | {{ version.rapid }} | {{ version.regular }} | {{ version.stable }} | {{ version.deprecated }} ||
|#

{% note info %}

Предполагаемый срок выхода новой версии в канале `RAPID` — квартал, следующий после даты [официального релиза стабильной версии {{ k8s }}](https://kubernetes.io/releases/).

{% endnote %}

### См. также {#see-also}

* [{#T}](./release-channels-and-updates.md)
* [{#T}](../release-notes.md)
* [{{ k8s }} Release History](https://kubernetes.io/releases/)