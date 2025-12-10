This setting determines how replication will be managed in a multi-host {{ CH }} cluster:

* If `true`, {{ CK }} will manage the replication.

    {% include [ClickHouse Keeper can't turn off](../note-ck-no-turn-off.md) %}

* If not specified or `false`, {{ ZK }} will manage the replication and query distribution.
