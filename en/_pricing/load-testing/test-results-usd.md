| Service                                                | Price per month, without VAT |
| ------------------------------------------------------ | ---------------------------- |
| Storage of results, up to 600 hours of test time       | {{ sku|USD|load_testing.storage.test_results.v1|string }} |
| Storing results starting from 600 hours of test time   | {% calc [currency=USD] {{ sku|USD|load_testing.storage.test_results.v1|pricingRate.2160000|number }} × 3600 %} |