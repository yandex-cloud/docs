# Configuring a Logbroker target endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure connection settings:

## Settings {#settings}

{% list tabs %}

- Management console

   * **Instance**: Select one from the list.

   * **Topic settings**: Select `Topic full name` or `Topic prefix`.

      * **Topic full name**: Name of the topic to send messages to.

      * **Topic prefix**: Topic prefix, analog of the `database.server.name Debezium` setting. Messages will be sent to a topic named `<topic_prefix>.<schema>.<table_name>`.

{% endlist %}


