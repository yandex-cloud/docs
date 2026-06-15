---
canonical: '{{ link-docs }}/tutorials/iot/data-recording'
---

# Writing device data to a database

{% include [iot-sunset-warning](../../_includes/iot-core/sunset-warning.md) %}

In this tutorial, you will learn how to write device data to a database. In our example, we will use a [{{ mpg-full-name }} cluster](../../managed-postgresql/concepts/index.md). To connect your device to {{ iot-name }}, you will need an MQTT broker. All the following steps are performed in the [management console]({{ link-console-main }}).

{% include [data-recording](../../_tutorials/applied/data-recording.md) %}