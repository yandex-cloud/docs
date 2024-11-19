> (50 / 40) = 2

Where:

* 50: Size of one message in KB.
* 40: [Size of units](#event) of written data in KB.
* 2: Number of data units written per message.

While calculating the cost, the number of units of written data is rounded up to an integer. In this example, the number is rounded to 2.

> 2 × 2 = 4

Where:

* 2: Number of messages per second.
* 2: Number of data units written per message.
* 4: Number of data units written per second.

> 4 × 60 × 60 × 24 × 31 = 10,713,600

Where:

* 4: Number of data units written per second.
* 60 × 60 × 24 × 31: Number of seconds in the month.
* 10,713,600: Number of data units written per month.

> {{ sku|USD|yds.reserved_resources.128k.12h|string }} × 24 × 31 = {% calc [currency=USD] {{ sku|USD|yds.reserved_resources.128k.12h|number }} × 24 × 31 %}

Where:

* {{ sku|USD|yds.reserved_resources.128k.12h|string }}: Cost of allocated resources per hour when stored for 12 hours.
* 24: Number of data storage hours.
* 31: Number of days in a month.
* {% calc [currency=USD] {{ sku|USD|yds.reserved_resources.128k.12h|number }} × 24 × 31 %}: Cost of allocated resources per month with a maximum data write speed of 128 KB/s and a storage period of 24 hours, without VAT.

> (10,713,600 - 2,000,000) / 1,000,000 × {{ sku|USD|yds.events.puts|pricingRate.2|string }} + {% calc [currency=USD] {{ sku|USD|yds.reserved_resources.128k.12h|number }} × 24 × 31 %} = {% calc [currency=USD] (10713600 - 2000000) / 1000000 × {{ sku|USD|yds.events.puts|pricingRate.2|number }} + {{ sku|USD|yds.reserved_resources.128k.12h|number }} × 24 × 31 %}

Where:

* 10,713,600: Number of data units written per month.
* 2,000,000: Number of free units per month.
* {{ sku|USD|yds.events.puts|pricingRate.2|string }}: Cost of 1 million units of written data, without VAT.
* {% calc [currency=USD] {{ sku|USD|yds.reserved_resources.128k.12h|number }} × 24 × 31 %}: Cost of allocated resources per month with a maximum data write speed of 128 KB/s and a storage period of 24 hours, without VAT.

Total: {% calc [currency=USD] (10713600 - 2000000) / 1000000 × {{ sku|USD|yds.events.puts|pricingRate.2|number }} + {{ sku|USD|yds.reserved_resources.128k.12h|number }} × 24 × 31 %}, without VAT.
