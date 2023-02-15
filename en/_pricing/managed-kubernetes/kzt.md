{% list tabs %}

* Master, monthly billing

   | Master type | Cost per month, including VAT |
   --- | ---
   | Zonal | {{ sku|KZT|mk8s.master.zonal.small|month|int|string }} |
   | Regional | {{ sku|KZT|mk8s.master.regional.small|month|int|string }} |

* Hourly rates

   | Master type | Cost per hour, including VAT |
   --- | ---
   | Zonal | {{ sku|KZT|mk8s.master.zonal.small|string }} |
   | Regional | {{ sku|KZT|mk8s.master.regional.small|string }} |

{% endlist %}