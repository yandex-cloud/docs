{% include [local-ssd for Intel Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
| ----- | ----- |
| HDD network storage | {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|string }} |
| Non-replicated SSD storage | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.kafka|month|string }} |
| SSD network storage | {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|string }} |
| Local SSD storage | {{ sku|KZT|mdb.cluster.local-nvme.kafka|month|string }} * |

{% if product == "yandex-cloud" %}
\* You pay for using dedicated host storage based on the pricing policy specified in the [{{ compute-full-name }} documentation](../../compute/pricing.md#prices).
{% endif %}
