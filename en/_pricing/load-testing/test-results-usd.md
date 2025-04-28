| Service                                            | Cost per month, without VAT |
| ---------------------------------------------------| ----------------------------|
| Storing results, up to 600 hours of test runtime   | {{ sku|USD|load_testing.storage.test_results.v1|string }} |
| Storing results, 600 hours of test runtime or more | {% calc [currency=USD] {{ sku|USD|load_testing.storage.test_results.v1|pricingRate.2160000|number }} × 3600 %} |