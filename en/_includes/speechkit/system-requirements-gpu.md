## Hardware requirements {#hardware}

Recommended hardware requirements for running {{ sk-hybrid-name }} containers:
* CPU: 8 [Intel Gold 6230R]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html){% endif %} cores.
* GPU: Nvidia Tesla T4 or Nvidia Tesla V100 (16 GB or 32 GB).
* RAM: 64 GB.
* HDD: 200 GB.

{{ sk-hybrid-name }} characteristics are estimated approximately and may change after containers are updated and new functions appear.

{% list tabs %}

- Containers with GPU T4

   | Supported languages | Operation mode | The number of<br>simultaneous<br>connections | SPS^1^ |
   |---|---|---|---|
   | **Speech recognition** |
   | Multi-language model | Streaming recognition | 13–18 | 13 |
   | Multi-language model | Audio file recognition | — | 324 |
   | Russian only | Streaming recognition | 27 | 14 |
   | Russian only | Audio file recognition | — | 369 |
   | **Speech synthesis** |
   | Russian only | — | — | 80 |
   | Any other language  | — | — | 64 |

- Containers with GPU V100

   | Supported languages | Operation mode | The number of<br>simultaneous<br>connections | SPS^1^ |
   |---|---|---|---|
   | **Speech recognition** |
   | Multi-language model | Streaming recognition | 27–31 | 22 |
   | Multi-language model | Audio file recognition | — | 360 |
   | Russian only | Streaming recognition | 49 | 34 |
   | Russian only | Audio file recognition | — | 378 |
   | **Speech synthesis** |
   | Russian only | — | — | 200 |
   | Any other language  | — | — | 160 |

{% endlist %}

^1^ Seconds per second (SPS): The number of seconds of synthesized text generated per runtime second.