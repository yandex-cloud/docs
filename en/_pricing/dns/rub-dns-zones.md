{% list tabs %}

* For 1 custom DNS zone per month

   | Resource category | Cost per month, including VAT |
   | --- | --- |
   | DNS zone | {{ sku|RUB|dns.zones.v1|month|string }} \* |

   \* For reference only. Assuming a 720-hour (30-day) month. The value is rounded. The cost per hour is used in billing calculations.

* For 1 custom DNS zone per day

   | Resource category | Cost per hour, including VAT |
   | --- | --- |
   | DNS zone | {{ sku|RUB|dns.zones.v1|string }} |

{% endlist %}