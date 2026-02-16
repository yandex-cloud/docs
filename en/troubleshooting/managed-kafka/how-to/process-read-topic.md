# How to monitor the process of reading topics in {{ mkf-name }}


## Case description {#case-description}

You need to monitor the process of reading topics in {{ mkf-name }}.

## Solution {#case-resolution}

To monitor how the topics are read, use one of the options below:

- View the chart of the `kafka_group_topic_partition_lag` [metric](../../../managed-kafka/metrics.md) in {{ monitoring-full-name }}.
- Use the `kafka-consumer-groups` command line tool that comes with the Kafka distribution file.

  Command example:
  ```
  kafka-consumer-groups.sh --command-config connect --bootstrap-server <hostname>:9091 --group <group_name> --describe
  ```

- Connect the external UI for the cluster to monitor the `consumer group` metrics. The possible options include `Kafka UI` or `AKHQ`. For more info on how to deploy `Kafka UI` on your own, see [this tutorial](../../../managed-kafka/tutorials/deploy-kafka-ui.md). 
