| Resources      | Rate for 1 hour,<br>without VAT                    | Rate for 1 month,<br>without VAT |
|---------------|---------------------------------------------------:|----------------------------:|
| vCPU     | {{ sku|USD|spark.cluster.generic.vcpu.v2|string }} | {{ sku|USD|spark.cluster.generic.vcpu.v2|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|spark.cluster.generic.ram.v2|string }} | {{ sku|USD|spark.cluster.generic.ram.v2|month|string }} |