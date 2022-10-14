## Hardware requirements {#hardware}

Recommended hardware configurations to run {{ sk-hybrid-name }} containers:

{% list tabs %}

- Containers with GPU V100

   | Container | CPU | GPU | RAM | HDD |
   |---|---|---|---|---|
   | Speech recognition (80-100 channels) | 16 [Intel Gold 6230R](https://ark.intel.com/content/www/us/en/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html) cores | Nvidia Tesla V100 (16 or 32 GB) | 128 GB | 300 GB |
   | Speech synthesis (200 SPS^1^) | 16 Intel Gold 6230R cores | Nvidia Tesla V100 (16 or 32 GB) | 128 GB | 300 GB |

- Containers with GPU T4

   | Container | CPU | GPU | RAM | HDD |
   |---|---|---|---|---|
   | Speech recognition (20–30 channels) | 8 [Intel Gold 6230R](https://ark.intel.com/content/www/us/en/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html) cores | Nvidia Tesla T4 (16 or 32 GB) | 64 GB | 200 GB |
   | Speech synthesis (80 SPS^1^) | 8 cores of the Intel Gold 6230R CPU | Nvidia Tesla T4 (16 or 32 GB) | 64 GB | 200 GB |

{% endlist %}

^1^ Seconds per second (SPS): The number of seconds of synthesized text generated per runtime second.
