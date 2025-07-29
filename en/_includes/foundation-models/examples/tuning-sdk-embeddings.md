```python
#!/usr/bin/env python3

from __future__ import annotations
import uuid
from yandex_cloud_ml_sdk import YCloudML

# Configuration
folder = "<folder_ID>"
token = "<API_key>"
type = "<dataset_type>"
dataset_id = "<dataset_ID>"


def main():
    sdk = YCloudML(
        folder_id=folder,
        auth=token,
    )

    # Setting the tuning dataset and the base model
    train_dataset = sdk.datasets.get(dataset_id)
    base_model = sdk.models.text_embeddings("text-embeddings")

    # Starting the tuning
    # Tuning can last up to several hours
    tuning_task = base_model.tune_deferred(
        train_dataset, name=str(uuid.uuid4()), embeddings_tune_type=type
    )
    tuned_model = tuning_task.wait()
    print(f"Resulting {tuned_model}")


if __name__ == "__main__":
    main()
```