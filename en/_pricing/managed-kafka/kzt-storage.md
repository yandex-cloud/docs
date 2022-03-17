{% include [local-ssd for Intel Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
| ----------------------------------- | ------------------------------------------------------------------------ |
| Standard network storage | {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|string }} |
| Non-replicated network storage | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.kafka|month|string }} |
| Fast network storage | {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|string }} |
| Fast local storage | {{ sku|KZT|mdb.cluster.local-nvme.kafka|month|string }} * |

\* You pay for using dedicated host storage based on the pricing policy specified in the [{{ compute-full-name }} documentation](../../compute/pricing.md#prices).

