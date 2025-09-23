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
    for dataset in sdk.datasets.list(status="READY", name_pattern="multiclass"):
        print(f"List of existing datasets {dataset=}")

    # Setting the tuning dataset and the base model
    train_dataset = sdk.datasets.get("<dataset_ID>")
    base_model = sdk.models.text_classifiers("yandexgpt-lite")

    # Defining minimum parameters
    # To control more parameters, use `base_model.tune_deferred()`
    # Starting the tuning
    tuned_model = base_model.tune(
        train_dataset, name=str(uuid.uuid4()), classification_type="<classification_type>"
    )
    print(f"Resulting {tuned_model}")

    # You can access the fine-tuned model using the run() method
    classification_result = tuned_model.run("Wow!")
    print(f"{classification_result=}")

    # Or you can save the URI of the fine-tuned model
    # And call the fine-tuned model by its URI
    tuned_uri = tuned_model.uri
    model = sdk.models.text_classifiers(tuned_uri)
    classification_result = model.run("Cool!")
    print(f"{classification_result=}")


if __name__ == "__main__":
    main()
```