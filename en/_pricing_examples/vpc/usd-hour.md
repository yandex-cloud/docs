> {{ sku|USD|network.public_fips|string }} + {{ sku|USD|network.public_fips.deallocated|string }} = {% calc [currency=USD] {{ sku|USD|network.public_fips|number }} + {{ sku|USD|network.public_fips.deallocated|number }} %}
>
> Total: {% calc [currency=USD] {{ sku|USD|network.public_fips|number }} + {{ sku|USD|network.public_fips.deallocated|number }} %} per hour.

Where:

* {{ sku|USD|network.public_fips|string }}: Cost of using a public IP address per hour.
* {{ sku|USD|network.public_fips.deallocated|string }}: Cost of reserving an inactive public static IP address per hour.