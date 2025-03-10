```python
#!/usr/bin/env python3

from __future__ import annotations
import asyncio
import pathlib
from yandex_cloud_ml_sdk import AsyncYCloudML
from yandex_cloud_ml_sdk.auth import YandexCloudCLIAuth


def local_path(path: str) -> pathlib.Path:
    return pathlib.Path(__file__).parent / path


async def main():

    sdk = AsyncYCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    # Creating a tuning dataset for the {{ gpt-lite }} base model
    dataset_draft = sdk.datasets.draft_from_path(
        task_type="<classification_type>",
        path="<path_to_file>",
        upload_format="jsonlines",
        name="multiclass",
    )

    # Waiting for the data to be uploaded and the dataset to be created
    operation = await dataset_draft.upload_deferred()
    tuning_dataset = await operation
    print(f"new {tuning_dataset=}")

    # Viewing the list of all uploaded datasets
    for dataset in sdk.datasets.list():
        print(f"List of existing datasets {dataset=}")

if __name__ == "__main__":
    asyncio.run(main())
```

Where:

* `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) the [service account](../../../iam/concepts/users/service-accounts.md) was created in.
* `<API_key>`: Service account [API key](../../../iam/concepts/authorization/api-key.md) you got earlier required for [authentication in the API](../../../foundation-models/api-ref/authentication.md).

    {% include [sdk-auth-details-paragraph](../sdk-auth-details-paragraph.md) %}
* `<classification_type>`: [Classification type](../../../foundation-models/concepts/classifier/index.md) the model will be tuned for using the new dataset. The possible values are:

    * `TextClassificationMultilabel`: Binary classification or multi-label classification.
    * `TextClassificationMulticlass`: Multi-class classification.
* `<file_path>`: Path to the file containing the ready-made examples for model tuning.