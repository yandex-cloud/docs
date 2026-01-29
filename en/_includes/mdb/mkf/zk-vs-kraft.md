Different {{ KF }} versions use different tools to store cluster metadata, state, and configuration:

{% include [kafka-versions](kafka-versions.md) %}

**Hosts with {{ ZK }}** {#host-zookeeper}

When selecting {{ KF }} version 3.5 and lower, only {{ ZK }} is supported.

A new multi-host cluster will automatically get three separate {{ ZK }} hosts.

**Hosts with {{ kraft-short-name }}** {#host-kraft}

When selecting {{ KF }} version 3.6 and higher, the {{ kraft-short-name }} protocol is additionally supported.

The {{ kraft-short-name }} protocol is available in one of the following modes:

{% include [kraft-modes](kraft-modes.md) %}

For more information about the differences in cluster configurations with {{ ZK }} and {{ kraft-short-name }}, see [Resource relationships in {{ mkf-name }}](../../../managed-kafka/concepts/index.md).
