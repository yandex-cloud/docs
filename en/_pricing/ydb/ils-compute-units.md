### Host computing resources {#prices-compute-units}

{% if audience == "cvos" %}

| Resource       | Cost for 1 hour, with VAT            | With CVoS for 6 months                                                    | With CVoS for 1 year                                                      |
|----------------|-----------------------------------------|---------------------------------------------------------------------------|---------------------------------------------------------------------------|
| **Intel Cascade Lake**                                                                                                                                                                                           |
| 100% vCPU      | {{ sku|ILS|ydb.cluster.v2.cpu|string }} | {{ sku|ILS|v1.commitment.selfcheckout.m6.ydb.cpu.c100.v2|string }} (-15%) | {{ sku|ILS|v1.commitment.selfcheckout.y1.ydb.cpu.c100.v2|string }} (-22%) |
| RAM (for 1 GB) | {{ sku|ILS|ydb.cluster.v2.ram|string }} | {{ sku|ILS|v1.commitment.selfcheckout.m6.ydb.ram.v2|string }} (-15%)      | {{ sku|ILS|v1.commitment.selfcheckout.y1.ydb.ram.v2|string }} (-22%)      |

{% else %}

| Resource       | Cost for 1 hour, with VAT            |
|----------------|-----------------------------------------|
| **Intel Cascade Lake**                                   |
| 100% vCPU      | {{ sku|ILS|ydb.cluster.v2.cpu|string }} |
| RAM (for 1 GB) | {{ sku|ILS|ydb.cluster.v2.ram|string }} |

{% endif %}
