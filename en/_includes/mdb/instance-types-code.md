Configuration types:

* **s1, s2**: Standard configurations, with 1:4 vCPU to GB RAM ratio.

* **m1, m2**: Configurations with a decreased vCPU to GB RAM ratio (1:8 vs. 1:4 for standard classes). These configurations can be useful for clusters with increased cache requirements.

* **b1, b2**: Configurations with a guaranteed vCPU share under 100%. This class of hosts is intended for test load, with the minimum recommended host configuration for production solutions being 2 vCPUs with a guaranteed share of 50%.

  {% note info %}

  Hosts with a guaranteed vCPU share under 50% can't be used in multi-host clusters.

  {% endnote %}

