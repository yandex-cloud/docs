Service | Price of scanning Docker image, without VAT
--- | ---
First-time scan, first six scans of different Docker images, per month | {{ sku|USD|cr.vulnerabilityscanner.scan.v1|string }}
First-time scan, over six scans per month | {{ sku|USD|cr.vulnerabilityscanner.scan.v1|pricingRate.6|string }}
Further scans, first six scans of any Docker images, per month | {{ sku|USD|cr.vulnerabilityscanner.rescan.v1|string }}
Further scans, over six scans per month | {{ sku|USD|cr.vulnerabilityscanner.rescan.v1|pricingRate.6|string }}