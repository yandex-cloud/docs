# Integrating {{ postbox-full-name }} with external systems using webhooks


In this tutorial, you will set up streaming of [{{ postbox-full-name }}](../../postbox/index.yaml) events to [{{ yds-full-name }}](../../data-streams/index.yaml) and triggering [webhooks](https://en.wikipedia.org/wiki/Webhook) in external systems. To process and store data, you will use [{{ sf-full-name }}](../../functions/index.yaml) and [{{ ydb-full-name }}](../../ydb/index.yaml).

You can implement this solution using the {{ yandex-cloud }} [management console]({{ link-console-main }}) even if you have no coding skills.

To set up event streaming and processing:

1. [Get your cloud ready](#before-begin).
1. [Create service accounts](#service-accounts).
1. [Create a static access key](#static-key).
1. [Create a {{ ydb-name }}](#ydb).
1. [Create a data stream in {{ yds-name }}](#stream).
1. [Set up {{ postbox-name }} resources](#postbox).
1. [Set up {{ sf-name }} resources](#serverless-functions).
1. [Test the solution](#test-solution).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for {{ ydb-short-name }} operations and data storage (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)).
* {{ yds-short-name }} data storage fee (see [{{ yds-full-name }} pricing](../../data-streams/pricing.md)).
* Fee for function invocation count, computing resources allocated to run the function, and outbound traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Fee for using {{ postbox-name }} (see [{{ postbox-full-name }} pricing](../../postbox/pricing.md)).


## Create service accounts {#service-accounts}

Create two [service accounts](../../iam/concepts/users/service-accounts.md):

* `yds-functions` to call [{{ sf-name }}](../../functions/concepts/function.md) and write events to [{{ yds-short-name }}](../../data-streams/concepts/glossary.md#stream-concepts).
* `postbox-user` to send emails via {{ postbox-name }}.

1. Create a `yds-functions` service account:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** and click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, enter `yds-functions` for name.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `yds.editor` and `{{ roles-functions-invoker }}` [roles](../../iam/concepts/access-control/roles.md).
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    {% endlist %}

1. Similarly, create a service account named `postbox-user` and assign the `postbox.sender` [role](../../postbox/security/index.md#postbox-sender) to it.


## Create a static access key {#static-key}

Create a [static access key](../../iam/concepts/authorization/access-key.md) to use for sending emails:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** and then select `postbox-user` from the list of service acounts. In the window that opens, do the following:

      1. In the top panel, click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Save the ID and secret key.

          {% note alert %}

          After you close this dialog, the key value will no longer be available.

          {% endnote %}

{% endlist %}


## Create a database in {{ ydb-name }} {#ydb}

To create a data stream for {{ postbox-name }} events, you need a {{ ydb-name }} database. Create a [serverless {{ ydb-name }} database](../../ydb/concepts/resources.md#serverless):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}** and click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. In the **{{ ui-key.yacloud.ydb.forms.label_field_name }}** field, specify `postbox-events-ydb`.
  1. In the **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** field, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type_pB7Wx }}`.
  1. Do not edit the other database settings. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

  Wait for the database to start. While being created, your database will have the `Provisioning` status. Once it is ready for use, its status will change to `Running`.

{% endlist %}


## Create a data stream in {{ yds-name }} {#stream}

Create a [data stream](../../data-streams/concepts/glossary.md#stream-concepts) to log {{ postbox-name }} events:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}** and click **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
  1. In the **{{ ui-key.yacloud.data-streams.label_database }}** field, select the `postbox-events-ydb` database you created earlier.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter the stream name: `postbox-events-stream`.
  1. In the **{{ ui-key.yacloud.data-streams.label_meter-mode }}** field, select `{{ ui-key.yacloud.data-streams.label_request-units }}`.
  1. Do not edit the other data stream settings. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Wait for the stream to start. Once the stream is ready for use, its status will change from `Creating` to `Active`.


## Create {{ postbox-name }} resources {#postbox}

In {{ postbox-name }}, [configure](../../postbox/concepts/glossary.md#subscription) event logging to {{ yds-name }}, create a sender [address](../../postbox/concepts/glossary.md#adress), and [verify](../../postbox/operations/check-domain.md) your domain ownership.


### Create a {{ postbox-name }} configuration {#config}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/list-ul.svg) **{{ ui-key.yacloud.postbox.label_configuration-sets }}** and click **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the configuration name: `postbox-events-config`.
  1. Under **{{ ui-key.yacloud.postbox.label_event-destinations }}**, click **{{ ui-key.yacloud.common.add }}** and fill out the form that opens:

      1. In the **{{ ui-key.yacloud.postbox.label_name }}** field, specify the [subscription](../../postbox/concepts/glossary.md#subscription) name: `postbox-events-subscribe`.
      1. In the **{{ ui-key.yacloud.postbox.label_data-stream }}** field, select the [data stream](../../data-streams/concepts/glossary.md#stream-concepts) named `postbox-events-stream`.
      1. Toggle the **{{ ui-key.yacloud.common.enabled }}** option on to activate the subscription.

  1. Do not edit the other configuration settings. Click **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.

{% endlist %}


### Create a {{ postbox-name }} address {#address}

1. Generate the `privatekey.pem` key to create a DKIM signature by running this command in the terminal:

    ```bash
    openssl genrsa -out privatekey.pem 2048
    ```

    {% note info %}

    `openssl` comes preinstalled in Linux and macOS. If using Windows, you need to install it manually. For more information, visit the [project's website](https://openssl-library.org/).

    {% endnote %}

1. Create a {{ postbox-name }} address:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
      1. In the left-hand panel, select ![at](../../_assets/console-icons/at.svg) **{{ ui-key.yacloud.postbox.label_identities }}** and click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. In the **{{ ui-key.yacloud.postbox.label_address }}** field, specify the domain you will use to send emails. You can use a domain of any level, as long as you own it.
      1. In the **{{ ui-key.yacloud.postbox.label_selector }}** field, specify a selector, e.g., `postbox`. Make sure to only use this selector in the resource record you create when [verifying domain ownership](#domain).
      1. In the **{{ ui-key.yacloud.postbox.label_configuration-set }}** field, select `postbox-events-config` you previously created.
      1. In the **{{ ui-key.yacloud.postbox.label_private-key }}** field, paste the contents of the `privatekey.pem` file from the previous step.
      1. Do not change the other address settings. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. Click the newly created address in the list that opens.
      1. Under **{{ ui-key.yacloud.postbox.label_signature-verification }}** on the address info page, copy and save the [TXT record](../../dns/concepts/resource-record.md#txt) from the **{{ ui-key.yacloud.postbox.label_dns-record-value }}** field.

    {% endlist %}


### Verify your domain ownership {#domain}

{% include [check-domain](../../_includes/postbox/check-domain.md) %}


## Create {{ sf-name }} resources {#serverless-functions}

Create a [function](../../functions/concepts/function.md) to send a webhook and a [trigger](../../functions/concepts/trigger/index.md) to call that function upon event logging to the data stream.


### Create a function {#function}

{% list tabs group=programming_language %}

- Python {#python}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Create a function:

      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter the function name: `postbox-webhook`.
      1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Create a function version:

      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** window that opens, select `{{ python-full-ver }}`.
      1. Disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Create the following two files:
      
          * `requirements.txt` with the list of required dependencies:

              ```text
              requests
              ```
          * `assistant-analyst.py` with the following function code:
  
              ```python
              import requests

              # URL of the webhook to call
              WEBHOOK_URL = "<webhook_URL>"


              def handler(event, context):
                  requests.post(WEBHOOK_URL, json=event)

                  return {
                      "statusCode": 200,
                  }
              ```
              
              Where `WEBHOOK_URL` is the URL of the webhook to send the request to.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `index.handler`.
      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `10 {{ ui-key.yacloud_billing.common.units.label_time-sec_many }}`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.

      1. Do not edit the other function version settings. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- JavaScript {#node}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Create a function:

      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter the function name: `postbox-webhook`.
      1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Create a function version:

      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** window that opens, select `{{ nodejs-full-ver }}`.
      1. Disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Create a file named `index.js` with the function code:

          ```js
          // URL of the webhook to call
          const WEBHOOK_URL = '<webhook_URL>'

          module.exports.handler = async function (event, context) {
              await fetch(WEBHOOK_URL, {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json',
                  },
                  body: JSON.stringify(event),
              });
 
              return {
                  statusCode: 200,
              };
          };
          ```

          Where `WEBHOOK_URL` is the URL of the webhook to send the request to.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `index.handler`.
      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `10 {{ ui-key.yacloud_billing.common.units.label_time-sec_many }}`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.

      1. Do not edit the other function version settings. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}


### Create a trigger {#trigger}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}** and click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** field, enter the trigger name: `postbox-events-trigger`.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}`.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}**, select the data stream named `postbox-events-stream` and the `yds-functions` service account.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select the `postbox-webhook` function and the `yds-functions` service account.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}


## Test the solution {#test-solution}

1. Use the {{ postbox-name }} address and static access key you created earlier to [send](../../postbox/operations/send-email.md#send-email) several test emails in any way you prefer.
1. Make sure the emails were delivered by checking the mailbox you sent them to.
1. Make sure the data about sent emails reaches the services:

    * Check the data stream:

        {% list tabs group=instructions %}

        - Management console {#console}

          1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
          1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
          1. Select the data stream named `postbox-events-stream`.
          1. Navigate to the ![text-align-justify](../../_assets/console-icons/text-align-justify.svg) **{{ ui-key.yacloud.data-streams.label_data-introspection }}** tab.

              The charts should show email sending events.

        {% endlist %}

    * View the [function logs](../../functions/operations/function/function-logs.md) and [trigger monitoring charts](../../functions/operations/trigger/trigger-monitoring.md).
    * Make sure the webhooks for the sent email events were triggered in the external system.

After completing this tutorial, you will be able to trigger webhooks in external systems in response to {{ postbox-full-name }} email sending events.


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../functions/operations/trigger/trigger-delete.md) the trigger invoking the function in {{ sf-name }}.
1. [Delete](../../functions/operations/function/function-delete.md) the function in {{ sf-name }}.
1. [Delete](../../data-streams/operations/manage-streams.md#delete-data-stream) the stream in {{ yds-name }}.
1. [Delete](../../ydb/operations/manage-databases.md#delete-db) the {{ ydb-name }} database.
1. Delete the {{ postbox-name }} address and configuration.
1. Optionally, [delete](../../iam/operations/sa/delete.md) the service accounts.
1. Optionally, delete the [resource record](../../dns/operations/resource-record-delete.md) and [public DNS zone](../../dns/operations/zone-delete.md).