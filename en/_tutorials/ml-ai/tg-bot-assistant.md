

Language models can maintain conversation context and perform knowledge base search using {{ ml-sdk-full-name }}, [RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation), and [{{ assistant-api }}](../../foundation-models/concepts/assistant/index.md).

In this tutorial, you will create a wine sales chat assistant based on the {{ yagpt-name }} 5 model. The assistant relies on [function calling](../../foundation-models/concepts/generation/function-call.md) and RAG to access the database of wines and regions as well as the price list indicating wines in stock. You will configure the assistant in a {{ ml-platform-full-name }} notebook and interact with it via Telegram.

To create an AI assistant for Telegram:

1. [Set up your infrastructure](#infra).
1. [Create an API key for the service account](#create-key).
1. [Create a Telegram bot](#create-bot).
1. [Create secrets](#create-secrets).
1. [Clone the repository](#clone-repo).
1. [Test the bot](#test-bot).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost for creating an AI assistant includes:

* Fee for using [{{ ml-platform-name }} computing resources](../../datasphere/pricing.md).
* Fee for [text generation](../../foundation-models/pricing.md) by the model.

## Set up your infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
  1. Name your folder, e.g., `data-folder`.
  1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project {#create-sa}

You need to create a [service account](../../iam/concepts/users/service-accounts.md) to access the model from the notebook.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to `data-folder`.
  1. On the left-hand panel, click ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**, or find it using the search bar on the dashboard.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account, e.g., `gpt-user`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the `{{ roles-yagpt-user }}` role to the service account.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Add the service account to the project {#sa-to-project}

To enable the service account to access the model from the notebook, add it to the list of project members.

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
  1. In the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab, click **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
  1. Select the `gpt-user` account and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

{% endlist %}

## Create an API key for the service account {#create-key}

To enable the service account to access the model, create an [API key](../../iam/concepts/authorization/api-key.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `data-folder`.
  1. On the left-hand panel, click ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**, or find it using the search bar on the dashboard.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. In the list that opens, select the `gpt-user` service account.
  1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** field, select `yc.ai.languageModels.execute`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key.

{% endlist %}

## Create a Telegram bot {#create-bot}

1. Open a chat with [@botfather](https://t.me/botfather).
1. Follow the prompts to choose a name and nickname for your Telegram bot.
1. After the bot is created successfully, you will receive a link to the chat with your bot and a token. Save them for the next steps.

## Create secrets {#create-secrets}

To use the API key, folder ID, and bot access token from the notebook, create [secrets](../../datasphere/concepts/secrets.md) with the relevant values.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select ![secret](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. In the **{{ ui-key.yc-ui-datasphere.secret.name }}** field, enter the name for the secret: `api_key`.
1. In the **{{ ui-key.yc-ui-datasphere.secret.content }}** field, paste the key ID.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Similarly, create two more secrets: `folder_id` with the folder ID and `tg_token` with the Telegram bot token.

## Clone the repository {#clone-repo}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Click **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** and wait until loading is complete.
1. On the left-hand panel, under ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser**, create or select the folder to store the repository clone and navigate to it.
1. In the top menu, click **Git** and select **Clone a Repository**.
1. In the window that opens, enter the repository URI, `https://github.com/yandex-cloud-examples/yc-ai-wine-assistant`.
1. Enable the **Download the repository** option and click **Clone**.

## Run the notebook {#run-notebook}

The notebook code connects to the model, provides it with the relevant functions, and configures the Telegram bot.

1. Navigate to the cloned repository folder.
1. Open the `advanced-assistant.ipynb` notebook.
1. Run the notebook cells one by one. Do not run cells in the **Deleting unused resources** section until you finish using the bot.
1. The last cell under **Creating a wine assistant in Telegram** will get your bot ready to run.

## Test the bot {#test-bot}

1. Open the chat with your bot using the link you got [earlier](#create-bot).
1. Click **START**.
1. Enter your query in the message input field. Here is an example:

   ```text
   What wine pairs well with white chocolate?
   ```

   Result:

   ```text
   White chocolate may go well with white and rosé dessert or fortified wines. Consider options like Chardonnay, Sémillon, Riesling, or Viognier. If you are interested in a specific wine, I can check its availability and price in our price list.
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete the project](../../datasphere/operations/projects/delete.md).