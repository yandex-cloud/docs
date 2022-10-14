## Аппаратные требования {#hardware}

Рекомендуемые аппаратные конфигурации для запуска контейнеров {{ sk-hybrid-name }}:

{% list tabs %}

- Контейнеры с GPU T4

   | Контейнер | CPU | GPU | RAM | HDD |
   |---|---|---|---|---|
   | Распознавание речи (20–30 каналов) | 8 ядер процессора [Intel Gold 6230R]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html){% endif %} | Nvidia Tesla T4 (16 ГБ или 32 ГБ) | 64 ГБ | 200 ГБ |
   | Синтез речи (80 SPS^1^) | 8 ядер процессора Intel Gold 6230R | Nvidia Tesla T4 (16 ГБ или 32 ГБ) | 64 ГБ | 200 ГБ |

- Контейнеры с GPU V100

   | Контейнер | CPU | GPU | RAM | HDD |
   |---|---|---|---|---|
   | Распознавание речи (80–100 каналов) | 16 ядер процессора [Intel Gold 6230R]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html){% endif %} | Nvidia Tesla V100 (16 ГБ или 32 ГБ) | 128 ГБ | 300 ГБ |
   | Синтез речи (200 SPS^1^) | 16 ядер процессора Intel Gold 6230R | Nvidia Tesla V100 (16 ГБ или 32 ГБ) | 128 ГБ | 300 ГБ |

{% endlist %}

^1^ Seconds per second (SPS) — количество секунд синтезированного текста, которое генерируется за секунду работы.