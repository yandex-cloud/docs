| Service                   | Price per hour, without VAT |
| ------------------------- | -------------------------- |
| Tests, up to 50 hours     | {{ sku|USD|load_testing.test_execution.v1|string }} |
| Tests, 50 hours or longer | {% calc [currency=USD] {{ sku|USD|load_testing.test_execution.v1|pricingRate.180000|number }} × 3600 %} |