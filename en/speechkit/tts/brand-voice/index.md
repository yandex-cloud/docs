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

{{ brand-voice-name }} Adaptive technology lets you voice text based on _templates_: specially prepared phrases in which individual key parts called _variables_ are changed. Synthesized speech is trained on audio recordings of the speaker whose voice the resulting model should imitate. This makes it sound like all words, both recorded and synthesized, are read as phrases spoken by the same speaker.

### Advantages of {{ brand-voice-name }} Adaptive

* Natural-sounding speech and intonation
* Phrase synthesis requires much less data for training, which saves you money.

### Limitations of {{ brand-voice-name }} Adaptive

* Apart from text, you need pre-recorded audio with a phrase template to be synthesized. For more information about audio and text requirements, see [{#T}](income-data-format.md).
* The scope is limited to phrases that are characteristic of a phone call: rather short texts with limited expressive intonation. This voice is not suitable for literary texts.

#### What's next

* [{{ brand-voice-name }} API (English)](../../api-ref/authentication.md)
