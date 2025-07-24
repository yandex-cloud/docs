---
title: How to recognize speech from an audio file via the {{ speechkit-full-name }} Playground interface
description: Follow this guide to recognize an audio file via the {{ speechkit-name }} Playground interface.
---

# Speech recognition using Playground

To recognize speech from an audio file via the {{ speechkit-name }} Playground interface:

1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you are going to use to work with {{ speechkit-name }}.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
1. Navigate to the **{{ ui-key.yacloud.yagpt.speechkit.services.stt.title }}** tab.
1. In the **{{ ui-key.yacloud.speechkit.speech-to-text.field_language }}** field, select the language you need or leave `{{ ui-key.yacloud.speechkit.speech-to-text.label_language-auto }}`.
1. Click **Select file** or drag the audio file to the loading area.

{% note tip %}

Convert the file to a supported [audio format](../formats.md) beforehand: MP3, WAV, or OGG with the OPUS audio codec. Maximum file size: 60 MB.

{% endnote %}

1. Click ![TriangleRight](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.speechkit.speech-to-text.label_button_start-recognition }}** to start speech recognition in the audio file.

   Recognition may take from a few seconds to a few minutes depending on the audio file size.

1. Click ![Copy](../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud.speechkit.speech-to-text.label_button_copy-text }}** to copy the recognized text.

{{ speechkit-name }} Playground features basic speech recognition options. For more flexible recognition settings, use the [API](../stt/index.md).