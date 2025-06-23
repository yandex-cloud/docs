---
title: How to synthesize speech via the {{ speechkit-full-name }} Playground interface
description: Follow this guide to convert text into human speech via the {{ speechkit-name }} Playground interface.
---

# Speech synthesis using Playground

To convert text to speech via the {{ speechkit-name }} Playground interface: 

1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you are going to use to work with {{ speechkit-name }}.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
1. Navigate to the **{{ ui-key.yacloud.yagpt.speechkit.services.speech-synthesys.title }}** tab.
1. Paste up to 5,000 characters of text into the central part of the window.
1. In the settings section on the left side of the window:

   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_pauses-title }}**: Set up fixed [pauses](../tts/markup/tts-markup.md#pause) between words using tags, e.g., `<[small]>`, `<[large]>`. For a pause of a particular length, use the `sil<[t]>` tag, where `t` is the the pause length in milliseconds. The maximum value is 7,000.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_word-title }}**: [Accent](../tts/markup/tts-markup.md#accent) a word using the `<[accented]>` tag or by enclosing it in asterisks (`** **`).
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_word-stress-title }}**: Mark the [stressed](../tts/markup/tts-markup.md#a) vowel in homographs by prefixing it with `+`.
   * **{{ ui-key.yacloud.speechkit.help-speech-synthesis.context_phonemes-title }}**: Tag words with `[[]]` to ensure proper pronunciation using [phonemes](../tts/markup/tts-supported-phonemes.md).

1. Under **{{ ui-key.yacloud.speechkit.speech-synthesis.label_synthesis-settings }}** on the right side of the window:

   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_language }}**: Set the speaker's language.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_voice }}**: Select the speaker's voice.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_role }}**: Control tone and emotion by selecting the speaker's role.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_speed }}**: Set the speaker's speech rate in the range from `0.1` to `3.0`, where `1.0` is the average human speech rate.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_pitch-shift }}**: Adjust the speaker's voice pitch. The higher the value, the greater the intonation contour of the synthesized audio in Hz.
   * **{{ ui-key.yacloud.speechkit.speech-synthesis.field_audio }}**: Select the audio format.

1. Click ![TriangleRight](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.speechkit.speech-synthesis.label_button_playback }}** to synthesize speech.
1. To download the result, click ![arrow-down-to-line](../../_assets/console-icons/arrow-down-to-line.svg).

{{ speechkit-name }} Playground features basic speech synthesis options. For more flexible synthesis settings, use the [API](#tts-quickstart).