# {{ brand-voice-full-name }}

{{ brand-voice-name }} technology lets you create unique voices for a speech synthesis model. Depending on the purpose of using a trained model, {{ yandex-cloud }} offers two types of {{ brand-voice-name }}.

## {{ brand-voice-name }} Full {#full}

{{ brand-voice-name }} Full is appropriate for any business objective:
* Voice assistants.
* Call center robot operators.
* Voicing arbitrary texts.

Creating a full-fledged model with a unique voice based on the voice of your speaker requires a large amount of recorded audio. Detailed information about {{ brand-voice-name }} Full technology and the cost of creating a model is available on request.

## {{ brand-voice-name }} Adaptive {#adaptive}

{{ brand-voice-name }} Adaptive is designed to create interactive robots for various use cases:
* Telemarketing.
* Receiving calls to level 1 technical support.
* Conducting surveys.
* Call center automation.

{{ brand-voice-name }} Adaptive technology lets you voice text based on _templates_: specially prepared phrases in which individual key parts called _variables_ are changed. Synthesized speech is trained on audio recordings of the speaker whose voice the resulting model should imitate. After training, the model synthesizes the whole text rather than stitching recorded and variable fragments together. As a result, all words sound natural, as if said by the same speaker.

Synthesis using {{ brand-voice-name }} Adaptive requires much less data for training than for the {{ brand-voice-name }} Full model, which saves you a lot of time and resources to create your brand's voice.

### {{ brand-voice-name }} Adaptive requirements and restrictions {#restrictionss}

* Apart from text, you need pre-recorded audio with a phrase template to be synthesized. For more information about audio and text requirements, see [{#T}](income-data-format.md).
* The scope is limited to phrases that are characteristic of a phone call: rather short texts with limited intonation. This technology is not suitable for literary texts.

#### What's next {#what-is-next}

* [{{ brand-voice-name }} API (Eng.)](../../new-v3/api-ref/grpc/).
* [{#T}](income-data-format.md).
* [{#T}](import-data.md).