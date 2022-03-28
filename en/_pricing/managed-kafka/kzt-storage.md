{% include [local-ssd for Intel Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month | |
| ----------------------------------- | ------------------------------------------------------------------------ |---|
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| HDD network storage        | {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|string }} | ₸16.00 |
| Non-replicated SSD storage | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.kafka|month|string }} | ₸44.00 |
| SSD network storage        | {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|string }} | ₸65.05 |
| Local SSD storage          | {{ sku|KZT|mdb.cluster.local-nvme.kafka|month|string }} * | ₸65.05 * |

\* You pay for using dedicated host storage based on the pricing policy specified in the [{{ compute-full-name }} documentation](../../compute/pricing.md#prices).

