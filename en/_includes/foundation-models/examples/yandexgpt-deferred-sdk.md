```python
#!/usr/bin/env python3

from __future__ import annotations
import time
from yandex_cloud_ml_sdk import YCloudML

messages_1 = [
    {
        "role": "system",
        "text": "Find errors in the text and correct them",
    },
    {
        "role": "user",
        "text": """Laminate flooring is sutiable for instalation in the kitchen or in a child's 
room. It withsatnds moisturre and mechanical dammage thanks to 
a 0.2 mm thick proctive layer of melamine films and 
a wax-treated interlocking system.""",
    },
]

messages_2 = [
    {"role": "system", "text": "Find errors in the text and correct them"},
    {"role": "user", "text": "Erors wyll not corrct themselfs."},
]


def main():

    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    model = sdk.models.completions("yandexgpt")

    # Variant 1: wait for the operation to complete using 5-second sleep periods

    print("Variant 1:")

    operation = model.configure(temperature=0.5).run_deferred(messages_1)

    status = operation.get_status()
    while status.is_running:
        time.sleep(5)
        status = operation.get_status()

    result = operation.get_result()
    print(result)

    # Variant 2: wait for the operation to complete using the wait method

    print("Variant 2:")

    operation = model.run_deferred(messages_2)

    result = operation.wait()
    print(result)


if __name__ == "__main__":
    main()
```