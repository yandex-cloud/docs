| Service | Cost, including VAT |
| --- | --- |
| **Standard storage** |
| 10000 PUT or POST operations or less per month | {{ sku|ILS|storage.api.put.standard|string }} |
| The first 10000 POST operations per month | {{ sku|ILS|storage.api.post.standard|string }} |
| The first 100000 GET operations per month | {{ sku|ILS|storage.api.get.standard|string }} |
| 100000 HEAD operations or less per month | {{ sku|ILS|storage.api.head.standard|string }} |
| 1000 PUT operations | {{ sku|ILS|storage.api.put.standard|pricingRate.10|string }} |
| 1000 POST operations | {{ sku|ILS|storage.api.post.standard|pricingRate.10|string }} |
| 10000 GET operations | {{ sku|ILS|storage.api.get.standard|pricingRate.10|string }} |
| 10000 HEAD operations | {{ sku|ILS|storage.api.head.standard|pricingRate.10|string }} |
| **Cold storage** |
| 1000 PUT operations | {{ sku|ILS|storage.api.put.cold|string }} |
| 1000 POST operations | {{ sku|ILS|storage.api.post.cold|string }} |
| 10000 GET operations | {{ sku|ILS|storage.api.get.cold|string }} |
| 10000 HEAD operations | {{ sku|ILS|storage.api.head.cold|string }} |
| **Ice storage** |
| 1000 PUT operations | {{ sku|ILS|storage.api.put.ice|string }} |
| 1000 POST operations | {{ sku|ILS|storage.api.post.ice|string }} |
| 10000 GET operations | {{ sku|ILS|storage.api.get.ice|string }} |
| 10000 HEAD operations | {{ sku|ILS|storage.api.head.ice|string }} |