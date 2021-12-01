{% list tabs %}

- Rate for 1 month, without VAT

  Host class | Rate for month | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Broadwell** | 
  {{ b1-nano }} | {{ sku|USD|mdb.cluster.redis.b1.nano|month|int|string }} | — | — 
  {{ b1-small }} | {{ sku|USD|mdb.cluster.redis.b1.small|month|int|string }} | — | — 
  {{ hm1-nano }} | {{ sku|USD|mdb.cluster.redis.hm1.nano|month|int|string }} | — | — 
  {{ hm1-micro }} | {{ sku|USD|mdb.cluster.redis.hm1.micro|month|int|string }} | — | — 
  {{ hm1-small }} | {{ sku|USD|mdb.cluster.redis.hm1.small|month|int|string }} | — | — 
  {{ hm1-medium }} | {{ sku|USD|mdb.cluster.redis.hm1.medium|month|int|string }} | — | — 
  {{ hm1-large }} | {{ sku|USD|mdb.cluster.redis.hm1.large|month|int|string }} | — | — 
  {{ hm1-xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.xlarge|month|int|string }} | — | — 
  {{ hm1-2xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.2xlarge|month|int|string }} | — | — 
  {{ hm1-3xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.3xlarge|month|int|string }} | — | — 
  {{ hm1-4xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.4xlarge|month|int|string }} | — | — 
  {{ hm1-5xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.5xlarge|month|int|string }} | — | — 
  {{ hm1-6xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.6xlarge|month|int|string }} | — | — 
  {{ hm1-7xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.7xlarge|month|int|string }} | — | — 
  {{ hm1-8xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.8xlarge|month|int|string }} | — | — 
  {{ hm1-9xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.9xlarge|month|int|string }} | — | — 
  **Intel Cascade Lake** | 
  {{ b2-nano }} | {{ sku|USD|mdb.cluster.redis.b2.nano|month|int|string }} | — | —
  {{ b2-medium }} | {{ sku|USD|mdb.cluster.redis.b2.medium|month|int|string }} | — | — 
  {{ hm2-nano }} | {{ sku|USD|mdb.cluster.redis.hm2.nano|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.nano|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.nano|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.nano|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.nano|cud.y3|month|discount|percent|string }})
  {{ hm2-micro }} | {{ sku|USD|mdb.cluster.redis.hm2.micro|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.micro|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.micro|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.micro|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.micro|cud.y3|month|discount|percent|string }})
  {{ hm2-small }} | {{ sku|USD|mdb.cluster.redis.hm2.small|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.small|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.small|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.small|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.small|cud.y3|month|discount|percent|string }})
  {{ hm2-medium }} | {{ sku|USD|mdb.cluster.redis.hm2.medium|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.medium|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.medium|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.medium|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.medium|cud.y3|month|discount|percent|string }})
  {{ hm2-large }} | {{ sku|USD|mdb.cluster.redis.hm2.large|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.large|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.large|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.large|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.large|cud.y3|month|discount|percent|string }})
  {{ hm2-xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-96xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.96xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.96xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.96xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.96xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.96xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-128xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.128xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.128xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.128xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.128xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.128xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-160xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.160xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.160xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.160xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.160xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.160xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-192xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.192xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.192xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.192xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.192xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.192xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-224xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.224xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.224xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.224xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.224xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.224xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-256xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.256xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.256xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.256xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.256xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.256xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-320xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.320xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.320xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.320xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.320xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.320xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-384xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.384xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.384xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.384xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.384xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.384xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-448xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.448xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.448xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.448xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.448xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.448xlarge|cud.y3|month|discount|percent|string }})
  {{ hm2-512xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.512xlarge|month|int|string }} | {{ sku|USD|mdb.cluster.redis.hm2.512xlarge|cud.y1|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.512xlarge|cud.y1|month|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.512xlarge|cud.y3|month|int|string }} ({{ sku|USD|mdb.cluster.redis.hm2.512xlarge|cud.y3|month|discount|percent|string }})

