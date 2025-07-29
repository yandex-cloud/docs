# Integration with Bitrix24

To set up integration with Bitrix24 in {{ speechsense-name }}:

1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#create-sa).
1. [Create an API key for the service account](#create-key).
1. [Create a space and link a billing account](#create-space).
1. [Add the service account to the space](#add-sa-to-space).
1. [Create a connection](#create-connection).
1. [Create a project](#create-project).
1. [Configure a Bitrix24 environment](set-bitrix24).

## Get your cloud ready {#before-you-begin}

1. Navigate to the [management console]({{ link-console-main }}) and either log in to {{ yandex-cloud }} or sign up if you do not have an account yet. For information on how to get started with {{ yandex-cloud }}, see [Getting started with {{ yandex-cloud }}](../../getting-started/).
1. Accept the user agreement.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its status is `ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account). If your billing account has the `TRIAL_ACTIVE` status, [activate its paid version](../../billing/operations/activate-commercial.md).
1. [Assign](../../iam/operations/roles/grant.md) the `speech-sense.spaces.creator` role to your {{ yandex-cloud }} account.

    {% include [note-managing-roles](../../_includes/mdb/note-managing-roles.md) %}

### Create a service account {#create-sa}

Create a service account named `speechsense`.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Name the [service account](../../iam/concepts/users/service-accounts.md): `speechsense`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `speech-sense.data.editor` role.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Create an API key for the service account {#create-key}

Create an API key for the `speechsense` service account.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the service account.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Select the `speechsense` service account.
  1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** field, click **Select all** and leave all other fields empty.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key. You will use this secret key when filling out the form with application settings in Bitrix24.

  {% note alert %}

  After you close this dialog, the key value will not be shown again.

  {% endnote %}

{% endlist %}  

### Create a space and link a billing account {#create-space}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

  1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
  1. Click **{{ ui-key.yc-ui-talkanalytics.spaces.create-space }}**.
  1. Enter a name for the [space](../../speechsense/concepts/resources-hierarchy.md#space).
  1. Click **{{ ui-key.yc-ui-talkanalytics.common.create }}**.
  1. [Link a billing account](../../speechsense/operations/space/link-ba.md) to the space. This account will be debited for the use of {{ speechsense-name }}.

     {% include [manage-ba-note](../../_includes/speechsense/manage-ba-note.md) %}

{% endlist %}

### Add the service account to the space {#add-sa-to-space}

Add the `speechsense` service account to the {{ speechsense-name }} space.

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

  1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
  1. Go to your [new space](#create-space).
  1. Click ![image](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.add-participant }}** → ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yc-ui-talkanalytics.team.add-from-organization-key-value }}**.
  1. Copy the ID of the `speechsense` [service account you created earlier](#create-sa) and paste it to the search bar.
  1. Select the `speechsense` service account and specify the [{{ roles-speechsense-data-editor }}](../../speechsense/security/index.md#speechsense-data-editor) role. This role will allow `speechsense` to upload data to {{ speechsense-name }}.
  1. Click **{{ ui-key.yc-ui-talkanalytics.common.add }}**.

{% endlist %}

### Create a connection {#create-connection}

Depending on the type of files to be uploaded to {{ speechsense-name }}, create a connection for an audio or chat.

#### Create a connection for an audio {#create-audio-connection}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

  1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
  1. Go to the space of your choice.
  1. In the top-right corner, click **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
  1. Enter the connection name.
  1. Select the **{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}** data type.
  1. Under **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}** and **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**, specify:

      1. Channels with the agent's and customer's voices.
      1. Agent and customer keys from the metadata file. This file contains the call information collected from CRM systems, PBXs, or other sources.

        By default, connections include keys with the name and ID of the agent and the customer. In the **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** field, enter a name the key will have in {{ speechsense-name }}.

        To specify additional metadata for the agent and the customer, click **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. Under **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}**, provide the keys from the metadata file that are not related to the agent or the customer.

      By default, connections include keys with the date, direction, and language of the call. In addition, you can specify the keys you want to receive from Bitrix24. In the **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** field, enter the name the key will have in {{ speechsense-name }}.

      {% cut "List of available fields" %}

      This list is valid for the current application version.
   
      ```json
      {
         "id",
         "portal_user_id",
         "portal_number",
         "phone_number",
         "call_id",
         "external_call_id",
         "call_category",
         "call_duration",
         "call_start_date",
         "call_record_url",
         "call_vote",
         "cost",
         "cost_currency",
         "call_failed_code",
         "call_failed_reason",
         "crm_entity_type",
         "crm_entity_id",
         "crm_activity_id",
         "rest_app_id",
         "rest_app_name",
         "transcript_id",
         "transcript_pending",
         "session_id",
         "redial_attempt",
         "comment",
         "record_duration",
         "record_file_id",
         "call_type"
      }
      ```
   
      {% endcut %}

      To specify additional metadata, click **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. Click **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
  1. Copy and save the connection ID. Do it by clicking **ID** ![image](../../_assets/console-icons/copy-transparent.svg) in the top-left corner of the connection page. 

     You will use this connection ID when filling out the form with application settings in Bitrix24.

{% endlist %}

### Create a project {#create-project}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

  1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
  1. Go to the space of your choice.
  1. Click ![create](../../_assets/console-icons/folder-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.
  1. Enter a name for your project.
  1. Under **{{ ui-key.yc-ui-talkanalytics.connections.connection }}**, click **{{ ui-key.yc-ui-talkanalytics.projects.add-connection }}** and select the connection you [created earlier](#create-connection).
  1. Click **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.

{% endlist %}

## Configure a Bitrix24 environment {#set-bitrix24}

1. Go to application settings in Bitrix24 and click **Edit** to edit the settings.
1. Fill out the application settings form:

   * **SpeechSense connection ID**: ID of the {{ speechsense-name }} connection you created under [Create a connection](#create-connection).
   * **API key**: Secret API key of the `speechsense` service account you created under [Create an API key for the service account](#create-key).

   Click **Check connection**. If the connection was configured successfully, you will see "SpeechSense request successful".

   * **Download calls starting from**: Set a date. Leaving this field empty will result in downloading all calls from the base.

     {% note info %}
     
     When testing an integration, we recommend setting a date.
     
     {% endnote %}

   * **List of users**: List the IDs of Bitrix24 users (list of operators) for which to download calls. Leaving this field empty will result in downloading all calls for all users from the base.

   * **Minimum conversation time**: Conversation duration in seconds. We recommend sending calls that took 30 seconds or longer.
   
   Click **Start download**. In a few seconds' time, downloaded calls with transcripts will appear in your project in the [{{ speechsense-name }} interface]({{ link-speechsense-main }}) enabling you to proceed [configuring the reports](../../speechsense/operations/data/manage-reports.md).
     
     
   

