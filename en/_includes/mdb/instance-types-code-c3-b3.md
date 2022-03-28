Configuration types:

* **s1**, **s2**, **s3**: Standard configurations with a 4:1 GB RAM to vCPU ratio.

* **m2**, **m3**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements.

* **c3**: Configurations with a reduced GB RAM to vCPU ratio (2:1). These configurations can be useful for clusters with higher processor performance requirements.

* **b1**, **b2**, **b3**: Configurations with a guaranteed vCPU share under 100%. This class of hosts is intended for test load, with the minimum recommended host configuration for production solutions being 2 vCPUs with a guaranteed share of 50%.

  {% note info %}

  Hosts with a guaranteed vCPU share under 50% can't be used in multi-host clusters.

  {% endnote %}

