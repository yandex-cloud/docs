Configuration types:

* **s1, s2**: Standard configurations with a GB RAM to vCPU ratio of 4:1.
* **m1, m2**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations are well suited for clusters with high cache requirements.
* **b1, b2**: Configurations with a guaranteed vCPU share under 100%. This host class is intended for test workloads. The minimum recommended host configuration for production solutions is two vCPUs with a guaranteed share of 50%.

  {% note info %}

  Hosts with a guaranteed vCPU share under 100% cannot be used in multi-host clusters.

  {% endnote %}
