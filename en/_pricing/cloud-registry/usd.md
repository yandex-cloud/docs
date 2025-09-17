Service | Price of 1 GB per month, without VAT
--- | ---
Storage, the first 1 GB per month | {{ sku|USD|cloud_registry.used_space.v1|month|string }}
Storage, over 1 GB per month | {{ sku|USD|cloud_registry.used_space.v1|pricingRate.720|month|string }}
