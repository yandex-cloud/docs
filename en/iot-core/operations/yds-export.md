---
title: Exporting messages to {{ yds-name }}
description: Follow this guide to export messages to {{ yds-name }}.
---

# Exporting messages to {{ yds-name }}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the registry is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the required registry from the list.
   1. Go to the **{{ ui-key.yacloud.iot.label_yds-exports }}** tab.
   1. In the top-right corner, click **{{ ui-key.yacloud.iot.button_add-yds-export }}**.
   1. Fill out the fields below:

      * **{{ ui-key.yacloud.common.name }}**: Export name.
      * **{{ ui-key.yacloud.iot.label_mqtt-topic-filter }}**: Specify the topic from which you want to export messages or a filter using [wildcard characters](../concepts/topic/usage.md#wildcards). If you leave this field empty, messages will be exported from all topics within the registry, including topics from all devices within the registry.
      * **{{ ui-key.yacloud.data-streams.label_data-stream }}**: Specify the name of the [data stream](../../data-streams/concepts/glossary.md#stream-concepts) where you want to send messages from MQTT topics, or [create a new one](../../data-streams/operations/manage-streams.md#create-data-stream). If you chose to create a new stream, click **Update** to update the list of streams.
      * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: Specify a [service account](../../iam/concepts/users/service-accounts.md) with the `yds-writer` role.

   1. Click **Add**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create an export:

   1. Get a list of registries in the folder:

      ```bash
      yc iot registry list
      ```

      Result:

      ```text
      +----------------------+-------------------+
      |          ID          |       NAME        |
      +----------------------+-------------------+
      | arenou2oj4********** | my-registry       |
      +----------------------+-------------------+
      ```

   1. Create an export:

      ```bash
      yc iot registry yds-export add \
        --registry-name <registry_name> \
        --name <export_name> \
        --database <database_path> \
        --stream <stream_name> \
        --mqtt-topic-filter <topic> \
        --stream-service-account-name <service_account_name>
      ```

      Where:

      * `--registry-name`: Name of the registry.
      * `--name`: Name of the export.
      * `--database`: Location of the [database](https://ydb.tech/docs/en/concepts/connect#database) where the stream data is stored. Specify the second part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`). For example, `/{{ region-id }}/r1gra875baom********/g5n22e7ejf**********`.
      * `--stream`: Name of the [data stream](../../data-streams/concepts/glossary.md#stream-concepts) where messages from MQTT topics will be sent to.
      * `--mqtt-topic-filter`: Topic from which messages will be exported or filter using [wildcard characters](../concepts/topic/usage.md#wildcards). If this parameter is not specified, messages will be exported from all topics within the registry, including topics from all devices within the registry.
      * `--stream-service-account-name`: Name of the [service account](../../iam/concepts/users/service-accounts.md) with the `yds-writer` role.

      Result:

      ```text
      id: are520n46t**********
      name: export-from-topic
      registry_id: areqqa5ntm**********
      database: /{{ region-id }}/b1gia87mbaom********/etnu4r0v1c**********
      stream: topic-message-stream
      service_account_id: ajeu9klp40**********
      created_at: "2023-09-18T09:52:28.840124837Z"
      ```

- API {#api}

   To add the export to {{ yds-name }} for a registry, use the [RegistryService/AddDataStreamExport](../api-ref/grpc/Registry/addDataStreamExport.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/topic/usage.md#yds-export)