- Rate for 1 hour, without VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Broadwell** | 
  {{ b1-nano }} | {{ sku|USD|mdb.cluster.redis.b1.nano|string }} | — | — 
  {{ b1-small }} | {{ sku|USD|mdb.cluster.redis.b1.small|string }} | — | — 
  {{ hm1-nano }} | {{ sku|USD|mdb.cluster.redis.hm1.nano|string }} | — | — 
  {{ hm1-micro }} | {{ sku|USD|mdb.cluster.redis.hm1.micro|string }} | — | — 
  {{ hm1-small }} | {{ sku|USD|mdb.cluster.redis.hm1.small|string }} | — | — 
  {{ hm1-medium }} | {{ sku|USD|mdb.cluster.redis.hm1.medium|string }} | — | — 
  {{ hm1-large }} | {{ sku|USD|mdb.cluster.redis.hm1.large|string }} | — | — 
  {{ hm1-xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.xlarge|string }} | — | — 
  {{ hm1-2xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.2xlarge|string }} | — | — 
  {{ hm1-3xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.3xlarge|string }} | — | — 
  {{ hm1-4xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.4xlarge|string }} | — | — 
  {{ hm1-5xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.5xlarge|string }} | — | — 
  {{ hm1-6xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.6xlarge|string }} | — | — 
  {{ hm1-7xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.7xlarge|string }} | — | — 
  {{ hm1-8xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.8xlarge|string }} | — | — 
  {{ hm1-9xlarge }} | {{ sku|USD|mdb.cluster.redis.hm1.9xlarge|string }} | — | — 
  **Intel Cascade Lake** | 
  {{ b2-nano }} | {{ sku|USD|mdb.cluster.redis.b2.nano|string }} | — | —
  {{ b2-medium }} | {{ sku|USD|mdb.cluster.redis.b2.medium|string }} | — | — 
  {{ hm2-nano }} | {{ sku|USD|mdb.cluster.redis.hm2.nano|string }} | {{ sku|USD|mdb.cluster.redis.hm2.nano|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.nano|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.nano|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.nano|cud.y3|discount|percent|string }})
  {{ hm2-micro }} | {{ sku|USD|mdb.cluster.redis.hm2.micro|string }} | {{ sku|USD|mdb.cluster.redis.hm2.micro|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.micro|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.micro|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.micro|cud.y3|discount|percent|string }})
  {{ hm2-small }} | {{ sku|USD|mdb.cluster.redis.hm2.small|string }} | {{ sku|USD|mdb.cluster.redis.hm2.small|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.small|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.small|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.small|cud.y3|discount|percent|string }})
  {{ hm2-medium }} | {{ sku|USD|mdb.cluster.redis.hm2.medium|string }} | {{ sku|USD|mdb.cluster.redis.hm2.medium|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.medium|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.medium|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.medium|cud.y3|discount|percent|string }})
  {{ hm2-large }} | {{ sku|USD|mdb.cluster.redis.hm2.large|string }} | {{ sku|USD|mdb.cluster.redis.hm2.large|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.large|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.large|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.large|cud.y3|discount|percent|string }})
  {{ hm2-xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.xlarge|cud.y3|discount|percent|string }})
  {{ hm2-96xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.96xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.96xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.96xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.96xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.96xlarge|cud.y3|discount|percent|string }})
  {{ hm2-128xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.128xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.128xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.128xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.128xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.128xlarge|cud.y3|discount|percent|string }})
  {{ hm2-160xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.160xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.160xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.160xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.160xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.160xlarge|cud.y3|discount|percent|string }})
  {{ hm2-192xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.192xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.192xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.192xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.192xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.192xlarge|cud.y3|discount|percent|string }})
  {{ hm2-224xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.224xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.224xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.224xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.224xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.224xlarge|cud.y3|discount|percent|string }})
  {{ hm2-256xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.256xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.256xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.256xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.256xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.256xlarge|cud.y3|discount|percent|string }})
  {{ hm2-320xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.320xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.320xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.320xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.320xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.320xlarge|cud.y3|discount|percent|string }})
  {{ hm2-384xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.384xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.384xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.384xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.384xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.384xlarge|cud.y3|discount|percent|string }})
  {{ hm2-448xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.448xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.448xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.448xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.448xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.448xlarge|cud.y3|discount|percent|string }})
  {{ hm2-512xlarge }} | {{ sku|USD|mdb.cluster.redis.hm2.512xlarge|string }} | {{ sku|USD|mdb.cluster.redis.hm2.512xlarge|cud.y1|string }} ({{ sku|USD|mdb.cluster.redis.hm2.512xlarge|cud.y1|discount|percent|string }}) | {{ sku|USD|mdb.cluster.redis.hm2.512xlarge|cud.y3|string }} ({{ sku|USD|mdb.cluster.redis.hm2.512xlarge|cud.y3|discount|percent|string }})

{% endlist %}
