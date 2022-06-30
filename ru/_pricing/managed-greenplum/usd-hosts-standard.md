| Ресурс           | Цена за 1 час |
|------------------|---------------|
| **Intel Cascade Lake**           |
| 100% vCPU        | $0.019179     |
| RAM (за 1 ГБ)    | $0.005077     |
| **Intel Ice Lake**               |
| 100% vCPU        | $0.017231     |
| RAM (за 1 ГБ)    | $0.004564     |

{% if audience == "cvos" %}

| Ресурс           | Цена за 1 час | Цена с CVoS на 1 год                                                   | Цена с CVoS на 3 года |
|------------------|---------------|------------------------------------------------------------------------|-----------------------|
| **Intel Cascade Lake**                                                          |
| 100% vCPU        | $0.019179     | {{ sku|USD|v1.commitment.y1.mdb.greenplum.cpu.c100.v2|string }} (-29%) | {{ sku|USD|v1.commitment.y3.mdb.greenplum.cpu.c100.v2|string }} (-45%) |
| RAM (за 1 ГБ)    | $0.005077     | {{ sku|USD|v1.commitment.y1.mdb.greenplum.ram.v2|string }} (-35%)      | {{ sku|USD|v1.commitment.y3.mdb.greenplum.ram.v2|string }} (-50%)      |
| **Intel Ice Lake**                                                              |
| 100% vCPU        | $0.017231     | {{ sku|USD|v1.commitment.y1.mdb.greenplum.cpu.c100.v3|string }} (-29%) | {{ sku|USD|v1.commitment.y3.mdb.greenplum.cpu.c100.v3|string }} (-45%) |
| RAM (за 1 ГБ)    | $0.004564     | {{ sku|USD|v1.commitment.y1.mdb.greenplum.ram.v3|string }} (-35%)      | {{ sku|USD|v1.commitment.y3.mdb.greenplum.ram.v3|string }} (-50%)      |

{% endif %}