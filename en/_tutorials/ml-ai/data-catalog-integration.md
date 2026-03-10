# Integration with {{ data-catalog-full-name }}

You can use an AI assistant to search and analyze patterns in [metadata catalogs](../../metadata-hub/concepts/data-catalog.md) deployed in {{ data-catalog-name }}. To do that, you need to connect the {{ data-catalog-name }} MCP server to {{ mcp-hub-name }}. The server allows you to request the list of metadata catalogs, search through metadata, and obtain its lineage graph at the table and column level for use in the context of conversation with agents.

To set up integration with {{ data-catalog-name }} in {{ ai-studio-name }}:

1. [Set up your infrastructure](#infra).
1. [Prepare the metadata catalog](#prepare-data-catalog).
1. [Connect an external MCP server](#connect-mcp).
1. [Test a conversation with the agent](#test-solution).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The integration infrastructure cost includes a fee for {{ agents-atelier-name }} based on the number of tokens in request and response (see [{{ foundation-models-full-name }} pricing](../../ai-studio/pricing.md)). You start paying for the agent as soon as you activate it.


## Set up your infrastructure {#infra}

### Create a folder and network {#create-folder}

Create a resource folder to host your metadata catalog.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Name your folder, e.g., `data-folder`.
   1. Select **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. This will create a [network](../../vpc/concepts/network.md#network) with subnets in each [availability zone](../../overview/concepts/geo-scope.md).
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

### Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. Navigate to `data-folder`.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Name the [service account](../../iam/concepts/users/service-accounts.md), e.g., `sa-for-mcp-server`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `data-catalog.user` for access to the metadata catalog resources.
      * `serverless.mcpGateways.invoker` for access to the MCP server in {{ mcp-hub-name }}.
      * `serverless.mcpGateways.anonymousInvoker` for access to the external MCP server.

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Prepare the metadata catalog {#prepare-data-catalog}

### Create a metadata catalog {#create-catalog}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [resource folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a metadata catalog.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Click **{{ ui-key.yacloud.data-catalog.label_create-catalog }}**.
    1. In the **{{ ui-key.yacloud.common.name }}** field, enter the catalog name, `test-sales`.
    1. Click **{{ ui-key.yacloud.common.create }}**.

    {% include [ai-on](../../_includes/metadata-hub/data-catalog-ai-markup-on.md) %}

{% endlist %}

### Create a metadata source {#create-source}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the left-hand panel, select ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.data-catalog.label_sources }}**.
    1. Click **{{ ui-key.yacloud.data-catalog.label_create-source-button }}**.
    1. Specify `test-sales-source` as the source name.
    1. Select the type of the backend that will supply metadata for analysis. Once the source is created, you cannot change the database type. Available backends:

       {% include notitle [sources](../../_includes/metadata-hub/data-catalog-sources.md) %}

    1. Specify the source parameters for the selected database type:

        {% include [source-parameters](../../_includes/metadata-hub/data-catalog-source-parameters.md) %}

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create and start a data ingestion {#create-ingestion}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}**.
  1. Click **{{ ui-key.yacloud.data-catalog.label_create-ingestion-action }}**.
  1. Specify the ingestion settings:

      * In the **{{ ui-key.yacloud.common.name }}** field, enter `load-sales` as the ingestion name.
      * Select the metadata source you [created earlier](#create-source).
      * Specify the ingestion configuration for the data source:

         * Select **{{ ui-key.data-catalog.console.form.cron.Cron.none.title }}** for the ingestion schedule.
         * Optionally, under **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.data_filters.title }}**, use regular expressions to specify which databases and database objects to include in or exclude from the ingestion.

         {% include [metadata-profiling](../../_includes/metadata-hub/metadata-profiling.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. In the list of ingestions, click ![image](../../_assets/console-icons/ellipsis.svg) in the line with your new ingestion and select **{{ ui-key.yacloud.common.start }}**.
  
     During ingestion, the AI assistant will automatically mark up the data. Once successfully completed, the ingestion will get the **{{ ui-key.yacloud.data-catalog.label_ingestion-status-Success }}** status.

  1. To view ingested and marked-up data, select ![image](../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}** in the left-hand panel.

     The page displays the info about the data, i.e., data source, database, and tables.

     {% note info %}

     The AI assistant automatically creates entities for metadata markup (domains, glossaries, tags, classifications, and terms) and their descriptions. You can confirm, edit, or reject the markup suggested by your AI assistant by hovering over the **{{ ui-key.yacloud.data-catalog.label_ai-label }}** icon next to the suggestion and selecting the action.

    {% endnote %}

{% endlist %}

## Connect an external MCP server {#connect-mcp}

### Connecting in {{ ai-studio-name }} {#mcp-ai-studio}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to `data-folder`.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. In the left-hand panel, select ![logo-mcp](../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}** and click **{{ ui-key.yacloud.yagpt.YaGPT.McpServersList.label_create-mcp-gateway_3o3Vu }}**. In the window that opens:

      1. Under **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.type_dZSaw }}**, select ![plug-connection](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.form-view_connect_bS8yQ }}**.
      1. Under **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.tools_gkQfS }}**, click **{{ ui-key.yacloud.yagpt.YaGPT.ConnectMcpTools.add-mcp-tool_dyEgv }}**. In the window that opens, configure the MCP server connection:

         * **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.transport_q3nD6 }}**: **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.transport_streamable_eV7Rb }}**.

         * **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.url_bUhZ1 }}**: `https://datacatalog-consumer.mcp.cloud.yandex.net/mcp`

         * **Authorization type**: `{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.mcp-authorization_header_fdGKe }}`.

         * Under **Authorization header**, set the **Value** field to `Bearer <IAM_token>`. To do it, get an [IAM token](../../iam/concepts/authorization/iam-token.md) for the service account [created earlier](#create-sa), then paste it into the field.

            {% note info %}

            {% include [iam-token-lifetime](../../_includes/iam-token-lifetime.md) %}

            {% endnote %}

      1. Click **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.connect_xY9Zw }}**.
      1. In the **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.add-tools_ih6PU }}** window that opens, select all tools and click **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.add_47STV }}**.

      1. Under **Server parameters**:

          1. {% include [create-server-console-general-params-ss1](../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. In the **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.access-type_aPzxZ }}** field, select **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.access-type_private_b4gkg }}**.
          1. In the **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.service-account_h3ujf }}** field, select the service account you previously created.
          1. {% include [create-server-console-general-params-ss5](../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Click **{{ ui-key.yacloud.common.save }}**.

  1. In the left-hand panel, select ![logo-agent](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.yagpt.YaGPT.agents_2h9Sa }}** and click **{{ ui-key.yacloud.yagpt.YaGPT.create-agent_1txyW }}**.
  1. Specify the agent settings:
     * **{{ ui-key.yacloud.yagpt.YaGPT.name_hTzhB }}**: Agent name.
     * **{{ ui-key.yacloud.yagpt.YaGPT.Assistant.model_iyopt }}**: Language model.
     * Under **{{ ui-key.yacloud.yagpt.YaGPT.agent_instruction_9oe6q }}**, select a ready-made system instruction template for the agent or describe how the agent should behave and what it should do.
     * Under **{{ ui-key.yacloud.yagpt.YaGPT.AgentForm.tools_title_9yUpx }}**:
       * Click **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.add_47STV }}** and select **{{ ui-key.yacloud.yagpt.YaGPT.AgentForm.add-mcp-tool_gqwmZ }}**.
       * In the list, select the MCP server you created earlier and click **{{ ui-key.yacloud.yagpt.YaGPT.AgentForm.select_dPVTq }}**.
       * In the **{{ ui-key.yacloud.yagpt.YaGPT.mcp-tool_all-tools_gZA6P }}** field, select **{{ ui-key.yacloud.yagpt.YaGPT.mcp-tool_require-approval-policy_never_qPvRW }}**.
       * Click **{{ ui-key.yacloud.yagpt.YaGPT.AgentForm.save-and-continue_u1Wis }}**.

