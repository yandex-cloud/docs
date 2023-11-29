{% include [local-ssd for Intel Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|--------------------------------|-----------------------------------------------------------------------:|
| Standard network storage | {{ sku|USD|mdb.cluster.network-hdd.kafka|month|string }} |
| Non-replicated network storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.kafka|month|string }} |
| Fast network storage | {{ sku|USD|mdb.cluster.network-nvme.kafka|month|string }} |
| Fast local storage | {{ sku|USD|mdb.cluster.local-nvme.kafka|month|string }} * |


\* If you use dedicated hosts, this storage class is charged as described in the [Yandex Compute Cloud documentation](../../compute/pricing.md#prices).

