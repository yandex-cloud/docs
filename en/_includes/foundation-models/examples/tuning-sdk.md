```python
#!/usr/bin/env python3

from __future__ import annotations
import pathlib
import uuid
from yandex_cloud_ml_sdk import YCloudML


def local_path(path: str) -> pathlib.Path:
    return pathlib.Path(__file__).parent / path


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
    base_model = sdk.models.completions("yandexgpt-lite")

    # Defining minimum parameters
    # To control more parameters, use `base_model.tune_deferred()`
    tuned_model = base_model.tune(train_dataset, name=str(uuid.uuid4()))
    print(f"Resulting {tuned_model}")

    # Starting the tuning
    completion_result = tuned_model.run("hey!")
    print(f"{completion_result=}")

    # Saving the URI of the tuned model
    tuned_uri = tuned_model.uri
    model = sdk.models.completions(tuned_uri)

    completion_result = model.run("hey!")
    print(f"{completion_result=}")


if __name__ == "__main__":
    main()
```