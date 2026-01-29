---
title: How to send background text generation requests
description: Follow this guide to learn how to send background text generation requests to {{ foundation-models-full-name }}.
---

# Sending a request in background mode

When performing large-scale text generation tasks, e.g., which involve processing massive documents, using the _background request mode_ may be the most efficient approach.

In background mode, {{ responses-api }} does not wait for the model to return the generation result in response to a request; instead, it receives the task ID and then closes the connection. After that, you can use this ID to check the task status from time to time and get the generation result once it is ready.

If you have a short request and expect a short response, or if accessing a text generation model in [chat mode](./create-chat.md), use the [synchronous request mode](./create-prompt.md).

To complete the steps from this example, [create](../get-api-key.md#run-client) a service account with the `ai.languageModels.user` [role](../../security/index.md#languageModels-user) and get an API key with the `yc.ai.foundationModels.execute` scope.

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai
  import time

  YANDEX_API_KEY = "<API_key>"
  YANDEX_FOLDER_ID = "<folder_ID>"
  YANDEX_MODEL = "yandexgpt"

  client = openai.OpenAI(
      api_key=YANDEX_API_KEY,
      base_url="https://ai.{{ api-host }}/v1",
      project=YANDEX_FOLDER_ID,
  )

  # --- 1. Creating a response in the background
  resp = client.responses.create(
      model=f"gpt://{YANDEX_FOLDER_ID}/{YANDEX_MODEL}",
      input="Create a brief summary of the text: 'Yandex AI Studio features over 20 models deployed in the cloud and available in various modes. The YandexGPT family models remain the most popular models in terms of consumption, claiming 62.7% of the cloud platform traffic. This high demand allowed Yandex to bring down the prices of its proprietary models, making them more affordable. The open-source models Qwen3‑235b from Alibaba Group (30.9%) and GPT‑OSS from OpenAI (5.7%) take the second and third place accordingly.'",
      background=True,  # Running in the background
  )

  print("Task sent:", resp.id)

  # --- 2. Asking for status
  while True:
      status = client.responses.retrieve(resp.id)
      print("Status:", status.status)
      if status.status in ["completed", "failed", "cancelled"]:
          break
      time.sleep(2)

  # --- 3. Getting the result
  if status.status == "completed":
      print("Final response:", status.output_text)
  else:
      print("Error:", status.status)
  ```

{% endlist %}

Where:

* `YANDEX_API_KEY`: Service account [API key](../../../iam/concepts/authorization/api-key.md) you obtained.
* `YANDEX_FOLDER_ID`: Service account [folder ID](../../../resource-manager/operations/folder/get-id.md).
* `resp`: Object with results of the response generation request.

  Possible generation result statuses include:

  * `queued`: Task is queued to run.
  * `in_progress`: Running the task.
  * `failed`: Task failed with an error.
  * `cancelled`: Cancelled the task.
  * `completed`: Task completed successfully.

  The generation result will be saved to the `status.output_text` field when the status changes to `completed`.


Result example:

```text
Task sent: 1e5ee267-2d01-49d7-abf9-94b9********
Status: queued
Status: completed
Final response: Yandex AI Studio offers more than 20 cloud models. The most popular ones are YandexGPT models (62.7% of traffic), followed by Qwen3‑235b (30.9%) and GPT‑OSS (5.7%). High demand for YandexGPT allowed the company to reduce its model prices.
```

#### See also {#see-also}

* [{#T}](./create-prompt.md)
* [{#T}](../../concepts/generation/index.md)