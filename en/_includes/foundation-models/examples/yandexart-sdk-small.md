```python
#!/usr/bin/env python3

from __future__ import annotations
import pathlib
from yandex_cloud_ml_sdk import YCloudML

message = 'a pattern of pastel colored succulents of multiple varieties, hd full wallpaper, sharp focus, many intricate details, picture depth, top view'

def main() -> None:
    sdk = YCloudML(folder_id="<folder_ID>", auth="<API_key>")

    model = sdk.models.image_generation('yandex-art')

    # configuring model
    model = model.configure(width_ratio=2, height_ratio=1, seed=1863)

    path = pathlib.Path('./image.jpeg')
    operation = model.run_deferred(message)
    result = operation.wait()
    path.write_bytes(result.image_bytes)

if __name__ == '__main__':
    main()
```