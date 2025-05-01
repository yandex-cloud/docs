| Service | Price per hour,<br>without VAT |
| ----- | ----- |
| Public IP address | {{ sku|USD|network.public_fips|string }} |
| Reserving an inactive public static IP address | {{ sku|USD|network.public_fips.deallocated|string }} |
