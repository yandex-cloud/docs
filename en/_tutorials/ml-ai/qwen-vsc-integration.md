You can facilitate software development in [Visual Studio Code](https://code.visualstudio.com/) with Qwen3-235B-A22B. The model can generate code, convert it to other programming languages, help you with debugging and error detection in code, analyze data, write documentation, and more.

In this tutorial, you will integrate the Qwen3-235B-A22B model into your Visual Studio Code IDE with the help of {{ foundation-models-full-name }} and the [Roo Code](https://roocode.com/) extension.

To use Qwen3-235B-A22B as your Visual Studio Code assistant, proceed as followings:

1. [Set up your infrastructure](#infra).
1. [Create an API key for the service account](#create-key).
1. [Connect to the model](#connection).
1. [Test the model](#test).

The infrastructure support fee for connecting Qwen3-235B-A22B from Visual Studio Code includes a text generation fee (see [{{ foundation-models-full-name }} pricing](../../foundation-models/pricing.md)).

## Set up your infrastructure {#infra}

### Create a folder {#create-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Name your folder, e.g., `aistudio`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account {#create-sa}

You will need this [service account](../../iam/concepts/users/service-accounts.md) to get an [API key](../../iam/concepts/authorization/api-key.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to `aistudio`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account, e.g., `qwen-user`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the `{{ roles-yagpt-user }}` role to the service account.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Create an API key for the service account {#create-key}

You need to create an API key for Visual Studio Code to be able to access the model.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `aistudio`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. In the list that opens, select the `qwen-user` service account.
  1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** field, select `yc.ai.languageModels.execute`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key.

{% endlist %}

## Connect to the model {#connection}

1. Install the [Roo Code](https://roocode.com/) extension in Visual Studio Code.
1. Click **Roo Code** in VSC left-hand panel.
1. In the window that opens, select **OpenAI Compatible** in the **API Provider** field.
1. In the **Base URL** field, specify `https://{{ api-host-llm }}/v1`.
1. In the **API-key** field, paste the secret key value you got in the previous [step](#create-key).
1. In the **Model** field, specify `gpt://<folder_ID>/Qwen3-235b-a22b-fp8/latest`, where `<folder_ID>` stands for the `aistudio` [folder ID](../../resource-manager/operations/folder/get-id.md).
1. Click **Go!**.

## Test the model {#test}

As an example, let's ask Qwen to generate a script to access an AI model via the {{ openai }} SDK.

1. Click **Roo Code** in Visual Studio Code left-hand panel.
1. In the window that opens, enter your prompt in the input field below and click **Send message**:

   ```text
   Write a script named `test.py` to make a streaming call to generate a poem about Yandex Cloud via the Python {{ openai }} SDK. Use model token and ID as parameters. Use `https://{{ api-host-llm }}/v1` as the endpoint
   ```

   Result:

   ```py
   import sys
   from openai import OpenAI
   
   def main():
       if len(sys.argv) != 3:
           print("Usage: python test.py <token> <model_id>")
           return
   
       token = sys.argv[1]
       model_id = sys.argv[2]
   
       client = OpenAI(
           base_url="https://{{ api-host-llm }}/v1",
           api_key=token
       )
   
       stream = client.chat.completions.create(
           model=model_id,
           messages=[
               {"role": "user", "content": "Write a poem about Yandex Cloud"}
           ],
           stream=True
       )
   
       for chunk in stream:
           content = chunk.choices[0].delta.content
           if content:
               print(content, end="")
   
   if __name__ == "__main__":
       main()
   ```
