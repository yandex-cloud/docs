# Speech synthesis

_Speech synthesis_ in {{ speechkit-full-name }} lets you convert any text to speech in multiple languages. You can choose the voice and manage speech parameters.

During synthesis, {{ speechkit-name }} doesn't stitch fragments of real speech together, but trains an acoustic model on the speaker's voice using neural networks. As a result, the synthesized speech sounds smooth and has natural intonation.

{% include [api-concepts](../../_includes/speechkit/api-concepts.md) %}

## Languages {#langs}

{{ speechkit-name }} models can synthesize Russian (`ru-RU`) speech.

Some voices designed for speech synthesis in Russian can speak in English, but the synthesized text will be said with accent. For example, [try synthesizing](https://cloud.yandex.com/services/speechkit#demo) the phrase <q>Let me speak from my heart!</q> by selecting Russian in the language settings.

## Voices and speech settings {#voices}

Each voice corresponds to a model trained on the speaker's speech pattern. Voices differ by the tone, main language, and gender of the speaker (male or female). [Available voices](voices.md).

To keep the high quality of speech by the selected voice:

* Specify the recommended [speech settings](#settings).
* Track the [quality of the text you transmit](#text-quality).
* Try [premium voices](#premium) for communicating with clients.

### Speech settings {#settings}

The quality of speech and voice depend on the speech settings:

* Language: Each voice was created for a specific language that the speaker used. To get the desired quality, use a voice from the [list](voices.md) whose main language is the one selected.

   If you don't choose the main language, the voice you selected and high quality of speech are not guaranteed.
* Speech rate: If the speech is too fast or too slow, it sounds unnatural. However, this can be useful in commercials where every second of air time counts.

* Emotional tone is supported only for Russian (`ru-RU`) with `jane` or `omazh`. Don't use this parameter with other voices or languages, as the speech generated for individual phrases may be different from your settings.

   For these voices, a neural network was trained on three different datasets where the speaker spoke samples with different intonations: cheerful, irritated, and neutral. We don't plan to support tones for other voices now. For premium voices, the tone is selected automatically.

### Quality of transmitted text {#text-quality}

Sometimes the voice may change in the synthesized text. This happens if a low quality text is provided for synthesis:

* Long text without punctuation marks.
* Text with peculiar sentences and slang.
* Text with a large number of words from other languages.

### Premium voices {#premium}

[Premium voices](voices.md#premium) were trained using our new technology. Speech synthesized using the new technology sounds more natural.

Key differences of premium voices:

* Understanding of context. Before starting speech synthesis, the premium voice engine evaluates the whole text rather than individual sentences. This allows for intonation that is more typical of human speech.
* Attention to detail. By using deep neural networks for premium voice synthesis, we make a much deeper analysis of the original voice. This lets us generate a much clearer voice that is richer in detail and avoids various distortions typical in [standard voices](voices.md#standard).

## Controlling pronunciation {#ssml-tts}

To have more control over speech synthesis, you can use the [Speech Synthesis Markup Language](https://en.wikipedia.org/wiki/Speech_Synthesis_Markup_Language) (SSML) and TTS markup. These markup methods enable you to set the length of pauses, the pronunciation of individual sounds, and more. SSML and TTS markup have different data transmission parameters:

* To transmit text in SSML format, include the `ssml` parameter in the call body and use the `<speak>` tag as a wrapper for the text. SSML is supported only when using API v1. For more information, see [{#T}](ssml.md).
* To use TTS markup, include the `text` parameter in the API v1 call body. For more information, see [{#T}](tts-markup.md).

#### What's next {#what-is-next}

* Try speech synthesis using the demo on the [service page]{% if lang == "ru" %}(https://cloud.yandex.ru/services/speechkit#demo){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/services/speechkit#demo){% endif %}.
* Make sure to review the [API v1](request.md) parameters.