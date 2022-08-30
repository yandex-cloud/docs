## Аппаратные требования {#hardware}

Рекомендуемые аппаратные конфигурации для запуска контейнеров {{ sk-hybrid-name }}:

{% list tabs %}

- Контейнеры с GPU

   | Контейнер | CPU | GPU | RAM | HDD |
   |---|---|---|---|---|
   | Распознавание речи (80–100 каналов) | 16 ядер процессора [Intel Gold 6230R](https://ark.intel.com/content/www/ru/ru/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html) | Nvidia Tesla V100 (16 ГБ или 32 ГБ) | 128 ГБ | 300 ГБ |
   | Синтез речи (200 SPS^1^) | 16 ядер процессора Intel Gold 6230R | Nvidia Tesla V100 (16 ГБ или 32 ГБ) | 128 ГБ | 300 ГБ |

   ^1^ Seconds per second (SPS) — количество секунд синтезированного текста, которое генерируется за секунду работы.

{% endlist %}
