```python
#!/usr/bin/env python3

from __future__ import annotations
import pathlib
from yandex_cloud_ml_sdk import YCloudML

message1 = "a red cat"
message2 = "Miyazaki style"


def main():
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    model = sdk.models.image_generation("yandex-art")

    # configuring model for all of future runs
    model = model.configure(width_ratio=1, height_ratio=2, seed=50)

    # Sample 1: simple run
    operation = model.run_deferred(message1)
    result = operation.wait()
    print(result)

    # Sample 2: run with several messages, saving the result to file
    path = pathlib.Path("./image.jpeg")
    try:
        operation = model.run_deferred([message1, message2])
        result = operation.wait()
        path.write_bytes(result.image_bytes)
    finally:
        path.unlink(missing_ok=True)

    # Sample 3: run with several messages specifying weight
    operation = model.run_deferred([{"text": message1, "weight": 5}, message2])
    result = operation.wait()
    print(result)

    # Sample 4: example of combining {{ yagpt-name }} and {{ yandexart-name }} models
    gpt = sdk.models.completions("yandexgpt")
    messages = gpt.run(
        [
            "you need to create a prompt for a yandexart model",
            "of " + message1 + "in" + message2,
        ]
    )
    print(messages)

    operation = model.run_deferred(messages)
    result = operation.wait()
    print(result)


if __name__ == "__main__":
    main()
```