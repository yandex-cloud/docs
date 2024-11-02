# Getting started with {{ speechkit-name }}

You can test speech recognition and synthesis on the {{ speechkit-name }} [demo page](https://yandex.cloud/en/services/speechkit#demo). For information on pricing, see [{#T}](../pricing.md).

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet. For information on how to get started with {{ yandex-cloud }}, see [Getting started with {{ yandex-cloud }}](../../getting-started/).
1. Accept the user agreement.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).

## Speech recognition using Playground {#tts-playground}

To recognize speech from an audiofile via the {{ speechkit-name }} Playground interface:

1. Open the [management console]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
1. In the left-hand panel, click ![image](../../_assets/console-icons/dice-3.svg) **{{ ui-key.yacloud.speechkit.label_playground }}** and go to the **{{ ui-key.yacloud.speechkit.label_speech-to-text }}** tab.
1. In the **{{ ui-key.yacloud.speechkit.speech-to-text.field_language }}** field, select the language you need or leave `{{ ui-key.yacloud.speechkit.speech-to-text.label_language-auto }}`.
1. Click **Select file** or drag the file to the loading area.
1. Click **{{ ui-key.yacloud.speechkit.speech-to-text.label_button_start-recognition }}** to start the speech recognition process.

{{ speechkit-name }} Playground features basic speech recognition options. For more flexible recognition settings, use the [API](#stt-quickstart).

## Speech synthesis using Playground {#tts-playground}

To convert text to audio via the {{ speechkit-name }} Playground interface: 

1. Open the [management console]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
1. In the left-hand panel, click ![image](../../_assets/console-icons/dice-3.svg) **{{ ui-key.yacloud.speechkit.label_playground }}** and go to the **{{ ui-key.yacloud.speechkit.label_speech-synthesis }}** tab.
1. Under **{{ ui-key.yacloud.speechkit.speech-synthesis.label_synthesis-settings }}**:
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_pauses-title }}**: Select the length of pauses between words or specify it yourself.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_word-title }}**: Emphasize the essential words.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_word-stress-title }}**: Mark the stressed vowels to clarify the correct pronunciation of the words.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_phonemes-title }}**: Monitor the correct pronunciation of words using phonemes.
1. Under **{{ ui-key.yacloud.speechkit.speech-synthesis.label_synthesis-settings }}**:
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_language }}**: Select the speaker's language.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_voice }}**: Specify the speaker's voice.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_role }}**: Select the speaker's role.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_speed }}**: Set the speaker's speech rate.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_pitch-shift }}**: Adjust the speaker's voice pitch.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_audio }}**: Select the audio format.
1. To synthesize the text, click **{{ ui-key.yacloud.speechkit.speech-synthesis.label_button_playback }}**.
1. To download the result, click ![image](../../_assets/console-icons/arrow-down-to-line.svg).

{{ speechkit-name }} Playground features basic speech synthesis options. For more flexible synthesis settings, use the [API](#tts-quickstart).

## Authentication for API access {#auth}

{% include [ai-before-beginning](../../_includes/speechkit/ai-before-beginning.md) %}

## Speech recognition via the API {#stt-quickstart}

Learn how to recognize [short](stt-quickstart-v1.md) and [long](stt-quickstart-v2.md) pre-recorded audio files in {{ speechkit-name }}. The service also supports voice recognition in [real time](../stt/api/streaming-examples-v3.md).

## Speech synthesis via the API {#tts-quickstart}

Learn how to convert text to audio using the {{ speechkit-name }} [API v1](tts-quickstart-v1.md) and [API v3](tts-quickstart-v3.md). The API v3 provides more flexibility for speech synthesis setup. For more information about the differences between the API versions, see [{#T}](../tts/index.md#features).

#### See also {#see-also}

* [Read more about speech recognition](../stt/index.md)
* [Read more about speech synthesis](../tts/index.md)
* [Supported audio formats](../formats.md)
* [Roles required for performing operations](../security/index.md)
* [All {{ speechkit-name }} integration examples](../tutorials/index.md)
