1. In the [management console]({{ link-console-main }}), open the target cluster.
1. Make sure the migrated topic is displayed on the **{{ ui-key.yacloud.kafka.label_topics }}** tab.

   A prefix (`source` by default) will be added to the topic name. For example, a topic named `mytopic` will be moved to the target cluster as `source.mytopic`.

1. [Connect](../../managed-kafka/operations/connect/clients.md#bash-zsh) to the target cluster topic using kafkacat. Add the prefix to the source cluster topic name.
1. Make sure the console displays messages from the source cluster topic.
