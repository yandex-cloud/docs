```python
#!/usr/bin/env python3

from __future__ import annotations
import pathlib
import uuid
from yandex_cloud_ml_sdk import YCloudML


def main():
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    # Viewing the list of valid datasets
    for dataset in sdk.datasets.list(status="READY", name_pattern="completions"):
        print(f"List of existing datasets {dataset=}")

    # Setting the tuning dataset and the base model
    train_dataset = sdk.datasets.get("<dataset_ID>")
    base_model = sdk.models.text_embeddings('yandexgpt-lite')

    # Starting the tuning
    # Tuning can last up to several hours
    tuning_task = base_model.tune_deferred(
        train_dataset, 
        name=str(uuid.uuid4()), 
        embeddings_tune_type=tune_type
        )
    tuned_model = tuning_task.wait()
    print(f"Resulting {tuned_model}")


if __name__ == "__main__":
    main()
```