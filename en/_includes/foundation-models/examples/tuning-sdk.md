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

    # Starting the tuning
    # Tuning can last up to several hours
    tuned_model = base_model.tune_deferred(train_dataset, 
        name=str(uuid.uuid4())
        n_samples=10000
    )
    print(f"Resulting {tuned_model}")

    # You can access the fine-tuned model using the run() method
    completion_result = tuned_model.run("Hello! What is your name")
    print(f"{completion_result=}")

    # Or you can save the URI of the fine-tuned model
    # And call the fine-tuned model by its URI
    tuned_uri = tuned_model.uri
    model = sdk.models.completions(tuned_uri)
    completion_result = model.run("Tell me, where are you from?")
    print(f"{completion_result=}")


if __name__ == "__main__":
    main()
```