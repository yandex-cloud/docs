# Поддержка версий {{ k8s }} в {{ managed-k8s-full-name }}

В таблице ниже приведены поддерживаемые версии {{ k8s }} для различных [релизных каналов](release-channels-and-updates.md) {{ managed-k8s-name }}, даты релизов и сроки прекращения поддержки.

#|
|| **Версия {{ k8s }}**

([Даты релизов](https://kubernetes.io/releases/)) {align="center"} | **Релизный канал** {align="center"} | > | > | **Прекращение поддержки** {align="center"} ||
|| ^ | `RAPID` {align="center"} | `REGULAR` {align="center"} | `STABLE` {align="center"} | ^ ||
|| {{ k8s-version.0.name }} | {{ k8s-version.0.rapid }} | {{ k8s-version.0.regular }} | {{ k8s-version.0.stable }} | {{ k8s-version.0.deprecated }} ||
|| {{ k8s-version.1.name }} | {{ k8s-version.1.rapid }} | {{ k8s-version.1.regular }} | {{ k8s-version.1.stable }} | {{ k8s-version.1.deprecated }} ||
|| {{ k8s-version.2.name }} | {{ k8s-version.2.rapid }} | {{ k8s-version.2.regular }} | {{ k8s-version.2.stable }} | {{ k8s-version.2.deprecated }} ||
|| {{ k8s-version.3.name }} | {{ k8s-version.3.rapid }} | {{ k8s-version.3.regular }} | {{ k8s-version.3.stable }} | {{ k8s-version.3.deprecated }} ||
|| {{ k8s-version.4.name }} | {{ k8s-version.4.rapid }} | {{ k8s-version.4.regular }} | {{ k8s-version.4.stable }} | {{ k8s-version.4.deprecated }} ||
|| {{ k8s-version.5.name }} | {{ k8s-version.5.rapid }} | {{ k8s-version.5.regular }} | {{ k8s-version.5.stable }} | {{ k8s-version.5.deprecated }} ||
|| {{ k8s-version.6.name }} | {{ k8s-version.6.rapid }} | {{ k8s-version.6.regular }} | {{ k8s-version.6.stable }} | {{ k8s-version.6.deprecated }} ||
|| {{ k8s-version.7.name }} | {{ k8s-version.7.rapid }} | {{ k8s-version.7.regular }} | {{ k8s-version.7.stable }} | {{ k8s-version.7.deprecated }} ||
|#

{% note info %}

Предполагаемый срок выхода новой версии в канале `RAPID` — квартал, следующий после даты [официального релиза стабильной версии {{ k8s }}](https://kubernetes.io/releases/).

{% endnote %}

### См. также {#see-also}

* [{#T}](release-channels-and-updates.md)
* [{#T}](../release-notes.md)
* [{{ k8s }} Release History](https://kubernetes.io/releases/)