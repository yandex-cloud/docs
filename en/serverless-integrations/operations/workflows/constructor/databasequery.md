---
title: Adding execution of SQL queries against databases to a workflow in {{ sw-name }}
description: Follow this guide to add execution of SQL queries against databases to a workflow in {{ sw-full-name }} using the workflow step constructor.
---

# Running SQL queries against databases

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![database-magnifier](../../../../_assets/console-icons/database-magnifier.svg) **Database Query** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **Database Query** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. Under **Connection parameters**, select:

          * `Connection`, to create a connection to the database.

              1. In the field, specify the following:

                  * **Database type**: Type of the database to connect to.

                      For a {{ MY }} database, set the `utf8mb4` encoding for field values.

                  * **Host**: Database server address.
                  * **Port**: Port for connection to the database.
                  * **Database**: Database name.

              1. Select **Use SSL** to connect to the database over SSL.

                  Selecting this option:
                  * Enables SSL encryption for a {{ PG }} database. 
                  * Allows secure SSL connections for a {{ CH }} database.

              1. Under **Authentication**, select:

                  * `Password` to connect to the database using a username and password. Enter the username and select:

                      * `Lockbox` to store the password in a {{ lockbox-full-name }} secret. Under **Secret**, select the secret, its [version](../../../../lockbox/concepts/secret.md#version), and the key used to store the password.

                          If you do not have a {{ lockbox-name }} secret, click **Create** to create one.

                      * `Text` to store the password in the specification as text. Enter the password in the **Value** field.

                          {% note warning %}

                          It is not safe to store your password in the specification in plain text.

                          {% endnote %}

                  * `IAM token` to connect to the database using an IAM token of the service account specified in the workflow settings.

                      {% note info %}

                      Authentication by IAM token is only supported for {{ ydb-short-name }} databases.

                      {% endnote %}

          * `DSN` to specify a database connection string.

      1. In the **SQL query** field, specify the SQL query you need to execute.
      1. In the **Execution method** field, select:

          * `Exec`: To execute the SQL query and return the service fields only, e.g., `RowsAffected` and `LastInsertId`.
          * `Query`: To execute the SQL query and return the result.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/databasequery.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
