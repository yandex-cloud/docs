# Delivering data from {{ forms-full-name }} to {{ datalens-full-name }} using {{ sf-full-name }} and {{ yq-full-name }} via the management console


To set up integration of {{ forms-name }} and {{ datalens-name }} via the management console, follow these steps:

1. [Set up your infrastructure](#prepare-infrastructure).
1. [Create a {{ sf-full-name }} function](#create-function).
1. [Create a form in {{ forms-name }}](#create-form).
1. [Configure a connection and binding to data in {{ yq-full-name }}](#yq-integration).
1. [Set up fetching data in {{ datalens-name }}](#set-up-datalens).
1. [Test the new resource integration](#test-forms-integration).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/forms-and-datalens-paid-resources.md) %}

## Set up your infrastructure {#prepare-infrastructure}

### Create a service account {#create-service-account}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md): `forms-integration-sa`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the following roles. 
      * [lockbox.payloadViewer](../../iam/roles-reference.md#lockbox-payloadViewer): For reading {{ lockbox-full-name }} secrets.
      * [functions.functionInvoker](../../iam/roles-reference.md#functions-functionInvoker): For invoking the {{ sf-name }} function.
      * [storage.editor](../../iam/roles-reference.md#storage-editor): For reading data from, and writing data to, an {{ objstorage-name }} bucket.
      * [yq.viewer](../../iam/roles-reference.md#query-viewer) and [yq.invoker](../../iam/roles-reference.md#query-invoker): For integrating {{ datalens-name }} and {{ yq-name }}.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Create an {{ objstorage-name }} bucket {#create-s3-bucket}

The {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) will store data from {{ forms-name }}. 

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Enter the bucket **{{ ui-key.yacloud.storage.bucket.settings.field_name }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Assign access permissions for the bucket to the service account {#assign-access-rights-for-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Open the bucket you [created earlier](#create-s3-bucket).
  1. Go to **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
  1. In the **{{ ui-key.yacloud.component.acl-dialog.label_title }}** window that opens:

      1. Start typing the service account name, `forms-integration`, and select it from the drop-down list.
      1. Select the {{ ui-key.yacloud.storage.permissions-dialog.label_role-write }} access permissions.
      1. Click **{{ ui-key.yacloud.common.add }}**.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Create a static key for the service account {#create-static-key-for-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Select the `forms-integration` service account.
  1. Go to **{{ ui-key.yacloud.iam.folder.service-account.switch_overview }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. In the window that opens, **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_label_title }}**, you will see **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id-title }}** and **{{ ui-key.yacloud.iam.folder.service-account.overview.label_secret-key-title }}**. Save them, as you will need them later.

{% endlist %}

### Create a {{ lockbox-name }} secret for the static key {#create-lockbox-secret}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. Enter the secret's **{{ ui-key.yacloud.common.name }}**: `static-key`.
  1. Under **{{ ui-key.yacloud.lockbox.forms.title_secret-data-section }}**:
      1. Select **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}**: **{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}**.
      1. Create the following key-value pairs:
          * Static key ID:

              * **{{ ui-key.yacloud.lockbox.label_password-key }}**: `static-key-id`.
              * **{{ ui-key.yacloud.lockbox.forms.title_version-payload-entries-value-placeholder }}**: Select **{{ ui-key.yacloud.lockbox.forms.value_payload-entry-value-type-text }}** and enter the ID of the static key you created earlier.

          * Static key value:

              * **{{ ui-key.yacloud.lockbox.label_password-key }}**: `static-key-value`.
              * **{{ ui-key.yacloud.lockbox.forms.title_version-payload-entries-value-placeholder }}**: Select **{{ ui-key.yacloud.lockbox.forms.value_payload-entry-value-type-text }}** and enter the value of the static key you created earlier.

{% endlist %}

## Create and configure a {{ sf-name }} function {#set-up-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Create a function:
      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}** in the top-right corner.
      1. Enter the function **{{ ui-key.yacloud.common.name }}**: `forms-function`.  
      1. Click **{{ ui-key.yacloud.common.create }}**.

  1. Create a function version:  
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** window that opens, select the runtime environment: **Python**.
      1. Disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Select the function creation **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}**: **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}**.
      1. In the function editor window, click **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**.
      1. In the window that opens, enter the file **{{ ui-key.yacloud.serverless-functions.item.editor.create-form-file-path }}**: `forms-integration.py`. Click **{{ ui-key.yacloud.common.create }}**.
      1. Paste the function code to the `forms-integration.py` file:
          
          ```python
          import boto3
          import os
          import json
          from botocore.config import Config

          def get_answers(raw_answers: json) -> json:
              result = {}
              for name, value in raw_answers.get('answer').get('data').items():
                  if name.startswith('answer_choices_'):
                      choices = []
                      for c in value.get('value'):
                          choices.append(c.get('text'))
                      result[name] = ','.join(choices)
                  else:
                      result[name] = value.get('value')
              return result

          def handler(event, context):
              headers = event.get('headers')
              form_id = headers.get('X-Form-Id')
              answer_id = headers.get('X-Form-Answer-Id')

              body_json = json.loads(event.get('body'))
              answers_json = get_answers(body_json)

              aws_access_key_id = os.environ['KEY']
              aws_secret_access_key = os.environ['SECRET_KEY']
              bucket_name = os.environ['BUCKET']

              s3 = boto3.client(service_name='s3',
                                aws_access_key_id=aws_access_key_id,aws_secret_access_key=aws_secret_access_key,
                                endpoint_url='https://storage.yandexcloud.net', region_name='ru-central1',
                                config=Config(request_checksum_calculation="when_required"))

              s3.put_object(Bucket=bucket_name, Key=f"{form_id}/{answer_id}.json", Body=json.dumps(answers_json))

              return {
                  'statusCode': 200,
                  'body': "OK",
                  'headers': {
                      'Content-Type': 'text/plain',
                  }
              }

          ```
          
      1. In the function editor window, click **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**.
      1. In the window that opens, enter the file **{{ ui-key.yacloud.serverless-functions.item.editor.create-form-file-path }}**: `requirements.txt`. Click **{{ ui-key.yacloud.common.create }}**.

      1. In `requirements.txt`, specify the `boto3` library for accessing {{ objstorage-name }} from your function:

         ```
         boto3
         ```

      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `forms-integration.handler`.

      1. In the **{{ ui-key.yacloud.forms.label_service-account-select }}** field, select the previously created account named `forms-integration-sa`.

      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**, create a variable containing the bucket name where the function results will be stored:

          1. **Key**: `BUCKET`.
          1. **Value**: Name of the bucket you [created earlier](#create-s3-bucket).

      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**:

          1. Create a `KEY` variable for the static key ID. Set the parameters as follows:

              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-env-key }}**: `KEY`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-id }}**: Select the `static-key-id` secret.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-version-id }}**: Select the version marked `latest`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-key }}**: Select `static-key-id`.

          1. Create a `SECRET_KEY` variable for the static key ID. Set the parameters as follows:

              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-env-key }}**: `SECRET_KEY`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-id }}**: Select the `static-key-value` secret.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-version-id }}**: Select the version marked `latest`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-key }}**: Select `static-key-value`.  

      1. Once your function is created, on the **{{ ui-key.yacloud.common.overview }}** tab, enable **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**:
          

{% endlist %}

## Create and set up a {{ forms-name }} form {#set-up-form}

{% include [set-up-form](../_tutorials_includes/forms-and-datalens-set-up-form.md) %}

## Configure a connection and binding to data in {{ yq-name }} {#yq-integration}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-yq-integration.md) %}

## Set up fetching data in {{ datalens-name }} {#set-up-datalens}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-set-up-datalens.md) %}

## Test the new resource integration {#test-forms-integration}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-test-integration.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. {{ datalens-name }} chart.
1. {{ datalens-name }} dataset.
1. {{ datalens-name }} connection.
1. [{{ yq-name }} binding](../../query/operations/binding.md#delete).
1. [{{ yq-name }} connection](../../query/operations/connection.md#delete).
1. [{{ sf-name }} function](../../functions/operations/function/function-delete.md).
1. [{{ lockbox-name }} secret](../../lockbox/operations/secret-delete.md).
1. [{{ objstorage-name }} buckets](../../storage/operations/buckets/delete.md).
