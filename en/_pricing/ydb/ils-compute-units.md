### Host computing resources {#prices-compute-units}

{% if audience == "cvos" %}

| Resource | Cost per hour | Cost with CVoS for 6 months | Cost with CVoS for 1 year |
|---------------|-----------------------------------------|---------------------------------------------------------------------------|---------------------------------------------------------------------------|
| {% if product == "yandex-cloud" %}**Intel Cascade Lake**{% endif %}{% if product == "cloud-il" %}**Intel Ice Lake**{% endif %} |
| 100% vCPU | {{ sku|ILS|ydb.cluster.v2.cpu|string }} | {{ sku|ILS|v1.commitment.selfcheckout.m6.ydb.cpu.c100.v2|string }} (-15%) | {{ sku|ILS|v1.commitment.selfcheckout.y1.ydb.cpu.c100.v2|string }} (-22%) |
| RAM (for 1 GB) | {{ sku|ILS|ydb.cluster.v2.ram|string }} | {{ sku|ILS|v1.commitment.selfcheckout.m6.ydb.ram.v2|string }} (-15%) | {{ sku|ILS|v1.commitment.selfcheckout.y1.ydb.ram.v2|string }} (-22%) |

{% else %}

| Resource | Cost per hour |
|---------------|-----------------------------------------|
| {% if product == "yandex-cloud" %}**Intel Cascade Lake**{% endif %}{% if product == "cloud-il" %}**Intel Ice Lake**{% endif %} |
| 100% vCPU | {{ sku|ILS|ydb.cluster.v2.cpu|string }} |
| RAM (for 1 GB) | {{ sku|ILS|ydb.cluster.v2.ram|string }} |

{% endif %}
