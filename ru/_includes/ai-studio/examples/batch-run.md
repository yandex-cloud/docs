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
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    sdk.setup_default_logging()

    
    model = sdk.models.completions('<URI_модели>')

    # Пакетный запуск вернет объект Operations
    # Вы можете отслеживать его статус или вызвать метод .wait 
    operation = model.batch.run_deferred("<идентификатор_датасета>")

    resulting_dataset = operation.wait()

    # Датасет с результатами вернется в формате Parquet
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