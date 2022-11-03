{% list tabs %}

* Rate for custom DNS zone per month

  | Resource category | Rate for 1 month, with VAT |
  | --- | --- |
  | DNS zone | {{ sku|ILS|dns.zones.v1|month|string }} \* |

  \* For reference only. Assuming a 720-hour (30-day) month. Rounded to 4 decimal places. Hourly price is used in billing calculations.

* Rate for custom DNS zone per hour

  | Resource category | Rate for 1 hour, with VAT |
  | --- | --- |
  | DNS zone | {{ sku|ILS|dns.zones.v1|string }} |

{% endlist %}