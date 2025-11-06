To set up {{ speechsense-name }} integration with [{{ amocrm-name }}](https://www.amocrm.ru/):

1. [Get your cloud ready](#before-you-begin).
1. [Set up export from {{ amocrm-name }} to {{ speechsense-name }}](#amocrm-export).
1. [Check the result](#check-result).

{% include [prepare-cloud](../_tutorials_includes/speechsense-integration/prepare-cloud.md) %}


### Create a connection {#create-connection}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

  1. In the {{ speechsense-name }} [UI]({{ link-speechsense-main }}), go to the space of your choice.
  1. In the top-right corner, click **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
  1. Enter the connection name.
  1. Select the `{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}` data type.
  1. Under **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}** and **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**, specify:

      1. Channels with the agent's and customer's voices.
      1. Agent and customer keys from the metadata file. This file contains the call information collected from CRM systems, PBXs, or other sources.

        By default, connections include keys with the name and ID of the agent and the customer. In the **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** field, enter the name the key will have in {{ speechsense-name }}.

        To specify additional metadata for the agent and the customer, click **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. Under **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}**, provide the keys from the metadata file that are not related to the agent or the customer:

      * In the **Key** field, enter the field name to use when mapping fields in the exchange module settings. For example: `Call date` → `call_date`. Also, specify the name used in the system and add a description to display in {{ speechsense-name }} forms and reports.
      * Currently, the **Type** field only supports the `String` value.

      By default, connections include keys with the date, direction, and language of the call. In addition, you can specify the keys you want to receive from the external system. In the **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** field, enter the name the key will have in {{ speechsense-name }}.

      To provide additional metadata, click **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. Click **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
  1. Click **ID** ![image](../../_assets/console-icons/copy-transparent.svg) in the top-left corner of the connection page to copy the connection ID. Save it as you will need it later.

{% endlist %}


### Create a project {#create-project}

{% include [speechsense-integration/create-project](../_tutorials_includes/speechsense-integration/create-project.md) %}


## Set up export from {{ amocrm-name }} to {{ speechsense-name }} {#amocrm-export}


### Install the app in {{ amocrm-name }} {#amocrm-app}

{% list tabs group=instructions %}

- {{ amocrm-name }} UI {#amocrm}

  1. Navigate to **amoMarket** in your {{ amocrm-name }} account.
  1. In the search bar, enter `Export to {{ speechsense-name }}`.
  1. Click **Install for free**.
  1. Check the **I agree to the collection of personal data...** box.
  1. Click **Install**.
  1. In the **Description** tab, click **Save**.

      The app will be displayed in the **Installed** tab in **amoMarket**.

{% endlist %}


### Set up export from {{ amocrm-name }} {#amocrm-config}

{% list tabs group=instructions %}

- {{ amocrm-name }} UI {#amocrm}

  1. Navigate to **Settings** in your {{ amocrm-name }} account.
  1. Go to the **{{ speechsense-name }} export settings** tab.
  1. {% include [config-external-connection](../_tutorials_includes/speechsense-integration/config-external-connection.md) %}

  1. Configure other settings:

      * Specify the period to export the calls for.

          {% note info %}

          The export will include the start and end dates.

          {% endnote %}

      * **User list**: Specify the {{ amocrm-name }} users whose calls you want to export (a list of your agents). To export calls for all users, leave the list empty.

      * **Call direction**:

          * `All`: Export calls of all types.
          * `Outgoing`: Export only outgoing calls.
          * `Incoming`: Export only incoming calls.

      * **Re-export calls**: Enable this option if you need to re-export calls that were previously exported, e.g., to a new {{ speechsense-name }} connection or workspace. When this option is on, the system will not check if the calls were previously exported and will export all calls once again.
      * Set the minimum and maximum conversation duration in seconds. To export all calls, leave the `0` values.
      * Configure field mapping in {{ amocrm-name }} and {{ speechsense-name }}:

          1. In the **{{ amocrm-name }}** column, select the field key in {{ amocrm-name }}.
          1. In the **{{ speechsense-name }}** column, enter the key of the field from the {{ speechsense-name }} connection you created [earlier](#create-audio-connection).

          To add a new mapping, click ![image](../../_assets/console-icons/plus.svg) **Add**.

          {% note info %}

          Calls can be associated with different {{ amocrm-name }} entities. Depending on the entity, i.e., a deal, contact, company, or call, the metadata provided with each call may vary. The associated entities are grouped into separate blocks.

          {% endnote %}

  1. Click **Save settings**.
  1. Click **Start export**.

      Wait for the export to complete.

      {% note tip %}

      To force stop the export, click **Stop export**.

      {% endnote %}

{% endlist %}


## Check the result {#check-result}

{% include [check-result](../_tutorials_includes/speechsense-integration/check-result.md) %}