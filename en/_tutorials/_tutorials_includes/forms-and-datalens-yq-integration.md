{% list tabs group=instruction %}

- {{ yq-name }} interface {#yquery}

  1. Navigate to the [management console]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq }}**.
  1. In the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab, click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Create a connection with the following parameters:
      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: `forms-connection`.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ objstorage-name }}`.
      * **{{ ui-key.yql.yq-binding-form.connection-bucket.title }}**: Name of the bucket you [created earlier](#create-s3-bucket).
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: `forms-integration-sa`.
  1. In the window that opens, set the data binding parameters:
      * **{{ ui-key.yql.yq-binding-form.connection-type.title }}**: `{{ objstorage-name }}`.
      * **{{ ui-key.yql.yq-binding-form.connection.title }}**: `forms-connection`.
      * **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}**: `/<form_ID>/`.
        You can copy the ID:
          * Under **{{ ui-key.yacloud.storage.bucket.switch_files }}** in the {{ objstorage-name }} bucket. The name of the folder containing the file with results of the completed form matches the form ID.
          * In the address bar of the [{{ forms-name }} interface]({{ link-forms-b2b }}), on the form viewing or editing page.        
      * **{{ ui-key.yql.yq-binding-form.binding-format.title }}**: `json_each-row`.
      * **{{ ui-key.yql.yq-binding-form.binding-fields.title }}**: Create columns for the fields you specified in the form.
        If you want {{ yq-name }} to define columns automatically, click **{{ ui-key.yql.yq-binding-form.title_infer-columns }}**.

{% endlist %}
