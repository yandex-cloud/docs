Configuration types:

* **s1, s2**: Standard configurations with 4:1 RAM GB to vCPU ratio.
* **m1, m2**: Configurations with an increased RAM GB to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements.
* **b1, b2**: Configurations with a guaranteed vCPU share under 100%. This host class is intended for test load, while the minimum recommended host configuration for production solutions is 2 vCPUs with a guaranteed share of 50%.

  {% note info %}

  Hosts with a guaranteed vCPU share under 100% cannot be used in multi-host clusters.

  {% endnote %}
