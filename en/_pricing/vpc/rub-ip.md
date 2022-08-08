| Service | Rate for 1 hour |
| ----- | ----- |
| Public IP address | {{ sku|RUB|network.public_fips|string }} |
| Reserving an inactive public static IP address | {{ sku|RUB|network.public_fips.deallocated|string }} |