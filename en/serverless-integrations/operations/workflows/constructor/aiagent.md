---
title: Adding integration with an AI agent to a {{ sw-name }} workflow
description: Follow this guide to add integration with an AI agent to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Integration with an AI agent

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **Integration steps** section on the left side of the screen, drag the ![foundation-models-icon](../../../../_assets/foundation-models-icon.svg) **AI agent** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **AI agent** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. Under **AI agent settings**:

          1. In the **Model** field, select a large language model for the AI agent to use.
          1. In the **Role** field, describe the role that defines the AI agent's functions and experience, e.g., `car parts consultant`.
          1. In the **Goal** section, describe an individual goal that guides the AI agent's decision-making, e.g., `help with the choice of parts for the specified vehicle`.
          1. Optionally, in the **Backstory** field, specify a backstory defining the AI agent's personality and enriching the context, e.g., `you find the best value for money car parts and briefly explain your choice`.
          1. Optionally, under **Knowledge sources**, click ![plus](../../../../_assets/console-icons/plus.svg) to specify knowledge sources for the AI agent. Select:
              * `Text`: For a text-based knowledge source.
              * `File`: For a file-based knowledge source:

                  1. Select the type of the knowledge source file.
                  1. Select a data source:
                      * `Public URL`: Add a public URL to the file.
                      * `{{ objstorage-name }}`: Specify names of the [bucket](../../../../storage/concepts/bucket.md) and [object](../../../../storage/concepts/object.md) containing your file, e.g., `prefix/subprefix/data.json`.
          1. Optionally, under **Tools**, click ![plus](../../../../_assets/console-icons/plus.svg) and add a tool for your AI ​agent to use for obtaining external data when generating a response:
              * In the **MCP server address** field, enter your MCP server URL, e.g., `https://mcp.example.com/sse`.
              * In the **Transport** field, select a transport mechanism type for interacting with the MCP server:

                  * `STREAMABLE`: Your AI ​agent receives updates (events) from the server with no need for a persistent HTTP connection. Data exchange between the AI ​agent and the server is bidirectional.
                  * `SSE`: Your AI ​agent receives updates from the server over a persistent HTTP connection. Data is only transmitted from the server to the AI ​agent.
              * In the **Authorization** field, specify data required to authorize the AI agent on the MCP server:

                  * `No authorization`: MCP server requires no agent authorization.
                  * `OAuth token`: MCP server requires an [OAuth token](../../../../iam/concepts/authorization/oauth-token.md) for agent authorization. Specify the OAuth token or {{ lockbox-full-name }} [secret](../../../../lockbox/concepts/secret.md) that stores the token. Select:

                      {% include [oauth](../../../../_includes/serverless-integrations/workflows-constructor/oauth.md) %}

                  * `IAM token`: MCP server requires an [IAM token](../../../../iam/concepts/authorization/iam-token.md) for agent authorization. The system automatically issues this IAM token for the [service account](../../../../iam/concepts/users/service-accounts.md) associated with the workflow.

      1. Optionally, under **Tasks**, use ![plus](../../../../_assets/console-icons/plus.svg) to set the tasks the AI agent has to complete:

          * In the **Task description** field, describe the essence of the task you want the AI agent to perform, e.g., `find an oil filter for a BMW 320i`.
          * Optionally, in the **Expected result** field, describe the format you expect to get the result in, e.g., `a list of addresses of stores selling the car parts you need`.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/aiagent.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
