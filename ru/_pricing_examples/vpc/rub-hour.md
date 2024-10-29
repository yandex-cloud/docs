> {{ sku|RUB|network.public_fips|string }} + {{ sku|RUB|network.public_fips.deallocated|string }} = {% calc [currency=RUB] {{ sku|RUB|network.public_fips|number }} + {{ sku|RUB|network.public_fips.deallocated|number }} %}
> 
> Итого: {% calc [currency=RUB] {{ sku|RUB|network.public_fips|number }} + {{ sku|RUB|network.public_fips.deallocated|number }} %} за час.

Где:

* {{ sku|RUB|network.public_fips|string }} — стоимость часа использования публичного IP-адреса.
* {{ sku|RUB|network.public_fips.deallocated|string }} — стоимость часа резервирования неактивного публичного статического IP-адреса.