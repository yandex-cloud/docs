Configuration types:

{% if product == "yandex-cloud" %}

* **s2**, **s3**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **m2**, **m3**: Configurations with an increased GB RAM to vCPU ratio (8:1).
* **hm2**, **hm3**: Configurations with the amount of GB of RAM strongly dominating the number of vCPUs (up to 32:1).

**m2**, **m3**, **hm2** and **hm3** configurations can be useful for clusters with higher cache requirements.

{% endif %}

{% if product == "cloud-il" %}

* **s3**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **m3**: Configurations with an increased GB RAM to vCPU ratio (8:1).
* **hm3**: Configurations with the amount of GB of RAM strongly dominating the number of vCPUs (up to 32:1).

**m3** and **hm3** configurations can be useful for clusters with higher cache requirements.
{% endif %}