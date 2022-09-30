Configuration types:

{% if product == "yandex-cloud" %}

* **s2**, **s3**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **m2**, **m3**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements.

{% endif %}

{% if product == "cloud-il" %}

* **s3**: Standard configuration, with 4:1 GB RAM to vCPU ratio.
* **m3**: Configuration with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements.

{% endif %}