{% list tabs %}

* Master, monthly billing

   | Master type | Cost per month, including VAT |
   --- | ---
   | Zonal | {{ sku|RUB|mk8s.master.zonal.small|month|string }} |
   | Regional | {{ sku|RUB|mk8s.master.regional.small|month|string }} |

* Hourly rates

   | Master type | Cost per hour, including VAT |
   --- | ---
   | Zonal | {{ sku|RUB|mk8s.master.zonal.small|string }} |
   | Regional | {{ sku|RUB|mk8s.master.regional.small|string }} |

{% endlist %}