```python
#!/usr/bin/env python3

from __future__ import annotations

import pathlib
from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.auth import YandexCloudCLIAuth


def main() -> None:

    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    # Viewing the list of all uploaded datasets
    for dataset in sdk.datasets.list():
        print(f"List of existing datasets {dataset=}")

    # This way you can delete all previously uploaded datasets,
    # but better not do this unless you have to
    # for dataset in sdk.datasets.list():
    #    dataset.delete()

    # Creating a dataset
    dataset_draft = sdk.datasets.draft_from_path(
        task_type="<dataset_type>",
        path="<file_path>",
        upload_format="jsonlines",
        name="<name>",
    )

    # Waiting for the data to be uploaded and the dataset to be created
    operation = dataset_draft.upload_deferred()
    tuning_dataset = operation.wait()
    print(f"new {tuning_dataset=}")


if __name__ == "__main__":
    main()
```