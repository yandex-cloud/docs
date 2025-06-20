---
title: Uploading audio data via the interface
description: Follow this guide to upload audio data directly via the {{ speechsense-name }} interface.
---

# Uploading audio data via the {{ speechsense-name }} interface

This guide will help you upload audio data to {{ speechsense-name }} via its interface. Use this option to quickly upload data and get started with {{ speechsense-name }}. Use the [API](upload-data.md) to fully upload your data.

If you want to upload the chat text instead of voice call audio, follow [this guide](upload-chat-text.md).

## Getting started {#before-you-begin}

1. [Create a connection](../connection/create.md) of the **{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}** or **{{ ui-key.yc-ui-talkanalytics.connections.type.one-channel-key-value }}** type. You do not need to use advanced settings for splitting dialogs.
1. [Create a project](../project/create.md) with the new connection.

   Voice call recordings will be uploaded to the project and connection you created.

## Uploading data {#upload-data}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the top-right corner, click **{{ ui-key.yc-ui-talkanalytics.upload-audio.upload-audio-key-value }}**.
1. In the window that opens, select files to upload by doing one of the following:

    * Select one or more files in the file manager and drag them to the {{ speechsense-name }} area marked by the dotted line.
    * Click **Select files** and select one or more files.

    {% note info %}

    Via the interface, you can only upload [MP3](../../concepts/formats.md) audio files. Use the API to upload audio files in other formats supported by {{ speechsense-name }}.

    {% include notitle [max-duration](../../../_includes/speechsense/data/max-duration.md) %}

    {% endnote %}

    Once you select the files, their upload into the intermediate buffer will begin. Wait for this operation to complete.

1. Fill in the metadata for each file:

    * **Start date**: Specify the dialog start date.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.direction-key-value }}**:

        * Select **{{ ui-key.yc-ui-talkanalytics.dialogs.direction.outgoing }}** if the dialog was initiated by the agent.
        * Select **{{ ui-key.yc-ui-talkanalytics.dialogs.direction.incoming }}** if the dialog was initiated by the customer.

    * **Language**: Specify language.
    * **Agent**: Enter the agent's name.
    * **operator_id**: The agent ID is generated automatically and can be corrected as needed.
    * **Client**: Enter the customer name.
    * **client_id**: The customer ID is generated automatically and can be corrected as needed.

1. Click **Add \ <N\> dialogs**. This will start uploading dialogs into the project followed by speech recognition and analysis. This may take some time.
