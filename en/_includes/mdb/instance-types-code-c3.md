Configuration types:

* **s2**, **s3**, **s4a**, **s4af**: Standard configurations with a GB RAM to vCPU ratio of 4:1.
* **m2**, **m3**, **m4a**, **m4af**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations are well suited for clusters with high cache requirements.
* **c3**, **c4a**, **c4af**: Configurations with a reduced GB RAM to vCPU ratio (2:1). These configurations may be useful for clusters with higher processor performance requirements.
* **b2**: Configurations with a guaranteed vCPU share below 100%. This host class is intended for test load, while the minimum recommended host configuration for production solutions is two vCPUs with a guaranteed share of 100%.


Hosts with a guaranteed vCPU share under 50% cannot be used in multi-host clusters.