Configuration types:


* **s1**, **s2**, **s3**: Standard configurations with a 4:1 RAM GB to vCPU ratio.
* **m2**, **m3**: Configurations with an increased RAM GB to vCPU ratio (8:1). These configurations may be useful for clusters with higher cache requirements.
* **c3**: Configurations with a reduced RAM GB to vCPU ratio (2:1). These configurations may be useful for clusters with higher processor performance requirements.
* **b1**, **b2**, **b3**: Configurations with a guaranteed vCPU share under 100%. This host class is intended for test load, while the minimum recommended host configuration for production solutions is two vCPUs with a guaranteed share of 50%.



{% note info %}

Hosts with a guaranteed vCPU share under 50% cannot be used in multi-host clusters.

{% endnote %}
