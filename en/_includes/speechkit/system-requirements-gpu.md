## Hardware requirements for STT and TTS servers {#hardware}

Below are the recommended hardware requirements for running {{ sk-hybrid-name }} containers. The estimated values of {{ sk-hybrid-name }} specifications are given for reference for the hardware with the NVIDIA 535 driver. The actual values may change after containers are updated and new features arrive.

The data in the tables is for the Russian language only, unless otherwise specified:

{% list tabs group=gpu_type %}

- Containers with the L4 GPU {#l4}

   | Operation mode | Guaranteed<br>SPS^1^ | RAM per card, <br>GB | HDD per card, <br>GB | Physical processor<br>cores<br>Intel Gold 6230R <br>per card, pcs | Logical cores <br>Intel Gold 6230R <br>per card, pcs |
   |---|---|---|---|---|---|
   | **Speech recognition** |
   | Streaming recognition | 66 | 64 | 200 | 8 | 16 |
   | Audio file recognition | 330 | 64 | 200 | 8 | 16 |
   | **Speech synthesis** |
   | Speech synthesis | 266 | 64 | 200 | 8 | 16 |

- Containers with the A100 GPU {#a100}

   | Operation mode | Guaranteed<br>SPS^1^ | RAM per card, <br>GB | HDD per card, <br>GB | Physical processor<br>cores<br>Intel Gold 6230R <br>per card, pcs | Logical cores <br>Intel Gold 6230R <br>per card, pcs |
   |---|---|---|---|---|---|
   | **Speech recognition** |
   | Streaming recognition | 245 | 64 | 200 | 14 | 28 |
   | Audio file recognition | 1,000 | 64 | 200 | 14 | 28 |
   | **Speech synthesis** |
   | Speech synthesis | 581 | 64 | 200 | 14 | 28 |

- Containers with the H100 PCI GPU {#h100}

   | Operation mode | Guaranteed<br>SPS^1^ | RAM per card, <br>GB | HDD per card, <br>GB | Physical processor<br>cores<br>Intel Gold 6230R <br>per card, pcs | Logical cores <br>Intel Gold 6230R <br>per card, pcs |
   |---|---|---|---|---|---|
   | **Speech recognition** |
   | Streaming recognition, Russian | 385 | 64 | 200 | 8 | 16 |
   | Streaming recognition, multi-lingual model | 245 | 64 | 200 | 8 | 16 |
   | Audio file recognition, Russian | 3,500 | 64 | 200 | 8 | 16 |
   | Audio file recognition with speaker labeling, Russian | 2,590 | 64 | 200 | 8 | 16 |
   | **Speech synthesis** |
   | Speech synthesis | 1,260 | 64 | 200 | 8 | 16 |

{% endlist %}

^1^ Seconds per second (SPS): Number of seconds of recognized or synthesized text per runtime second.

### Examples of hardware calculations for STT and TTS servers {#hardware-calculation}

The number of cards required for speech recognition or speech-to-text synthesis depends on the SPS value. Use the following formula for calculation:

{% list tabs %}

- Streaming recognition

   > User SPS = X × Y

   Where:

   * X: Conversation portion with recognition enabled. If you need to factor in interruptions, X = 1.
   * Y: Number of concurrent calls.

- Audio file recognition

   > User SPS = X / Y

   Where:

   * X: Duration of audio to recognize in seconds.
   * Y: Time required for audio recognition in seconds.

- Speech synthesis

   > User SPS = X × (Y / 10)

   Where:

   * X: Expected number of requests per second.
   * Y: Average request length in characters.

{% endlist %}

The number of cards is calculated as follows:

> User SPS / guaranteed card SPS

The resulting value is rounded up to the nearest integer.

To get the required amount of RAM, HDDs, and cores, multiply the table values by the number of cards.
