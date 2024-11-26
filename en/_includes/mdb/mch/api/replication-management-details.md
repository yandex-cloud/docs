This setting determines how replication will be managed in a cluster of multiple {{ CH }} hosts:

* If `true`, the replication will be managed using {{ CK }}.

    {% include [ClickHouse Keeper can't turn off](../note-ck-no-turn-off.md) %}

* If undefined or `false`, the replication and query distribution will be managed using {{ ZK }}.
