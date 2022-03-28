{% include [local-ssd for Intel Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month | |
| ----------------------------------- | ------------------------------------------------------------------------ |---|
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| HDD network storage           | {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|string }} | ₽3.20 |
| Non-replicated SSD storage    | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.kafka|month|string }} | ₽8.80 |
| SSD network storage           | {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|string }} | ₽13.01 |
| Local SSD storage             | {{ sku|RUB|mdb.cluster.local-nvme.kafka|month|string }} * | ₽13.01 *|

\* You pay for using dedicated host storage based on the pricing policy specified in the [{{ compute-full-name }} documentation](../../compute/pricing.md#prices).

