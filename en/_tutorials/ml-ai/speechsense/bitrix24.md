To set up {{ speechsense-name }} integration with {{ bitrix24-name }}:

1. [Get your cloud ready](#before-you-begin).
1. [Set up export from {{ bitrix24-name }} to {{ speechsense-name }}](#bitrix24-export).
1. [Check the result](#check-result).

{% include [prepare-cloud](../../_tutorials_includes/speechsense-integration/prepare-cloud.md) %}


### Create a connection {#create-connection}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

  1. In the {{ speechsense-name }} [UI]({{ link-speechsense-main }}), go to the space of your choice.
  1. Go to the **{{ ui-key.yc-ui-talkanalytics.connections.connections }}** tab and select a template to create a connection or click **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.

     {% include [metadata](../../../_includes/speechsense/data/templates-connection.md) %}

  1. Enter the connection name.
  1. Select the `{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}` data type.
  1. Under **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}** and **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**, specify:

      1. Channels with the agent's and customer's voices.
      1. Agent and customer keys from the metadata file. This file contains the call information collected from CRM systems, PBXs, or other sources.

        By default, connections include keys with the name and ID of the agent and the customer. In the **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** field, enter the name the key will have in {{ speechsense-name }}.

        To specify additional metadata for the agent and the customer, click **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. Under **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}**, provide the keys from the metadata file that are not related to the agent or the customer.

      By default, connections include keys with the date, direction, and language of the call. In addition, you can specify the keys you want to receive from the external system. In the **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** field, enter the name the key will have in {{ speechsense-name }}.

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
  1. Click **ID** ![image](../../../_assets/console-icons/copy-transparent.svg) in the top-left corner of the connection page to copy the connection ID. Save it as you will need it later.

{% endlist %}


### Create a project {#create-project}

{% include [speechsense-integration/create-project](../../_tutorials_includes/speechsense-integration/create-project.md) %}


## Set up export from {{ bitrix24-name }} to {{ speechsense-name }} {#bitrix24-export}


### Install the app in {{ bitrix24-name }} {#bitrix24-app}

{% list tabs group=instructions %}

- {{ bitrix24-name }} UI {#bitrix24}

  1. Navigate to **Market** in your {{ bitrix24-name }} account.
  1. In the search bar, enter `{{ speechsense-full-name }}`.
  1. Click **Install**.
  1. Check the **I have read and agree to...** boxes and click **Install**.
  1. Click **Open app**.

{% endlist %}


### Set up export from {{ bitrix24-name }} {#bitrix24-config}

{% list tabs group=instructions %}

- {{ bitrix24-name }} UI {#bitrix24}

  1. {% include [config-external-connection](../../_tutorials_includes/speechsense-integration/config-external-connection.md) %}

  1. Configure other settings:

      * Specify the period to export the calls for.

          {% note info %}

          The export will include the start and end dates.

          {% endnote %}

          To export all the calls you have so far, do not specify dates.

      * **User list**: Specify a comma-separated list of {{ bitrix24-name }} users whose calls you want to export (a list of your agents). To export calls for all users, leave the list empty.

      * **Call direction**: Select one or more options:

          * `All`: Exports calls of all types.
          * `Outgoing`: Export all outgoing calls.
          * `Incoming`: Export all incoming calls.
          * `Incoming, forwarded to mobile`: Export incoming calls that were
          redirected to the agent's mobile phone number.
          * `Callback`: Export calls requested by customers after filling out the CRM form.

      * **Minimum conversation time**: Specify the conversation duration in seconds. We recommend exporting calls that took 30 seconds or longer.
      * **Last processed call ID**: Non-editable field indicating which call was processed last. 

          To reset the field value, click **Reset**.

  1. Click **Save**.
  1. Click **Start export**.

      Wait for the export to complete.

{% endlist %}


## Check the result {#check-result}

{% include [check-result](../../_tutorials_includes/speechsense-integration/check-result.md) %}