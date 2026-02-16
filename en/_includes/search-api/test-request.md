To interactively explore the principle of formation of {{ search-api-name }} search queries via API v1, use the special query testing form:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you are going to use to work with {{ search-api-name }}.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_search-api }}**.
  1. In the left-hand panel, select ![SquareChartColumn](../../_assets/console-icons/square-chart-column.svg) **{{ ui-key.yacloud.search-api.test-query.label_title }}**. 
  1. Select a **{{ ui-key.yacloud.search-api.test-query.label_field-method }}** ([GET](../../search-api/concepts/get-request.md) and [POST](../../search-api/concepts/post-request.md) methods are supported) and fill in the form fields.

      {% note info %}

      You cannot edit the **{{ ui-key.yacloud.search-api.test-query.label_field-query }}** in a test query. Queries are submitted from a Yandex IP address on behalf of the service.

      {% endnote %}

      As the values in the form fields change, the search query URL for the specified values will be formed in the **{{ ui-key.yacloud.search-api.test-query.label_section-url }}** field. If you select the `POST` method, a relevant [query body](../../search-api/concepts/post-request.md#post-request-body) will be formed in the **{{ ui-key.yacloud.search-api.test-query.label_field-body }}** field.

  1. Click **{{ ui-key.yacloud.search-api.test-query.label_button-run-test }}**. The query execution [result](../../search-api/concepts/response.md) will be displayed below.
  1. If necessary, change the parameters to adjust the search results and resubmit your query.

{% endlist %}