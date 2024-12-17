```python
#!/usr/bin/env python3

from __future__ import annotations
import pathlib
from yandex_cloud_ml_sdk import YCloudML

message = "узор из цветных пастельных суккулентов разных сортов, hd full wallpaper, четкий фокус, множество сложных деталей, глубина кадра, вид сверху"


def main():
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    model = sdk.models.image_generation("yandex-art")

    # configuring model
    model = model.configure(width_ratio=2, height_ratio=1, seed=1863)

    path = pathlib.Path("./image.jpeg")
    operation = model.run_deferred(message)
    result = operation.wait()
    path.write_bytes(result.image_bytes)


if __name__ == "__main__":
    main()
```