## Hardware requirements {#hardware}

Recommended hardware configurations to run {{ sk-hybrid-name }} containers:

{% list tabs %}

- Containers with CPUs

   | Container | CPU | RAM | HDD |
   |---|---|---|---|
   | Speech recognition (40 channels) | Two [Intel® Xeon® Gold 6230R](https://ark.intel.com/content/www/us/en/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html) CPUs | 128 GB | 300 GB |
   | Speech synthesis (10-16 SPS^1^) | One Intel® Xeon® Gold 6230R CPU | 64 GB | 300 GB |

   ^1^ Seconds per second (SPS): Number of seconds of synthesized text generated per runtime second.

{% endlist %}
