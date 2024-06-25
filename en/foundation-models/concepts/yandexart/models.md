# {{ yandexart-name }} models

You can access the {{ yandexart-name }} model's API via its [URI](https://en.wikipedia.org/wiki/URI) which contains the [folder ID](../../../resource-manager/operations/folder/get-id.md). The `/latest` segment specifies the model version and is optional.

| Purpose | URI | Operation mode |
|---|---|---|
| Generating an image based on a text description | `art://<folder_ID>/yandex-art/latest` | Asynchronous |

