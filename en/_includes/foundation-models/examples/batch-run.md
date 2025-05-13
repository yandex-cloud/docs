```python
#!/usr/bin/env python3

from __future__ import annotations
import pathlib
from yandex_cloud_ml_sdk import YCloudML

PATH = pathlib.Path(__file__)
NAME = f'example-{PATH.parent.name}-{PATH.name}'


def local_path(path: str) -> pathlib.Path:
    return pathlib.Path(__file__).parent / path


def main() -> None:
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    sdk.setup_default_logging()

    
    model = sdk.models.completions('<model_URI>')

    # The batch run will return an _Operations_ object
    # You can monitor its status or call the .wait method 
    operation = model.batch.run_deferred("<dataset_ID>")

    resulting_dataset = operation.wait()

    # A dataset with results will return in Parquet format
    try:
        import pyarrow 

        print('Resulting dataset lines:')
        for line in resulting_dataset.read():
            print(line)
    except ImportError:
        print('skipping dataset read; install yandex-cloud-ml-sdk[datasets] to be able to read')

if __name__ == '__main__':
    main()
```