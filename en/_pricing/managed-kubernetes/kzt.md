{% list tabs %}

* Rate for 1 month

  Master type | Rate for 1 month, without VAT
  --- | ---
  Zonal | {{ sku|KZT|mk8s.master.zonal.small|month|string }}
  Regional | {{ sku|KZT|mk8s.master.regional.small|month|string }}

* Rate for 1 hour

  Master type | Rate for 1 hour, without VAT
  --- | ---
  Zonal | {{ sku|KZT|mk8s.master.zonal.small|string }}
  Regional | {{ sku|KZT|mk8s.master.regional.small|string }}

{% endlist %}