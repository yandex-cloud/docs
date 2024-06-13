{% include [classifiers-intro](../../_includes/datasphere/classifiers-tuning-intro.md) %}

{% note info %}

Foundation model tuning is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

{% note info %}

{{ foundation-models-full-name }} is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

To tune a {{ yagpt-name }} classifier:

1. [Prepare your infrastructure](#infra).
1. [Prepare data for model training](#create-data).
1. [Tune the classifier](#tuning).
1. [Send a request to the classifier](#request).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project {#create-sa}

You can send requests to a tuned model through the {{ ml-platform-name }} interface (Playground) or through the {{ foundation-models-name }} API. If you are going to make API requests, you need a service account with the `{{ roles-yagpt-user }}` [role](../../iam/concepts/access-control/roles.md). The service account must be a member of the {{ ml-platform-name }} project in which the classifier will be tuned.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the `data-folder` folder.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md), e.g., `ai-user`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the service account the `{{ roles-yagpt-user }}` role.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

#### Add the service account to a project {#sa-to-project}

To enable the service account to access the tuned classifier, add it to the list of project members.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab, click **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
1. Select the `ai-user` account and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

## Prepare data for model training {#create-data}

{% include [logging](../../_includes/foundation-models/yandexgpt/logging-disclaimer.md) %}

{% include [data-format](../../_includes/datasphere/classifier-training.md) %}

## Tune the model {#tuning}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the left-hand panel, click **{{ ui-key.yc-ui-datasphere.common.foundation-models }}**.
1. Select the **{{ yagpt-name }} classifier** model and click **{{ ui-key.yc-ui-datasphere.common.tuning-model }}**.
1. In the window that opens, specify your project and click **{{ ui-key.yc-ui-datasphere.common.add }}**.
1. In the **{{ ui-key.yc-ui-datasphere.common.name }}** field, enter a name for the model.
1. Select the **classification type**:

   * **Binary**: If each request belongs to one of the two groups.
   * **Multi-class**: If you need to divide multiple requests into several groups.
   * **Multi-label**: If each request can belong to more than one group.

1. In the **{{ ui-key.yc-ui-datasphere.foundation-model.samples-file }}** field, attach a JSON file with request and class pairs.
1. Click **{{ ui-key.yc-ui-datasphere.foundation-model.start-tuning }}** and wait for the model to be tuned. This may take several hours.
1. To check the status of your fine-tuned model:

   * {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
   * In the list of available project resources, select **{{ ui-key.yc-ui-datasphere.common.models }}**.
   * In the **{{ ui-key.yc-ui-datasphere.common.projects-resources }}** tab, select **{{ ui-key.yc-ui-datasphere.common.tuned-foundation-models }}**.

      You can also get the model ID here. You will need it to make API requests.

## Send a request to the tuned classifier {#request}

{% list tabs group=programming_language %}

- Playground {#playground}

   1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
   1. In the list of available project resources, select **{{ ui-key.yc-ui-datasphere.common.models }}**.
   1. In the **{{ ui-key.yc-ui-datasphere.common.projects-resources }}** tab, select **{{ ui-key.yc-ui-datasphere.common.tuned-foundation-models }}**.
   1. Select your fine-tuned model and click **{{ ui-key.yc-ui-datasphere.foundation-model.test-in-playground }}**.
   1. Under **{{ ui-key.yc-ui-datasphere.yagpt-playground.request.title }}**, enter the text you want to classify.
   1. Click **{{ ui-key.yc-ui-datasphere.yagpt-playground.send-request }}**.

- cURL {#curl}

   {% include [curl](../../_includes/curl.md) %}

   1. Create a file with the request body, e.g., `body.json`:

      ```json
      {
        "model_uri": "cls://<folder_ID>/<classifier_ID>",
        "text": "<request_text>"
      }
      ```

      Where:
      * `model_uri`: ID of the model that will be used to classify the message. The parameter contains {{ yandex-cloud }} [folder ID](../../resource-manager/operations/folder/get-id.md) and the ID of the model [tuned](../../datasphere/concepts/models/foundation-models.md#classifier-training) in {{ ml-platform-name }}.
      * `text`: Message text. The total number of tokens per request must not exceed 8,000.

   1. Send a request to the classifier by running the following command:

      ```bash
      export IAM_TOKEN=<IAM_token>
      curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "@<path_to_file_with_request_body>" \
        "https://{{ api-host-llm }}:443/foundationModels/v1/textClassification"
      ```

      In the response, the service will return the classification results with the `confidence` values for the probability of classifying the request text into each one of the classes:

      ```json
      {
        "predictions": [
          {
            "label": "<class_name_1>",
            "confidence": 0.00010150671005249023
          },
          {
            "label": "<class_name_2>",
            "confidence": 0.000008225440979003906
          },
          ...
          {
            "label": "<class_name_n>",
            "confidence": 0.93212890625
          }
        ],
        "modelVersion": "<model_version>"
      }
      ```

      In multi-class classification, the sum of the `confidence` values for all classes is always `1`.

      In multi-label classification, the `confidence` value for each class is calculated independently (the sum of the values is not equal to `1`).

{% endlist %}

## How to delete the resources you created {#clear-out}

[Delete the project](../../datasphere/operations/projects/delete).
