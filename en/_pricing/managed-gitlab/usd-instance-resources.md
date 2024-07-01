| Resource | Rate for 1 hour | Rate for 1 month |
|--------|-------:|-------:|
| **Basic configuration/<br/>approval rules disabled** |
| 100% vCPU | {{ sku|USD|gitlab.instance.free.cpu|string }} | {{ sku|USD|gitlab.instance.free.cpu|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|gitlab.instance.free.ram|string }} | {{ sku|USD|gitlab.instance.free.ram|month|string }} |
| **Standard configuration** |
| 100% vCPU | {{ sku|USD|gitlab.instance.standard.cpu|string }} | {{ sku|USD|gitlab.instance.standard.cpu|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|gitlab.instance.standard.ram|string }} | {{ sku|USD|gitlab.instance.standard.ram|month|string }} |
| **Advanced configuration** |
| 100% vCPU | {{ sku|USD|gitlab.instance.advanced.cpu|string }} | {{ sku|USD|gitlab.instance.advanced.cpu|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|gitlab.instance.advanced.ram|string }} | {{ sku|USD|gitlab.instance.advanced.ram|month|string }} |
