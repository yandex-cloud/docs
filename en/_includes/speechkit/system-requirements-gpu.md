## Hardware requirements for STT and TTS servers {#hardware}

Recommended hardware requirements for running {{ sk-hybrid-name }} containers estimated values of {{ sk-hybrid-name }} specifications are given for reference based on hardware using the NVIDIA 535 driver. The actual values may change after containers are updated and new features are added.

The data in the tables is for the Russian language only:

{% list tabs group=gpu_type %}

- Containers with GPU T4 {#t4}

   | Operation mode | Guaranteed<br>SPS^1^ | RAM per card, <br>GB | HDD per card, <br>GB | Physical processor<br>cores<br>Intel Gold 6230R <br>per card, pcs | Boolean cores <br>Intel Gold 6230R <br>per card, pcs |
   |---|---|---|---|---|---|
   | **Speech recognition** |
   | Streaming recognition | 50 | 64 | 200 | 8 | 16 |
   | Audio file recognition | 250 | 64 | 200 | 8 | 16 |
   | **Speech synthesis** |
   | Speech synthesis | 80 | 64 | 200 | 8 | 16 |

- Containers with GPU V100 {#v100}

   | Operation mode | Guaranteed<br>SPS^1^ | RAM per card, <br>GB | HDD per card, <br>GB | Physical processor<br>cores<br>Intel Gold 6230R <br>per card, pcs | Boolean cores <br>Intel Gold 6230R <br>per card, pcs |
   |---|---|---|---|---|---|
   | **Speech recognition** |
   | Streaming recognition | 110 | 64 | 200 | 8 | 16 |
   | Audio file recognition | 500 | 64 | 200 | 8 | 16 |
   | **Speech synthesis** |
   | Speech synthesis | 200 | 64 | 200 | 8 | 16 |

- Containers with GPU A100 {#a100}

   | Operation mode | Guaranteed<br>SPS^1^ | RAM per card, <br>GB | HDD per card, <br>GB | Physical processor<br>cores<br>Intel Gold 6230R <br>per card, pcs | Boolean cores <br>Intel Gold 6230R <br>per card, pcs |
   |---|---|---|---|---|---|
   | **Speech recognition** |
   | Streaming recognition | 245 | 64 | 200 | 14 | 28 |
   | Audio file recognition | 1,000 | 64 | 200 | 14 | 28 |
   | **Speech synthesis** |
   | Speech synthesis | 480 | 64 | 200 | 14 | 28 |

{% endlist %}

^1^ Seconds per second (SPS): Number of seconds of recognized or synthesized text per runtime second.

### Examples of hardware calculations for STT and TTS servers {#hardware-calculation}

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
