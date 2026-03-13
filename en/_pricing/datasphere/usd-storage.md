| Resource | Price per GB, per month,<br> without VAT |
| --- | --- |
| Project storage size, up to 10 GB | Free of charge |
| Project storage size, over 10 GB | {% calc [currency=USD] 0.003829269547325 × 2592000 × {{ sku|USD|ai.datasphere.disk.v1|number }} %} |
| Node instance disk | {% calc [currency=USD] 0.003829269547325 × 2592000 × {{ sku|USD|ai.datasphere.deployment|number }} %} |
| Datasets | {% calc [currency=USD] 0.003829269547325 × 2592000 × {{ sku|USD|ai.datasphere.datasets.v1|number }} %} |
| File storage | {% calc [currency=USD] 0.004403452932099 × 2592000 × {{ sku|USD|datasphere.filestores|number }} %} |
| Model | {% calc [currency=USD] 0.003829269547325 × 2592000 × {{ sku|USD|ai.datasphere.models.v1|number }} %} |
| Docker image | {% calc [currency=USD] 0.003829269547325 × 2592000 × {{ sku|USD|datasphere.docker|number }} %} |
| {{ ds-jobs }} data | {% calc [currency=USD] 0.003829269547325 × 2592000 × {{ sku|USD|ai.datasphere.jobs|number }} %} |