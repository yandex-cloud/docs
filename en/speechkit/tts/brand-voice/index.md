# {{ brand-voice-full-name }}


The {{ brand-voice-name }} technology allows you to create unique voices for your speech synthesis model. It can synthesize both plain text and [pattern-based text](../templates.md). Patterns contain phrases with _variables_ that are replaced with prepared text. To cover different practical uses of trained models, {{ yandex-cloud }} offers three types of {{ brand-voice-name }}.

| | [{{ brand-voice-premium }}](#premium) | [{{ brand-voice-core }}](#ss) | [{{ brand-voice-cc }}](#cc) |
|---|---|---|---|
| Voice | Voice based on artist recordings | Voice based on artist recordings | Voice copy from the pattern |
| Usage | Full-text synthesis. Pattern-based synthesis. | Full-text synthesis. Pattern-based synthesis. | Pattern-based synthesis. The variable part should not exceed 25% of the pattern. |
| Emotions and roles | Coping emotions in pattern-based synthesis. </br>Developing additional [roles](../index.md#role). | Coping emotions in pattern-based synthesis. | Coping emotions in pattern-based synthesis. |
| Sampling frequency in source audio recordings | 48 kHz | 48 kHz | {{ tts-cc-quality }} or higher. |
| Sampling frequency in synthesized audio recordings | 22 kHz | 22 kHz | {{ tts-cc-quality }} |

To create a unique voice for your business, [fill out the form](#contact-form).


## {{ brand-voice-premium-name }} {#premium}

{{ brand-voice-premium-name }} is suitable for any business task:

* Voice assistants.
* Call center robot operators.
* Text-to-speech conversion of any text.

Creating a full-fledged model with a unique voice requires large amounts of audio recordings. {{ yandex-cloud }} experts will help you prepare the data for {{ brand-voice-premium-name }} model training, select a studio and an artist for you, and support you at each step of voice creation.

Once created, the {{ brand-voice-premium-name }} voice can be enhanced by various [roles](../index.md#role).


## {{ brand-voice-core-name }} {#ss}

If you have pre-recorded audios for training the model, you can create a {{ brand-voice-core-name }} voice based on them. With a voice like this, you can easily convert texts of any length into spoken language and synthesize speech using patterns. Based on such a voice, you can create voice assistants or robots for your call center.

You can add diverse emotions to your {{ brand-voice-core-name }} voice using [pattern-based synthesis](../templates.md). In pattern-based synthesis, intonations are copied from your audio recordings.

{% note info %}

When using pattern-based synthesis with {{ brand-voice-full-name }} voices, make sure your patterns are recorded by the same artist who made recordings for your {{ brand-voice-full-name }} voice.

{% endnote %}

The quality of synthesized speech depends directly on the quality of audio recordings used to train the model. When creating a {{ brand-voice-core-name }} voice, you are in charge of the entire process of training data preparation.

For more information on how to train your own model, see [{#T}](bv-full-data-upload.md).

## {{ brand-voice-cc-name }} {#cc}

{{ brand-voice-cc-name }} is purpose-designed for call center automation and other business scenarios involving phone calls:

* Telemarketing.
* Managing calls to level 1 technical support.
* Surveys.
* Call center automation.

With {{ brand-voice-cc }}, you do not have to train a special model based on your artist's voice, as the voice will be copied directly from the patterns you provide for phrase generation. The speech is synthesized integrally rather than glued together from a pre-recorded pattern and a generated variable part.

You can use {{ brand-voice-cc-name }} to automate your standard dialogs.

> For example, if you have an audio with the phrase `Hi Michael, I am calling from Thunderclouds. My name is Anastasia. Is this a good time to talk?`, you can transform it to `Hi Ann, I am calling from New Doors. My name is Matt. Is this a good time to talk?` without having to record any additional phrases.

### {{ brand-voice-cc-name }} requirements and restrictions {#restrictions-cc}

For speech synthesis, you need an audio file with your phrase pattern and a text with marked up variables. To learn more about text requirements, see [{#T}](../templates.md#requirements-text).

The sampling frequency in the synthesized audio recording is {{ tts-cc-quality }}. This is enough for phone calls. However, in other scenarios, you might hear some noises and flaws of synthesis.

{{ brand-voice-cc-name }} is designed for phone calls. The texts used for synthesis should be short enough: the duration of a synthesized phrase cannot exceed {{ tts-v3-time }}, while its length, including the variable part, cannot be more than {{ tts-v3-count }}. The variable part of a synthesized phrase cannot exceed 25% of its length.

{{ brand-voice-cc-name }} logs your transmitted patterns (both text and audio). However, the synthesized audio recordings and variable parts, including your sensitive data, are not logged. To improve the quality of a model running on your data, you can enable variable logging through the `x-data-logging-enabled: true` [header](../../concepts/support-headers#request-headers).

{% note info %}

It may be useful to log data if synthesis errors occur. If you do not want to log all data, only include the logging header in requests with issues after clearing the variable part of personal data as much as possible.

{% endnote %}

#### See also {#what-is-next}

* [{{ brand-voice-name }} API](../../tts-v3/api-ref/grpc/)
* [{#T}](../templates.md)
* [{#T}](../api/tts-templates.md)