{% endlist %}

### Connecting to an external AI agent {#mcp-connect-agent}

1. Get an [IAM token](../../iam/concepts/authorization/iam-token.md) for the service account you [created earlier](#create-sa).
   
   {% note info %}

   {% include [iam-token-lifetime](../../_includes/iam-token-lifetime.md) %}

   {% endnote %}

1. Specify the {{ data-catalog-name }} MCP server configuration for your agent:

   ```json
   {
     "mcpServers": {
       "yandex-cloud-datacatalog-consumer": {
         "type": "streamableHttp",
         "url": "https://datacatalog-consumer.mcp.cloud.yandex.net/mcp",
         "headers": {
           "Authorization": "Bearer <IAM_token>"
         }
       }
     }
   }
   ```

## Test a conversation with the agent {#test-dialog}

{% note tip %}

If using the agent in {{ ai-studio-name }}, do the testing in the right-hand **{{ ui-key.yacloud.yagpt.YaGPT.AssistantChat.test-assistant-title_6ZNFg }}** panel.

{% endnote %}

1. Start a conversation with the agent by specifying the data catalog ID as shown below:

   ```text
   Use the marked-up data in the apah36iavgh5******** data catalog.
   ```

1. Use the examples of prompts to respond to which the agent will be analyzing the marked-up data from {{ data-catalog-name }}. It is assumed that the data contains sales-related information:

   * `Write an SQL query to generate YoY sales analytics`.
   * `Find all tables with user payment information`.
   * `Which tables are marked as containing sensitive data?`
   * `Where does the customer_transactions table get its data from?`
   * `Help find the tables needed to calculate the user retention metric`.
   * `Where can I find the website users' behavior data?`
   * `Which data should I use to analyze sales funnel conversion rate?`
   * `Show all dependencies of the transactions table to see how schema changes affect it`.
