# Getting started with {{ speechsense-full-name }}

{{ speechsense-full-name }} allows you to analyze your business communication channels based on dialog audio recordings or text chat messages and supports integration with your PBX and CRM systems. {{ speechsense-name }} utilizes {{ speechkit-full-name }} voice technologies to transcribe speech and perform statistical and qualitative analysis of recorded audio dialogs.

{{ speechsense-name }} can analyze audio and text dialogs in Russian.

You can upload your data to {{ speechsense-name }} or use a [demo recording](https://storage.yandexcloud.net/doc-files/speechsense-demo-dialog.wav) synthesized using {{ speechkit-name }}.

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet. For information on how to get started with {{ yandex-cloud }}, see [Getting started with {{ yandex-cloud }}](../getting-started/).
1. Accept the user agreement.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. [Assign](../iam/operations/roles/grant.md) the `speech-sense.spaces.creator` role to your {{ yandex-cloud }} account.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Select the organization to work with {{ speechsense-name }} in or [create](../organization/operations/enable-org.md) a new one.

## Configure the environment {#set-space}

1. Create a [space](concepts/resources-hierarchy.md#space) where all your [projects](concepts/resources-hierarchy.md#project) will be stored: select **Create space**, enter a name, add a description (optional), and click **Create**.
1. [Link a billing account](operations/space/link-ba.md) to the space. This account will be debited for the use of {{ speechsense-name }}.

   {% note tip %}

   To manage a billing account, you must have a [Yandex account](../iam/concepts/users/accounts.md#passport). If using {{ yandex-cloud }} through an [identity federation](../organization/concepts/add-federation.md), [contact]({{ link-console-support }}) support.

   {% endnote %}

1. Go to the **Connections** tab and create a [connection](concepts/resources-hierarchy.md#connection) based on metainformation of your audio recordings or text chats:

   1. Enter the **Connection name**.
   1. Select the **Two-channel audio** or **Chat** data type.
   1. Set the connection parameters. For more information, see [Creating a connection](operations/connection/create.md).
   1. Click **Create connection**.

   {% cut "Example of metadata.json for loading audio data" %}

   ```json
   {
      "direction_outgoung": "true",
      "client_id": "456",
      "client_name": "John Doe",
      "date": "2023-09-29T09:08:38.958Z",
      "date_to": "2023-09-29T09:15:07.897Z",
      "language": "RU",
      "operator_id": "123",
      "operator_name": "Jane Doe"
   }
   ```

   {% endcut %}

1. Create a project: on the space page, click **Create project**, enter a project name, and add a connection to the project. For each connection, you can select filtering rules based on its metainformation and the {{ yagpt-full-name }} criteria. With filters, you can ensure that only the dialogs you need are added to the project. Once you are done adding connections and configuring filters, click **Create project**.

## Upload your data {#upload-data}

{{ speechsense-name }} uses the [gRPC API](api-ref/grpc/index.md) to upload data.

To upload data:

1. [Create a service account](../iam/operations/sa/create.md).
1. [Add the service account to the namespace](operations/space/add-user-to-space.md) with the `speech-sense.data.editor` role. To learn more about the roles available in the service, see [{#T}](security/index.md).
1. [Create an API key](../iam/operations/api-key/create.md) or [IAM token](../iam/operations/iam-token/create-for-sa.md) for the service account to authenticate with the API. [Learn more about authentication in the {{ speechsense-name }} API](api-ref/authentication.md).
1. [Upload your audio data](operations/data/upload-data.md) or [chat history data](operations/data/upload-chat-text.md) using a Python data transfer script.

    Use one message for the whole audio.

    {% include [supported-formats](../_includes/speechsense/formats.md) %}
