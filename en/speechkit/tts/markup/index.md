# Text markup for speech synthesis

You can control pronunciation during speech synthesis by marking up the text you want to synthesize. {{ speechkit-full-name }} fully supports markup for texts in Russian only. Some pronunciation control features are also supported for other languages.

{% include [note-not-silence](../../../_includes/speechkit/note-templates-markup.md) %}

For Russian and Kazakh, {{ speechkit-full-name }} supports the synthesis of normalized text:

* Abbreviations do not need to be represented phonetically.
* Numbers can be written as Arabic numerals. During speech synthesis, they are converted into numbers pronounced as words.

{% include [note-not-silence](../../../_includes/speechkit/note-not-silence.md) %}


In {{ speechkit-name }}, there are two markup formats:

* [TTS](tts-markup.md): For API v1 and API v3.
* [SSML](ssml.md): For API v1 only.

