## Аппаратные требования {#hardware}

Рекомендуемые аппаратные конфигурации для запуска контейнеров {{ sk-hybrid-name }}:

{% list tabs %}

- Контейнеры с CPU

   | Контейнер | CPU | RAM | HDD |
   |---|---|---|---|
   | Распознавание речи (40 каналов) | 2 процессора [Intel Gold 6230R](https://ark.intel.com/content/www/ru/ru/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html) | 128 ГБ | 300 ГБ |
   | Синтез речи (10–16 SPS^1^) | 1 процессор Intel Gold 6230R | 64 ГБ | 300 ГБ |

   ^1^ Seconds per second (SPS) — количество секунд синтезированного текста, которое генерируется за секунду работы.

{% endlist %}
