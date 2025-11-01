{% list tabs %}

- Price per month

  Master type | Price per month, without VAT
  --- | ---
  Zonal | {{ sku|USD|mk8s.master.zonal.small|month|string }}
  Regional | {{ sku|USD|mk8s.master.regional.small|month|string }}

- Price per hour

  Master type | Price per hour, without VAT
  --- | ---
  Zonal | {{ sku|USD|mk8s.master.zonal.small|string }}
  Regional | {{ sku|USD|mk8s.master.regional.small|string }}

{% endlist %}