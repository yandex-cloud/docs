# Classifier models based on {{ yagpt-name }}

You can access a {{ yagpt-name }}-based classifier model via API using its [URI](https://en.wikipedia.org/wiki/URI) which contains the [folder ID](../../../resource-manager/operations/folder/get-id.md). The `/latest` segment specifies the model version and is optional. To access a {{ yagpt-name }}-based classifier model, use the [fewShotClassify](../../text-classification/api-ref/TextClassification/fewShotClassify.md) Text Classification API method.

If an out-of-the-box model is not enough, you can [fine-tune](../tuning/classifier.md) a {{ gpt-pro }}-based classifier for the model to be more accurate classifying your requests. To access a fine-tuned classifier model, use the [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API method.

| Model | URI | Operation mode |
|---|---|---|
| Prompt-based classifier built on {{ gpt-lite }} | `cls://<folder_ID>/yandexgpt-lite/latest` | Synchronous |
| Prompt-based classifier built on {{ gpt-pro }} | `cls://<folder_ID>/yandexgpt/latest` | Synchronous |
| Fine-tuned classifier model | `cls://<folder_ID>/<fine-tuned_model_ID>` | Synchronous |