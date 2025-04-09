### Create an API key {#create-api-key}

You need an [API key](../../iam/concepts/authorization/api-key.md) to set up integration with {{ forms-name }}.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Select the `forms-integration` service account.
  1. Go to **{{ ui-key.yacloud.iam.folder.service-account.switch_overview }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. In the window that opens, **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_label_title }}**, you will see **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id-title }}** and **{{ ui-key.yacloud.iam.folder.service-account.overview.label_secret-key-title }}**. Save them, as you will need them later.

{% endlist %}

### Create a form {#create-form}

{% list tabs group=instructions %}

- {{ forms-name }} interface {#forms}

  1. Go to [{{ forms-name }}]({{ link-forms-b2b }}).

  1. Click **Create form**.

  1. Add at least two fields to the form and set up any questions in them.

  1. Click **Publish**.

  1. Save the link to the published form: you will need it later.

{% endlist %}

### Set up integration with a {{ sf-name }} function {#set-up-integration}

{% list tabs group=instructions %}

- {{ forms-name }} interface {#forms}

  1. Go to [{{ forms-name }}]({{ link-forms-b2b }}).

  1. Open the form you created earlier.

  1. Go to the **Settings** tab.

  1. Open the **Additional** section.

  1. Under **Cloud function key**, enter the data of the [previously created API key](#create-api-key) and click **Save**.

  1. Open the **Integrations** tab.

  1. Click **Cloud Functions** to add a condition for the integration.

  1. In the **Function code** field, enter the {{ sf-name }} function ID. You can copy the ID in the **{{ ui-key.yacloud.common.overview }}** section of the {{ sf-name }} function in the management console.

  1. In the **Show outcome notification** field, select **Show**.

  1. Click **Save**.

{% endlist %}

### Test the integration you created {#test-integration}

1. Follow the public link to the previously created form.

1. Complete the form and click **Submit**.

1. Go to [{{ forms-name }}]({{ link-forms-b2b }}).

1. Open the form you created earlier.

1. Open the **Integrations** tab.

1. Go to the **Completed integrations** page.

1. Open the completed action record and make sure that the **Response** section contains the `200 — OK` response.

1. Navigate to the [management console]({{ link-console-main }}) and open the [bucket created earlier](#create-s3-bucket). Make sure the bucket now contains a JSON file with the data from the form you completed.

   The name of the directory the file will reside in matches the form's internal ID. Save this ID for the next steps.

   All the future form completion outcomes will be saved in this directory.

1. Complete the form several times more, and make sure you fill one of the fields in the same way in at least two forms. This will improve data visualization when testing the integration.
