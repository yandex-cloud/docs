# {{ ml-platform-full-name }} releases

Information about changes to the {{ ml-platform-full-name }} service will be published here.

{% if product == "yandex-cloud" %}

{% note tip %}

To keep up to date with the latest changes and updates, subscribe to our [{{ ml-platform-full-name }} Community](https://t.me/yandex_datasphere) Telegram news channel.

{% endnote %}

## Release 20.10.2022 {#201022}

Greatly improved the Apache Spark™ cluster functionality:
1. {{ ml-platform-name }} now has a new type of resources: [{{ dataproc-name }} templates](concepts/data-proc-template.md).
1. You can now [configure a livy session](concepts/data-proc.md#sessions) when using {{ dataproc-name }} clusters.
1. {{ ml-platform-name }} now supports the [Spark SQL library](concepts/data-proc.md#sql).

## Release 23.09.2022 {#230922}

We're excited to release a big update to {{ ml-platform-name }}: a new interface, communities, resources, and lots of other features for ML development.

{% include [old-releases](../_includes/datasphere/migration/release-notes-old.md) %}

{% endif %}
