| Service                              | Price per hour, without VAT |
| ------------------------------------ | --------------------------- |
| Test execution, up to 50 hours       | {{ sku|USD|load_testing.test_execution.v1|string }} |
| Test execution starting at 50 hours  | {% calc [currency=USD] {{ sku|USD|load_testing.test_execution.v1|pricingRate.180000|number }} × 3600 %} |