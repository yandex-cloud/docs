| Resources      | Rate for 1 hour,<br>without VAT                      | Rate for 1 month,<br>without VAT |
|----------------|-----------------------------------------------------:|-----------------:|
| 100% vCPU      | {{ sku|USD|airflow.cluster.generic.vcpu.v1|string }} | {% calc [currency=USD] 720 × {{ sku|USD|airflow.cluster.generic.vcpu.v1|number }} %} |
| RAM (for 1 GB) | {{ sku|USD|airflow.cluster.generic.ram.v1|string }}  | {% calc [currency=USD] 720 × {{ sku|USD|airflow.cluster.generic.ram.v1|number }} %}  |
