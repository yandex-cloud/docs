{% if product == "yandex-cloud" %}

* **s2**, **s3**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **i2**, **i3**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements. Hosts with this configuration run in a [software-accelerated network](../../vpc/concepts/software-accelerated-network.md), and their use significantly affects [cluster pricing](../../managed-greenplum/pricing/index.md#prices-hosts).

{% endif %}

{% if product == "cloud-il" %}

* **s3**: Standard configuration, with 4:1 GB RAM to vCPU ratio.
* **i3**: Configuration with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements. Hosts with this configuration run in a [software-accelerated network](../../vpc/concepts/software-accelerated-network.md), and their use significantly affects [cluster pricing](../../managed-greenplum/pricing/index.md#prices-hosts).

{% endif %}