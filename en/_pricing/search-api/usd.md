| Service | Price per 1,000 requests,<br/>without VAT |
|---------|-------------------------------------|
| Daytime synchronous requests      | {{ sku|USD|searchapi.requests.sync.v3|string }} |
| Daytime deferred requests    	    | {{ sku|USD|searchapi.requests.async.v3|string }} |
| Night-time synchronous requests   | {{ sku|USD|searchapi.requests.night.sync.v3|string }} |
| Night-time deferred requests      | {{ sku|USD|searchapi.requests.night.async.v3|string }} |
| Image search requests             | {{ sku|USD|searchapi.requests.image.sync.v3|string }} |
| Synchronous requests with [generative response](../../search-api/concepts/generative-response.md) | {% calc [currency=USD] {{ sku|USD|searchapi.generative.requests.v3|number }} × 1000 %} |