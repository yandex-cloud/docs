To deploy the auto-reply service for Wildberries reviews:

1. [Get your cloud ready](#before-begin).
1. [Get a Wildberries API token](#wb-token).
1. [Get the source code](#prepare-code).
1. [Deploy the service](#deploy) — pick one of two paths: through the Serverless Framework (recommended, creates everything automatically) or step by step through the management console.
1. [Test the service](#test).

If you no longer need the resources, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](paid-resources.md) %}


## Get a Wildberries API token {#wb-token}

The Wildberries API token grants the service access to the reviews section of your seller dashboard.

1. Go to the [Wildberries seller dashboard](https://seller.wildberries.ru/).
1. Open **Profile** → **Settings** → **API access**.
1. Create a new key with the **Reviews and questions** (Feedbacks) scope.
1. Save the token — you will need it during deployment.

For more details about Wildberries tokens, see the [official Wildberries developer documentation](https://dev.wildberries.ru/openapi/api-information).


## Get the source code {#prepare-code}

Clone the [repository](https://github.com/eslazarev/ai-wildberries-review-responder) with the service source code:

```bash
git clone https://github.com/eslazarev/ai-wildberries-review-responder.git
cd ai-wildberries-review-responder
```

The repository already contains everything required for deployment:

* `src/` — the application source code, organized as a hexagonal architecture.
* `requirements.txt` — Python dependency list.
* `settings.yaml` — default configuration: base URLs, review batch size, run interval, prompt template, and system instructions for the model.
* `serverless.yml` — Serverless Framework manifest describing the function, the cron trigger, and both service accounts (`{{ roles-yagpt-user }}` for the function and `{{ roles-functions-invoker }}` for the trigger).

The {{ sf-name }} entry point is `src.entrypoints.yandex_cloud_function.handler`. Inside the function:

1. Settings are loaded from `settings.yaml` and environment variables.
1. If the `LLM__API_KEY` variable is empty or `null`, the IAM token of the service account from `context.token` is used as the {{ yagpt-full-name }} token.
1. The Wildberries client fetches the list of unanswered reviews.
1. For each review, a prompt is rendered from the template in `settings.yaml`.
1. The LLM returns the reply text.
1. The Wildberries client publishes the reply.


## Deploy the service {#deploy}

Pick the deployment path that fits you.

{% list tabs group=instructions %}

- Serverless Framework {#serverless}

  This path provisions **all** resources — the function, the cron trigger, and both service accounts (`wb-responder-function-service-account` with the `{{ roles-yagpt-user }}` role and `wb-responder-trigger-service-account` with the `{{ roles-functions-invoker }}` role) — with a single command, following the manifest in `serverless.yml`.

  Requires [Node.js 18+](https://nodejs.org) and [Serverless Framework 3](https://www.serverless.com/framework/docs/getting-started).

  1. From the root of the cloned repository install the dependencies:

     ```bash
     npm install
     ```

  1. Run the deployment, passing the Wildberries API token from the [Get a Wildberries API token](#wb-token) step:

     ```bash
     WILDBERRIES__API_TOKEN='your_wb_token' serverless deploy
     ```

     The deployment is now complete. The `LLM__API_KEY` variable defaults to `null`, so the function will use the IAM token of the service account created by the same command.

  1. To change the run interval, pass the `WILDBERRIES__CHECK_EVERY_MINUTES` variable (in minutes, default `30`):

     ```bash
     WILDBERRIES__CHECK_EVERY_MINUTES='15' WILDBERRIES__API_TOKEN='your_wb_token' serverless deploy
     ```

  1. To use an OpenAI-compatible model (OpenAI, Ollama, etc.) instead of {{ yagpt-name }}, also pass `LLM__API_KEY` and, if needed, `LLM__MODEL` and `LLM__BASE_URL`:

     ```bash
     LLM__API_KEY='your_llm_api_key' WILDBERRIES__API_TOKEN='your_wb_token' serverless deploy
     ```

- Management console {#console}

  Use this path to assemble the infrastructure manually. Each resource is created separately.

  **1. Create the service accounts.**

  1. [Create](../../../iam/operations/sa/create.md) a service account named `wb-responder-function-sa` and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `{{ roles-yagpt-user }}` role — the function uses its IAM token to call {{ yagpt-name }}.
  1. [Create](../../../iam/operations/sa/create.md) a second service account named `wb-responder-trigger-sa` and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `{{ roles-functions-invoker }}` role — the cron trigger will use it to invoke the function.

  **2. Create the function.**

  1. In the [management console]({{ link-console-main }}), open the folder where you want to create the function.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}** and set the name to `wb-responder-function`.
  1. From the root of the cloned repository, build a ZIP archive containing the `src/` folder and the `requirements.txt`, `settings.yaml` files:

     ```bash
     zip -r wb-responder.zip src requirements.txt settings.yaml
     ```

  1. Create a function version with the following parameters:

     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python312`.
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `src.entrypoints.yandex_cloud_function.handler`.
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `512 {{ ui-key.yacloud.common.units.label_megabyte }}`.
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `30`.
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}**: **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}**, upload `wb-responder.zip`.
     * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `wb-responder-function-sa`.

  1. Add the environment variables:

     * `WILDBERRIES__API_TOKEN` — the Wildberries token from the [Get a Wildberries API token](#wb-token) step.
     * `LLM__API_KEY` — leave empty or set to `null` so that the function uses the IAM token of the service account when calling {{ yagpt-name }}.

  1. Save the version.

  **3. Create the timer trigger.**

  1. On the **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** service page, switch to the **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}** tab and click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**, set:

     * Trigger name: `wb-responder-trigger`.
     * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}**: `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.

  1. Under **Timer**, specify a cron expression, for example `*/30 * * * ? *` for a run every 30 minutes.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, choose the function `wb-responder-function`, the version tag `$latest`, and the service account `wb-responder-trigger-sa`.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}


## Test the service {#test}

1. In the Wildberries seller dashboard, make sure there is at least one unanswered review.
1. In the [management console]({{ link-console-main }}), open the `wb-responder-function` function and switch to the **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}** — the function will run once without waiting for the trigger. The **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** field should show **{{ ui-key.yacloud.serverless-functions.item.testing.label_result-success }}**.
1. Switch to the **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** tab and verify that the logs contain no errors and show entries for processed reviews.
1. After a few minutes, return to the Wildberries seller dashboard and check that the processed reviews now have replies.

If you see Wildberries authorization errors (`401 Unauthorized`) in the logs, make sure the `WILDBERRIES__API_TOKEN` environment variable contains a token with the **Reviews and questions** scope.


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. If you used the Serverless Framework, delete everything with one command:

   ```bash
   serverless remove
   ```

   In this case, you can skip the remaining steps.

1. [Delete](../../../functions/operations/trigger/trigger-delete.md) the `wb-responder-trigger` trigger.
1. [Delete](../../../functions/operations/function/function-delete.md) the `wb-responder-function` function.
1. [Delete](../../../iam/operations/sa/delete.md) the service accounts `wb-responder-function-sa` and `wb-responder-trigger-sa`.
