{% list tabs %}

- За месяц работы хоста

  Из расчета 720 часов в месяц, округлено до целых рублей.
  
  Класс хостов | Цена за месяц | Цена с CVoS на 1 год | Цена с CVoS на 3 года
  ----- | ----- | ----- | -----
  **Intel Broadwell** | 
  {{ b1-nano }} | {{ sku|RUB|mdb.cluster.redis.b1.nano|month|int|string }} | — | — 
  {{ b1-small }} | {{ sku|RUB|mdb.cluster.redis.b1.small|month|int|string }} | — | — 
  {{ hm1-nano }} | {{ sku|RUB|mdb.cluster.redis.hm1.nano|month|int|string }} | — | — 
  {{ hm1-micro }} | {{ sku|RUB|mdb.cluster.redis.hm1.micro|month|int|string }} | — | — 
  {{ hm1-small }} | {{ sku|RUB|mdb.cluster.redis.hm1.small|month|int|string }} | — | — 
  {{ hm1-medium }} | {{ sku|RUB|mdb.cluster.redis.hm1.medium|month|int|string }} | — | — 
  {{ hm1-large }} | {{ sku|RUB|mdb.cluster.redis.hm1.large|month|int|string }} | — | — 
  {{ hm1-xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.xlarge|month|int|string }} | — | — 
  {{ hm1-2xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.2xlarge|month|int|string }} | — | — 
  {{ hm1-3xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.3xlarge|month|int|string }} | — | — 
  {{ hm1-4xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.4xlarge|month|int|string }} | — | — 
  {{ hm1-5xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.5xlarge|month|int|string }} | — | — 
  {{ hm1-6xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.6xlarge|month|int|string }} | — | — 
  {{ hm1-7xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.7xlarge|month|int|string }} | — | — 
  {{ hm1-8xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.8xlarge|month|int|string }} | — | — 
  {{ hm1-9xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.9xlarge|month|int|string }} | — | — 
  **Intel Cascade Lake** | 
  {{ b2-nano }} | {{ sku|RUB|mdb.cluster.redis.b2.nano|month|int|string }} | — | —
  {{ b2-medium }} | {{ sku|RUB|mdb.cluster.redis.b2.medium|month|int|string }} | — | — 
  {{ hm2-nano }} | {{ sku|RUB|mdb.cluster.redis.hm2.nano|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.nano|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.nano|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.nano|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.nano|cud.y3|month|discount|percent|string }})
  {{ hm2-micro }} | {{ sku|RUB|mdb.cluster.redis.hm2.micro|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.micro|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.micro|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.micro|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.micro|cud.y3|month|discount|percent|string }})
  {{ hm2-small }} | {{ sku|RUB|mdb.cluster.redis.hm2.small|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.small|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.small|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.small|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.small|cud.y3|month|discount|percent|string }})
  {{ hm2-medium }} | {{ sku|RUB|mdb.cluster.redis.hm2.medium|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.medium|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.medium|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.medium|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.medium|cud.y3|month|discount|percent|string }})
  {{ hm2-large }} | {{ sku|RUB|mdb.cluster.redis.hm2.large|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.large|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.large|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.large|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.large|cud.y3|month|discount|percent|string }})
  {{ hm2-xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-60xlarge }} | 16 632 ₽ | 10 973 ₽ (-34%) | 8 510 ₽ (-49%)
  {{ hm2-78xlarge }} | 20 261 ₽ | 13 306 ₽ (-34%) | 10 325 ₽ (-49%)
  {{ hm2-96xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.96xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.96xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.96xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.96xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.96xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-128xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.128xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.128xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.128xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.128xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.128xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-160xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.160xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.160xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.160xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.160xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.160xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-192xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.192xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.192xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.192xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.192xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.192xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-224xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.224xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.224xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.224xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.224xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.224xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-256xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.256xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.256xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.256xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.256xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.256xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-320xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.320xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.320xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.320xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.320xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.320xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-384xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.384xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.384xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.384xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.384xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.384xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-448xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.448xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.448xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.448xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.448xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.448xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-512xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.512xlarge|month|int|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.512xlarge|cud.y1|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.512xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.512xlarge|cud.y3|month|int|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.512xlarge|cud.y3|month|discount|percent|string }})

