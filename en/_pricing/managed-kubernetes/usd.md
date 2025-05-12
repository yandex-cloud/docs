{% list tabs %}

- Cost per month

   | Master type | Price per month, without VAT |
   --- | ---
   | Zonal | {{ sku|USD|mk8s.master.zonal.small|month|string }} |
   | Regional | {{ sku|USD|mk8s.master.regional.small|month|string }} |

- Cost per hour

   | Master type | Price per hour, without VAT |
   --- | ---
   | Zonal | {{ sku|USD|mk8s.master.zonal.small|string }} |
   | Regional | {{ sku|USD|mk8s.master.regional.small|string }} |

{% endlist %}