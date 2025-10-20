---
title: Creating a voice agent in {{ foundation-models-full-name }}
description: Follow this guide to create a voice agent using the {{ realtime-api }} in {{ foundation-models-full-name }}.
---

# Creating a voice agent

In {{ foundation-models-full-name }}, you can create a [voice agent](../../concepts/agents/realtime.md) that can communicate with the user in voice and text formats and maintain a dialogue closely resembling natural human interaction.

## Getting started {#before-begin}

To use an example:

1. Get an [API key](../../../iam/concepts/authorization/api-key.md) for the [service account](../../../iam/concepts/users/service-accounts.md) you are going to use to interact with the [{{ realtime-api }}](../../concepts/agents/realtime.md#realtime-api). For more information, see [{#T}](../get-api-key.md).
1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}

## Create a voice agent {#create-agent}

The provided example illustrates the process of client-server interaction through the {{ realtime-api }}. To create a voice agent:

1. Create a file named `voice-agent.py` and paste the following code into it:

    {% include [change-seat-agent](../../../_includes/ai-studio/agents/voice-agent-change-seat.md) %}

    Where:

    * `API_KEY`: [API key](../../../iam/concepts/authorization/api-key.md) of the [service account](../../../iam/concepts/users/service-accounts.md) used to call {{ realtime-api }} methods. 
    * `FOLDER`: ID of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the {{ realtime-api }} is called in.
    * `INPUT_FILE`: Path to the file containing the input audio message. In this example, you can use any audio file as the input audio message, even the one [generated](../../../speechkit/operations/tts-playground.md) using {{ speechkit-name }} Playground.
    * `CONVERTED_FILE`: Path to the audio file where the input audio message will be saved when converting it to the required format (mono, 24 kHz, 16-bit PCM).
    * `OUTPUT_FILE`: Path to the audio file generated with the model response.
1. Run the file you created:

    ```bash
    python3 voice-agent.py
    ```

    As a result of executing the code, the model response in text format will be displayed on the screen. The response is audio format will be saved to a file whose path is specified in the `OUTPUT_FILE` variable.

#### See also {#see-also}

[{#T}](../../concepts/agents/realtime.md)