# {{ yagpt-full-name }} models

{% include notitle [preview-stage](../../_includes/yandexgpt/preview.md) %}

{{ yagpt-full-name }} provides access to two large generative neural networks: the standard {{ yagpt-name }} Lite model suitable for real-time tasks, and the larger {{ yagpt-name }} model delivering more accurate responses to sophisticated queries.

If the standard models are not enough, you can fine-tune {{ yagpt-name }} Lite in [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) for it to better understand your area or expertise.

Moreover, {{ yagpt-full-name }} allows obtaining text embeddings using special models for vector representation of text.

You can access the model's API via its [URI](https://en.wikipedia.org/wiki/URI) which contains the [folder ID](../../resource-manager/operations/folder/get-id.md). The `/latest` option specifies the version of the model to invoke and is optional.

## Generation models {#yandexgpt-generation}

| Model | URI | Operation mode |
|---|---|---|
| {{ yagpt-name }} | `gpt://<folder_ID>/yandexgpt/latest` | Asynchronous, synchronous ^1^ |
| {{ yagpt-name }} Lite | `gpt://<folder_ID>/yandexgpt-lite/latest` | Asynchronous, synchronous |
| Summary | `gpt://<folder_ID>/summarization/latest` | Asynchronous, synchronous |
| Model fine-tuned in {{ ml-platform-full-name}} | `ds://<fine_tuned_model_ID>` | Synchronous |

^1^ The synchronous mode has [limitations](limits.md).

## Models for vector representation of text {#yandexgpt-embeddings}

| Model | URI | Operation mode |
|---|---|---|
| Embeddings for search queries | `emb://<folder_ID>/text-search-query/latest` | Synchronous |
| Embeddings for knowledge base (documentation) | `emb://<folder_ID>/text-search-doc/latest` | Synchronous |