---
title: Creating a connection in {{ speechsense-full-name }}
description: You can upload a two-channel audio or text chat to {{ speechsense-name }} connections.
---

# Creating a connection

You can upload [two-channel audio](#create-audio-connection), [single-channel audio](#create-one-channel-audio-connection), or a [chat](#create-chat-connection) with text messages to a {{ speechsense-name }} connection. To create a connection, you need either the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role for the space.

## Creating a connection for two-channel audio {#create-audio-connection}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.
1. In the top-right corner, click **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
1. Specify a name of the connection and, if needed, add a description.
1. Select the **{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}** data type.
1. Under **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**:

    1. Specify the channels with the agent's voice and customer's voice. The left channel corresponds to audio track 0, while the right channel corresponds to audio track 1.
    1. Specify agent and customer keys from the metadata file. This file contains the call information collected from CRM systems, PBXs, or other sources.

       {% include [metadata](../../../_includes/speechsense/data/metadata.md) %}

1. Under **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}**, provide the keys from the metadata file that are not related to the agent or the customer.

   {% include [shared-metadata](../../../_includes/speechsense/data/shared-metadata.md) %}

1. Click **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.

## Creating a connection for single-channel audio {#create-one-channel-audio-connection}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.
1. In the top-right corner, click **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
1. Specify a name of the connection and, if needed, add a description.
1. Select the **{{ ui-key.yc-ui-talkanalytics.connections.type.one-channel-key-value }}** data type.
1. Under **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**:

   Specify agent and customer keys from the metadata file. This file contains the call information collected from CRM systems, PBXs, or other sources.

   {% include [metadata](../../../_includes/speechsense/data/metadata.md) %}

1. Under **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}**, provide the keys from the metadata file that are not related to the agent or the customer.

   {% include [shared-metadata](../../../_includes/speechsense/data/shared-metadata.md) %}

1. Optionally, under **{{ ui-key.yc-ui-talkanalytics.connections.additional.title }}**, enable these options:

   * **Split dialog text by speaker**: Splits the dialog text between speakers.
   
      {% note info %}
      
      If you disable this option, the dialog text will be presented as only the agent's. All tags and report parameters will be applied exclusively to the agent channel.
      
      {% endnote %}
      
   * **{{ ui-key.yc-ui-talkanalytics.connections.additional.split.title }}** and select the dialog splitting option:

      * **By duration**: Dialog is divided into segments of specified duration.

         * **{{ ui-key.yc-ui-talkanalytics.connections.additional.slice-length }}**: Specify the segment length in minutes and seconds.

      * **By phrases**: Dialog is divided into segments based on key phrases.

         * **{{ ui-key.yc-ui-talkanalytics.connections.additional.separators.start-key-value }}**, **{{ ui-key.yc-ui-talkanalytics.connections.additional.separators.finish-key-value }}**: List the key phrases for the beginning and the end of the dialog.

1. Click **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.

## Creating a connection for a chat {#create-chat-connection}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.
1. In the top-right corner, click **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
1. Specify a name of the connection and, if needed, add a description.
1. Select the **{{ ui-key.yc-ui-talkanalytics.connections.type.chat-key-value }}** data type.
1. Under **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.bot }}**, specify the keys from the metadata file. This file contains the dialog information collected from chats, CRM systems, or other sources.

    By default, connections include keys with agent's, customer's, and bot's names and IDs. In the **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** field, enter the name the key will have in {{ speechsense-name }}. You can also add a description, if required.

    To specify additional agent, customer, and bot metadata, click **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**. Make sure to enter the new key name and select a [metadata type](../../concepts/resources-hierarchy.md#connection).

1. Under **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}**, provide the keys from the metadata file that are not related to the agent, customer, and bot.

    By default, keys with date, direction, and dialog language are added to the connection. In the **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** field, enter the name the key will have in {{ speechsense-name }}. You can also add a description, if required.

    To specify additional metadata, click **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**. Make sure to enter the new key name and select a [metadata type](../../concepts/resources-hierarchy.md#connection).

    {{ speechsense-name }} can analyze dialogs in Russian and Kazakh; it translates the transcript into Russian for further analysis. Each dialog metadata must contain a string indicating the languages supposedly used in the conversation. When uploading dialogs in Kazakh, provide the `language: ru-RU, kk-KZ` string in the metadata. For Russian, provide `language: ru-RU`. Language codes are case-insensitive.

    To upload [related dialogs](../../concepts/dialogs.md#related-dialogs) into the connection, add the `ticket_id` string key. The dialogs will be linked by this key. Enter the name the key will have in {{ speechsense-name }}, e.g., `Task number`. You can also add a description, if required.

1. Click **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
