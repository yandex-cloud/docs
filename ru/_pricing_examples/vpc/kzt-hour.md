> {{ sku|KZT|network.public_fips|string }} + {{ sku|KZT|network.public_fips.deallocated|string }} = {% calc [currency=KZT] {{ sku|KZT|network.public_fips|number }} + {{ sku|KZT|network.public_fips.deallocated|number }} %}
> 
> Итого: {% calc [currency=KZT] {{ sku|KZT|network.public_fips|number }} + {{ sku|KZT|network.public_fips.deallocated|number }} %} за час.

Где:

* {{ sku|KZT|network.public_fips|string }} — стоимость часа использования публичного IP-адреса.
* {{ sku|KZT|network.public_fips.deallocated|string }} — стоимость часа резервирования неактивного публичного статического IP-адреса.