## Hardware requirements {#hardware}

Recommended hardware requirements for running {{ sk-hybrid-name }} containers:
* CPU: 8 [Intel Gold 6230R](https://ark.intel.com/content/www/us/en/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html) cores. When using Nvidia Tesla A100, 14 CPU cores are required.
* GPU: Nvidia Tesla T4, Nvidia Tesla V100, or Nvidia Tesla A100 (16 GB or 32 GB).

{{ sk-hybrid-name }} specifications are estimated approximately and may change after containers are updated and new features are added.

The data in the tables is for the Russian language only:

{% list tabs %}

- Containers with GPU T4

   | Operation mode | Guaranteed<br>SPS^1^ | RAM per card, <br>GB | HDD per card, <br>GB | Intel Gold 6230R<br>physical<br>cores <br>per card | Intel Gold 6230R <br>logical cores <br>per card |
   |---|---|---|---|---|---|
   | **Speech recognition** |
   | Streaming recognition | 50 | 64 | 200 | 8 | 16 |
   | Audio file recognition | 250 | 250 | 200 | 8 | 16 |
   | **Speech synthesis** |
   | Speech synthesis | 80 | 80 | 200 | 8 | 16 |

- Containers with GPU V100

   | Operation mode | Guaranteed<br>SPS^1^ | RAM per card, <br>GB | HDD per card, <br>GB | Intel Gold 6230R<br>physical<br>cores <br>per card | Intel Gold 6230R <br>logical cores <br>per card |
   |---|---|---|---|---|---|
   | **Speech recognition** |
   | Streaming recognition | 110 | 64 | 200 | 8 | 16 |
   | Audio file recognition | 500 | 500 | 200 | 8 | 16 |
   | **Speech synthesis** |
   | Speech synthesis | 200 | 200 | 200 | 8 | 16 |

- Containers with GPU A100

   | Operation mode | Guaranteed<br>SPS^1^ | RAM per card, <br>GB | HDD per card, <br>GB | Intel Gold 6230R<br>physical<br>cores <br>per card | Intel Gold 6230R <br>logical cores <br>per card |
   |---|---|---|---|---|---|
   | **Speech recognition** |
   | Streaming recognition | 245 | 64 | 200 | 14 | 28 |
   | Audio file recognition | 1,000 | 1,000 | 200 | 14 | 28 |
   | **Speech synthesis** |
   | Speech synthesis | 480 | 480 | 200 | 14 | 28 |

{% endlist %}

^1^ Seconds per second (SPS): Number of seconds of recognized or synthesized text per runtime second.

### Sample calculations of required hardware {#hardware-calculation}

The number of cards required for speech recognition or speech-to-text synthesis depends on the SPS value. Use the following formula for calculation:

{% list tabs %}

- Streaming recognition

   > User SPS = X × Y

   Where:

   * X is the percentage of conversation with recognition enabled. If interruptions need to be factored in, X = 1.
   * Y is the number of concurrent calls.

- Audio file recognition

   > User SPS = X / Y

   Where:

   * X is the duration of audio to recognize, in seconds.
   * Y is the time required for audio recognition, in seconds.

- Speech synthesis

   > User SPS = X × (Y / 10)

   Where:

   * X is the expected number of requests per second.
   * Y is the average request length in characters.

{% endlist %}

The number of cards is calculated as follows:

> User SPS / guaranteed card SPS

The resulting value is rounded up to the nearest integer.

To get the required amount of RAM, HDDs, and cores, multiply the table values by the number of cards.