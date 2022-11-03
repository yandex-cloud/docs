{% list tabs %}

- Rate for 1 month

  Master type | Rate for 1 month, with VAT
  --- | ---
  Zonal | {{ sku|ILS|mk8s.master.zonal.small|month|string }}
  Regional | {{ sku|ILS|mk8s.master.regional.small|month|string }}

- Rate for 1 hour

  Master type | Rate for 1 hour, with VAT
  --- | ---
  Zonal | {{ sku|ILS|mk8s.master.zonal.small|string }}
  Regional | {{ sku|ILS|mk8s.master.regional.small|string }}

{% endlist %}