- За 1 час работы хоста

  Класс хостов | Цена за час | Цена с CVoS на 1 год | Цена с CVoS на 3 года
  ----- | ----- | ----- | -----
  **Intel Broadwell** | 
  {{ b1-nano }} | {{ sku|RUB|mdb.cluster.redis.b1.nano|string }} | — | — 
  {{ b1-small }} | {{ sku|RUB|mdb.cluster.redis.b1.small|string }} | — | — 
  {{ hm1-nano }} | {{ sku|RUB|mdb.cluster.redis.hm1.nano|string }} | — | — 
  {{ hm1-micro }} | {{ sku|RUB|mdb.cluster.redis.hm1.micro|string }} | — | — 
  {{ hm1-small }} | {{ sku|RUB|mdb.cluster.redis.hm1.small|string }} | — | — 
  {{ hm1-medium }} | {{ sku|RUB|mdb.cluster.redis.hm1.medium|string }} | — | — 
  {{ hm1-large }} | {{ sku|RUB|mdb.cluster.redis.hm1.large|string }} | — | — 
  {{ hm1-xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.xlarge|string }} | — | — 
  {{ hm1-2xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.2xlarge|string }} | — | — 
  {{ hm1-3xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.3xlarge|string }} | — | — 
  {{ hm1-4xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.4xlarge|string }} | — | — 
  {{ hm1-5xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.5xlarge|string }} | — | — 
  {{ hm1-6xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.6xlarge|string }} | — | — 
  {{ hm1-7xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.7xlarge|string }} | — | — 
  {{ hm1-8xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.8xlarge|string }} | — | — 
  {{ hm1-9xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm1.9xlarge|string }} | — | — 
  **Intel Cascade Lake** | 
  {{ b2-nano }} | {{ sku|RUB|mdb.cluster.redis.b2.nano|string }} | — | —
  {{ b2-medium }} | {{ sku|RUB|mdb.cluster.redis.b2.medium|string }} | — | — 
  {{ hm2-nano }} | {{ sku|RUB|mdb.cluster.redis.hm2.nano|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.nano|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.nano|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.nano|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.nano|cud.y3|discount|percent|string }})
  {{ hm2-micro }} | {{ sku|RUB|mdb.cluster.redis.hm2.micro|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.micro|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.micro|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.micro|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.micro|cud.y3|discount|percent|string }})
  {{ hm2-small }} | {{ sku|RUB|mdb.cluster.redis.hm2.small|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.small|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.small|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.small|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.small|cud.y3|discount|percent|string }})
  {{ hm2-medium }} | {{ sku|RUB|mdb.cluster.redis.hm2.medium|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.medium|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.medium|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.medium|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.medium|cud.y3|discount|percent|string }})
  {{ hm2-large }} | {{ sku|RUB|mdb.cluster.redis.hm2.large|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.large|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.large|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.large|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.large|cud.y3|discount|percent|string }})
  {{ hm2-xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.xlarge|cud.y3|discount|percent|string }})
  {{ hm2-60xlarge }} | 23,10 ₽ | 15,24 ₽ (-34%) | 11,82 ₽ (-49%)
  {{ hm2-78xlarge }} | 28,14 ₽ | 18,48 ₽ (-34%) | 14,34 ₽ (-49%)
  {{ hm2-96xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.96xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.96xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.96xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.96xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.96xlarge|cud.y3|discount|percent|string }})
  {{ hm2-128xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.128xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.128xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.128xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.128xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.128xlarge|cud.y3|discount|percent|string }})
  {{ hm2-160xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.160xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.160xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.160xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.160xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.160xlarge|cud.y3|discount|percent|string }})
  {{ hm2-192xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.192xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.192xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.192xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.192xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.192xlarge|cud.y3|discount|percent|string }})
  {{ hm2-224xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.224xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.224xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.224xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.224xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.224xlarge|cud.y3|discount|percent|string }})
  {{ hm2-256xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.256xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.256xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.256xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.256xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.256xlarge|cud.y3|discount|percent|string }})
  {{ hm2-320xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.320xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.320xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.320xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.320xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.320xlarge|cud.y3|discount|percent|string }})
  {{ hm2-384xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.384xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.384xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.384xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.384xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.384xlarge|cud.y3|discount|percent|string }})
  {{ hm2-448xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.448xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.448xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.448xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.448xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.448xlarge|cud.y3|discount|percent|string }})
  {{ hm2-512xlarge }} | {{ sku|RUB|mdb.cluster.redis.hm2.512xlarge|string }} | {{ sku|RUB|mdb.cluster.redis.hm2.512xlarge|cud.y1|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.512xlarge|cud.y1|discount|percent|string }}) | {{ sku|RUB|mdb.cluster.redis.hm2.512xlarge|cud.y3|string }} ({{ sku|RUB|mdb.cluster.redis.hm2.512xlarge|cud.y3|discount|percent|string }})

{% endlist %}
