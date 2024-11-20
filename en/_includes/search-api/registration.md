{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you are going to use to work with {{ search-api-name }} or [create a new one](../../resource-manager/operations/folder/create.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_search-api }}**.
  1. Fill in the form fields: 
       * Select the **{{ ui-key.yacloud.component.ip-address-form.label_field-search-type }}**: `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}`, `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}`, or `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}`.
       * Set at least one trusted IP address to send requests to the Yandex search database from.

           You can send requests to {{ search-api-name }}'s API v1 only from one of the IP addresses added to the service settings during registration. Attempts to run a request from a non-registered IP address will be rejected.

  1. Click **{{ ui-key.yacloud.component.ip-address-form.label_button-save }}**.

  After that, you will be able to change the search type and the trusted IP address list. In the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.iam.folder.dashboard.label_search-api }}** service and click ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.search-api.overview.label_button-edit }}** in the top-right corner.

{% endlist %}