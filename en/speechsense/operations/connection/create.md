---
title: Creating a connection in {{ speechsense-full-name }}
description: You can upload a two-channel audio or text chat to {{ speechsense-name }} connections.
---

# Creating a connection

You can upload a [two-channel audio](#create-connection-audio) or text [chat](#create-connection-chat) to {{ speechsense-name }} connections. To create a connection, you need either the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role for the space.

## Creating a connection for an audio {#create-audio-connection}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the appropriate space.
1. In the top-right corner, click **More** → ![create](../../../_assets/console-icons/thunderbolt.svg) **Create connection**.
1. Name the new connection and, optionally, enter a description.
1. Select the **Two-channel audio** data type.
1. Under **Agent** and **Customer**:

    1. Specify the agent's voice and customer's voice track numbers.
    1. Specify agent and customer keys from the metadata file. This file contains the call information collected from CRM systems, PBXs, or other sources.

       By default, connections include keys with the name and ID of the agent and customer. In the **Name in the system** field, enter a name for the key to display in {{ speechsense-name }}. You can also add a description, if required.

       To specify additional metadata for the agent and the customer, click **Add key**.

1. Under **Shared metadata**, provide the keys from the metadata file that are not related to the agent or the customer.

    By default, connections include keys with the date, direction, and language of the call. In the **Name in the system** field, enter a name for the key to display in {{ speechsense-name }}. You can also add a description, if required.

    To specify additional metadata, click **Add key**.

1. Click **Create connection**.

## Creating a connection for a chat {#create-chat-connection}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the appropriate space.
1. In the top-right corner, click **More** → ![create](../../../_assets/console-icons/thunderbolt.svg) **Create connection**.
1. Name the new connection and, optionally, enter a description.
1. Select the **Chat** data type.
1. Under **Agent**, **Customer**, **Bot**, specify the keys from the metadata file. This file contains the dialog information collected from chats, CRM systems, or other sources.

    By default, connections include keys with agent's, customer's, and bot's names and IDs. In the **Name in the system** field, enter a name for the key to display in {{ speechsense-name }}. You can also add a description, if required.

    To specify additional agent, customer, and bot metadata, click **Add key**.

1. Under **Shared metadata**, provide the keys from the metadata file that are not related to the agent, customer, and bot.

    By default, keys with date, direction, and dialog language are added to the connection. In the **Name in the system** field, enter a name for the key to display in {{ speechsense-name }}. You can also add a description, if required.

    To specify additional metadata, click **Add key**.

1. Click **Create connection**.
