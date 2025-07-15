# {{ kraft-name }} protocol in {{ mkf-name }} clusters

_[{{ kraft-name }}](https://docs.confluent.io/platform/current/kafka-metadata/kraft.html)_ (short name: {{ kraft-short-name }}) is an approval protocol allowing you to store metadata and manage it in {{ KF }}. {{ kraft-short-name }} makes {{ KF }} independent of the external metadata synchronization service, {{ ZK }}.

{{ kraft-short-name }} is supported by {{ mkf-name }} clusters with {{ KF }} 3.6 or higher.

[{{ ZK }} is supported](index.md#zookeeper) by clusters with {{ KF }} 3.5 or lower. An update up to {{ KF }} 3.9 is available for such clusters.

Reasons for replacing {{ ZK }} with {{ kraft-short-name }}:

* {{ ZK }} has become obsolete in {{ KF }} 3.5 or higher.
* {{ ZK }} support will be discontinued starting from {{ KF }} 4.0.

## {{ mkf-name }} cluster topology {#cluster-topology}

{% include [kraft-cluster-topology](../../_includes/mdb/mkf/kraft-cluster-topology.md) %}

## {{ kraft-name }} pros and cons {#pros-and-cons}

{{ kraft-short-name }} advantages stem from the fact that {{ KF }} no longer depends on the {{ ZK }} external system:

* You do not need to pay extra for {{ ZK }} hosts.
* There is a single mechanism in place for information security instead of multiple ones.
* A cluster with {{ kraft-short-name }} is easier to manage, as it has no {{ ZK }} hosts.
* The cluster becomes more fault-tolerant and recovers almost instantly in case of a failure.
* You can create a greater number of partitions within the cluster.

For more information, see the Confluent [website](https://developer.confluent.io/learn/kraft/#benefits-of-kafkas-new-quorum-controller) and [documentation](https://docs.confluent.io/platform/current/kafka-metadata/kraft.html).

{{ kraft-short-name }} cons arise from the [cluster topology specifics](#cluster-topology):

* In the combined mode, {{ kraft-short-name }} metadata controllers are not isolated from {{ KF }} as effectively as {{ ZK }} hosts. Therefore, [{{ KF }} does not recommend]({{ kf.docs }}#kraft_role) using the combined mode in critical development environments. The combined mode is more suitable for local development and testing.
* In a cluster with {{ kraft-short-name }}, you cannot flexibly manage the number of hosts: you can have exactly three hosts.
