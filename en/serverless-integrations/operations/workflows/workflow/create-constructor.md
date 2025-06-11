---
title: How to create a workflow using the constructor
description: Follow this guide to create a workflow using the constructor.
---

# Creating a workflow using the constructor

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}**.
  1. Choose the `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}` method.
  1. Add the required workflow steps. For more information about configuring workflow steps using the constructor, see [{#T}](../constructor/index.md).
  1. {% include [workflows-additional-console](../../../../_includes/serverless-integrations/workflows-additional-console.md) %}
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}