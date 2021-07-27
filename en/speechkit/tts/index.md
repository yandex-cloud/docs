---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Speech synthesis

_Speech synthesis_ in {{ speechkit-name }} lets you convert any text to speech in multiple languages. You can choose the voice and manage speech parameters.

A highlight of Yandex speech technology is that we do not stitch fragments of real speech together, but train our acoustic model on the speaker's voice. We do this using neural networks. This creates smooth speech with natural intonation for any text.

## Languages {#langs}

You can synthesize speech in three languages:

- Russian (`ru-RU`).
- English (`en-US`).
- Turkish (`tr-TR`).

Keep in mind that if you select Russian and synthesize text in English, it will still be spoken, but with an accent. For example, [try synthesizing](https://cloud.yandex.com/services/speechkit#demo) the phrase <q>Let me speak from my heart!</q> by selecting Russian in the language settings.

## Voices and speech quality {#voices}

Each voice corresponds to a model trained on the speaker's speech pattern, so the voice determines the tone, main language, and gender of the speaker (male or female). [List of available voices](voices.md).

To use the preferred voice and maintain speech quality:

* Specify the recommended [speech settings](#settings).
* Track the [quality of the text you transmit](#text-quality).
* Try [premium voices](#premium) for communicating with clients.

### Speech settings {#settings}

The quality of speech and voice depend on the speech settings:

* Language: Each voice was created for a specific language that the speaker spoke. To get the desired quality, use a voice from the [list](voices.md) whose main language is the one selected.

    If you don't choose the main language, the speech quality will be worse and the voice used may not be the one you specified.

* Speech rate: If the speech is too fast or too slow, it sounds unnatural. However, this can be useful in commercials where every second of air time counts.

* Emotional tone is supported only for Russian (`ru-RU`) with `jane` or `omazh`. Don't use this parameter with other voices or languages, as the speech generated for individual phrases may be different from your settings.

    For these voices, a neural network was trained on three different datasets where the speaker spoke samples with different intonations: cheerful, irritated, and neutral. We don't plan to support tones for other voices now. For premium voices, the tone is selected automatically.

### Quality of transmitted text {#text-quality}

Reasons why other voices may be used:

* Long text without punctuation marks. For better quality, insert periods and commas.
* Specific sentences on a complex topic.
* Many occurrences of words from other languages.

### Premium voices {#premium}

[Some voices](voices.md#premium) were trained using our new technology. Speech synthesized using the new technology sounds more natural.

Key differences:

* Understanding of context. Before starting speech synthesis, the premium voice engine evaluates the whole text rather than individual sentences. This allows for intonation that is more typical of human speech.
* Attention to detail. By using deep neural networks for premium voice synthesis, we make a much deeper analysis of the original voice. This lets us generate a much clearer voice that is richer in detail and avoids various distortions typical in [standard voices](voices.md#standard).

{% note warning %}

The new technology currently only supports voices for Russian. Choosing a different language affects the speech quality.

{% endnote %}

## SSML support {#ssml}

To get more control over speech synthesis, you can use [Speech Synthesis Markup Language](https://en.wikipedia.org/wiki/Speech_Synthesis_Markup_Language) (SSML). This is an XML-based markup language that lets you set the duration of pauses, the pronunciation of individual sounds, and much more. For more information about supported tags and how to use them, see [{#T}](ssml.md).

#### What's next {#what-is-next}

* Try speech synthesis using the demo on the [service page](https://cloud.yandex.com/services/speechkit#demo).
* [{#T}](request.md)

