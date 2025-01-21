| Конфигурация | Потребление в юнитах<br> за 1 секунду<br> работы конфигурации | Цена за 1 час <br>вычислений, <br>вкл. НДС |
|:---|:---:|:---:|
| c1.4 (4 vCPU, 0 GPU) | 4 | {% calc [currency=KZT] 4 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
| c1.8 (8 vCPU, 0 GPU) | 8 | {% calc [currency=KZT] 8 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
| c1.32 (32 vCPU, 0 GPU) | 32 | {% calc [currency=KZT] 32 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
| c1.80 (80 vCPU, 0 GPU) | 80 | {% calc [currency=KZT] 80 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
| g1.1 (8 vCPU, 1 GPU V100) | 72 | {% calc [currency=KZT] 72 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
| g1.2 (16 vCPU, 2 GPU V100) | 144 | {% calc [currency=KZT] 144 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %}|
| g1.4 (32 vCPU, 4 GPU V100) | 288 | {% calc [currency=KZT] 288 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
| g2.1 (28 vCPU, 1 GPU A100) | 116 | {% calc [currency=KZT] 116 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
| g2.2 (56 vCPU, 2 GPU A100) | 232 | {% calc [currency=KZT] 232 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
| g2.4 (112 vCPU, 4 GPU A100) | 464 | {% calc [currency=KZT] 464 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
| g2.8 (224 vCPU, 8 GPU A100) | 928 | {% calc [currency=KZT] 928 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
| gt4.1 (4 vCPU, 1 GPU T4) | 36 | {% calc [currency=KZT] 36 × 3600 × {{ sku|KZT|ai.datasphere.computing.v1|number }} %} |
