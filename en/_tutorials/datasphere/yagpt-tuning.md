In [{{ ml-platform-full-name }}]({{ link-datasphere-main }}), you can tune the [{{ yagpt-name }}](../../yandexgpt/concepts/index.md) neural network on your own examples to make it more tailored to your specific tasks. To do this, prepare a file with pairs of queries and reference responses and start tuning.

{% note info %}

Foundation model tuning is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

{% note info %}

{{ yagpt-full-name }} is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

To tune the {{ yagpt-name }} model:

1. [Prepare your infrastructure](#infra).
1. [Prepare data for model training](#create-data).
1. [Tune the model](#model-tuning).
1. [Test the model](#model-test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project (optional) {#create-sa}

You can send requests to a fine-tuned model through the {{ ml-platform-name }} interface (Playground) or the API, using the code. If you are going to make API requests, you need a service account with the `{{ roles-yagpt-user }}` [role](../../iam/concepts/access-control/roles.md). The service account must be a {{ ml-platform-name }} project member.

{% list tabs %}

- Management console

   1. Go to the `data-folder` folder.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md), e.g., `ai-user`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the service account the `{{ roles-yagpt-user }}` role.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

#### Add the service account to a project {#sa-to-project}

To enable the service account to access the fine-tuned model from the {{ ml-platform-name }} project code, add it to the list of project members.

{% list tabs %}

- Management console

   1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
   1. In the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab, click **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
   1. Select the `ai-user` account and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

{% endlist %}

## Prepare data for model training {#create-data}

Data required for model tuning should be saved to a JSON file as pairs of UTF-8 encoded [queries and reference responses](../../datasphere/concepts/models/foundation-models.md#yagpt-tuning). To successfully run model tuning, you need at least 10 pairs.

File content example:

```json
[
{
    "request": "happy new year!",
    "response": "Happy New Year!"
},
{
    "request": "goot prodact, recomend it to everibody!",
    "response": "Good product, recommend it to everybody!"
},
{
    "request": "i have a komplaint about theirs service!",
    "response": "I have a complaint about their service!"
}
…
]
```

## Retrain the model {#model-tuning}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}

1. In the left-hand panel, click **{{ ui-key.yc-ui-datasphere.common.foundation-models }}**.

1. Select the **{{ ui-key.yc-ui-datasphere.common.YGPT }}** model and click **{{ ui-key.yc-ui-datasphere.common.tuning-model }}**.

1. In the window that opens, specify your project and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

1. In the **{{ ui-key.yc-ui-datasphere.common.name }}** field, enter a model name, e.g., `my-first-model`.

1. Set **{{ ui-key.yc-ui-datasphere.foundation-model.learning-rate }}**. The learning rate determines the step size at each iteration when searching for the optimal solution. The higher the value, the faster the model will converge, but also the higher the risk of model tuning.

1. Under **{{ ui-key.yc-ui-datasphere.foundation-model.data-for-tuning }}**:

    * In the **{{ ui-key.yc-ui-datasphere.foundation-model.samples-file }}** field, attach your JSON file with query/response pairs.
    * In the **{{ ui-key.yc-ui-datasphere.foundation-model.instruction }}** field, describe the task conditions, context, and possible limitations, or set the response style. This step is optional; however, after you run tuning, you will not be able to change the instruction. The instruction will be part of the fine-tuned model.

1. Click **{{ ui-key.yc-ui-datasphere.foundation-model.start-tuning }}** and wait for the model to be tuned.

1. To check the status of your fine-tuned model:

    * {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
    * In the list of available project resources, select **{{ ui-key.yc-ui-datasphere.common.models }}**.
    * In the **{{ ui-key.yc-ui-datasphere.common.projects-resources }}** tab, select **{{ ui-key.yc-ui-datasphere.common.tuned-foundation-models }}**.

      You can also get the model ID here. You will need it to make API requests.

## Test the model {#model-test}

{% list tabs %}

- Playground

    1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}

    1. In the list of available project resources, select **{{ ui-key.yc-ui-datasphere.common.models }}**.

    1. In the **{{ ui-key.yc-ui-datasphere.common.projects-resources }}** tab, select **{{ ui-key.yc-ui-datasphere.common.tuned-foundation-models }}**.

    1. Select your fine-tuned model and click **{{ ui-key.yc-ui-datasphere.foundation-model.test-in-playground }}**.

    1. Under **{{ ui-key.yc-ui-datasphere.yagpt-playground.request.title }}**, specify your request to the model.

    1. To change the variability, move the slider in the **{{ ui-key.yc-ui-datasphere.yagpt-playground.temperature.title }}** field. The higher the value, the more unpredictable the result.

- API

   Code to access the model:

   ```python
   import requests
   req = {
   	    "model": "general",
   	    "instruction_uri" : "ds://<ID_of_fine-tuned_model>",
   	    "request_text": "<text_of_request>",
   	    "generation_options": {
   	    "max_tokens": 1000,
   	    "temperature": 0.1
   	    }
   }
   headers = {'Authorization': 'Bearer ' + '<IAM_token>'}
   res = requests.post("https://llm.api.cloud.yandex.net/llm/v1alpha/instruct",
         headers=headers, json=req)
   print(res.json())
   ```

    Where:

    * `instruction_uri`: Fine-tuned model ID. You can [find](#model-tuning) it in the list of available project resources.
    * `request_text`: Text of your request.
    * `max_tokens`: Maximum number of characters per model response.
    * `temperature`: Temperature. The higher the value, the more unpredictable the result.
    * `Authorization`: [IAM token of the service account](../../iam/operations/iam-token/create-for-sa.md).

   For more information about parameters of requests to fine-tuned models, see the [{{ yagpt-full-name }} documentation](../../yandexgpt/concepts/api.md).

{% endlist %}

## How to delete the resources you created {#clear-out}

[Delete your project](../../datasphere/operations/projects/delete).
