Service | Price of scanning Docker image, without VAT
--- | ---
First-time scanning of Docker images for vulnerabilities, first six scans per month | {{ sku|USD|cr.vulnerabilityscanner.scan.v1|string }}
First-time scanning of Docker images for vulnerabilities, over six scans per month | {{ sku|USD|cr.vulnerabilityscanner.scan.v1|pricingRate.6|string }}
Subsequent scanning of Docker images for vulnerabilities, first six scans per month | {{ sku|USD|cr.vulnerabilityscanner.rescan.v1|string }}
Subsequent scanning of Docker images for vulnerabilities, over six scans per month | {{ sku|USD|cr.vulnerabilityscanner.rescan.v1|pricingRate.6|string }}

