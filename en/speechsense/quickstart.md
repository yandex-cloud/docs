# Getting started with {{ speechsense-full-name }}

{{ speechsense-full-name }} enables you to analyze your business' communication channels through call recordings and supports integration with your PBX and CRM systems. {{ speechsense-name }} utilizes {{ speechkit-full-name }} voice technologies to transcribe speech and perform high-quality static analysis of dialogs.

You can upload your audio recordings to {{ speechsense-name }} or use a [demo recording](https://storage.yandexcloud.net/doc-files/speechsense-demo-dialog.wav) synthesized with {{ speechkit-name }}.

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create an account if you do not have one yet. For information on how to get started with {{ yandex-cloud }}, see [Getting started with {{ yandex-cloud }}](../getting-started/).
1. Accept the user agreement.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../billing/concepts/billing-account.md) linked and that it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. [Make sure](../iam/operations/roles/get-assigned-roles.md) that your account has the `speech-sense.spaces.creator` role assigned.
1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Select the organization to work with {{ speechsense-name }} in or [create](../organization/operations/enable-org.md) a new one.

## Configure the environment {#set-space}

1. Create a [space](concepts/resources-hierarchy.md#space) where all your [projects](concepts/resources-hierarchy.md#project) will be stored: select **Create space**, enter a name, add a description (optional), and click **Create**.
1. [Link a billing account](operations/space/link-ba.md) to the space. This account will be debited for the use of {{ speechsense-name }}.

  {% note tip %}

  You can only manage a billing account if you have a [Yandex account](../iam/concepts/index.md#passport). If you use {{ yandex-cloud }} through an [identity federation](../organization/concepts/add-federation.md), [contact]({{ link-console-support }}) support.

  {% endnote %}

1. Go to the **Connections** tab and create a [connection](concepts/resources-hierarchy.md#connection) using your audio's metadata:

    1. Enter the **Connection name**.
    1. Select **Two-channel audio** under **Data type**.
    1. Set connection parameters using the metadata of your audio recordings:
        * Under **Agent**, specify the number of the track that contains the agent's voice in your audio recordings and define their displayed name (`Agent` by default).
        * Under **Customer**, specify the number of the track that contains the customer's voice in your audio recordings and define their displayed name (`Customer` by default).
        * Under **Shared metadata**, change the parameter names used in the system, if necessary.
        * If your metadata includes additional information you want to save and analyze, add it to the appropriate section. Provide the parameter key (must match the key in the metadata file), specify a type, and enter a display name to use in the system. The supported additional parameters are `Date`, `String`, `Number`, `Logical`, and `JSON`.
    1. Click **Create connection**.

    {% cut "Example of metadata.json" %}

    ```json
    {
       "direction_outgoung": "true",
       "client_id": "456",
       "client_name": "John Doe",
       "date": "2023-09-29T09:08:38.958Z",
       "date_to": "2023-09-29T09:15:07.897Z",
       "language": "RU",
       "operator_id": "123",
       "operator_name": "Jane Smith"
    }
    ```

    {% endcut %}

1. Create a project: on the space page, click **Create project**, enter a project name, and add a connection to the project. You can select up to two connection metadata-based filtering rules for each connection. With filters, you can ensure that only the dialogs you need are added to the project. Once you are done adding connections and configuring filters, click **Create project**.

## Upload your data {#upload-data}

{{ speechsense-name }} uses the [gRPC API](api-ref/grpc/index.md) to upload data.

1. [Create a service account](../iam/operations/sa/create.md).
1. [Add the service account to the space](operations/space/add-user-to-space.md) with the `speech-sense.data.editor` role. To learn more about the roles available in the service, see [{#T}](security/index.md).
1. [Create an API key](../iam/operations/api-key/create.md) or [IAM token](../iam/operations/iam-token/create-for-sa.md) for the service account to authenticate with the API. [Learn more about authentication in the {{ speechsense-name }} API](api-ref/authentication.md).
1. [Upload your data](operations/data/upload-data.md) using a Python data transfer script. You must provide your entire audio recording as one message.

{% include [supported-formats](../_includes/speechsense/formats.md) %}
