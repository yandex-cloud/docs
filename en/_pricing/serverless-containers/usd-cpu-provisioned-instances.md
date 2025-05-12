| Service | Price per vCPU per hour, <br>without VAT |
| ---- | ---- |
| CPU usage time during downtime of a provisioned instance | {{ sku|USD|serverless.containers.compute.provision_enabled.cpu|string }} |
| CPU usage time when processing queries in a provisioned instance | {{ sku|USD|serverless.containers.compute.provisioned_request.cpu|string }} |