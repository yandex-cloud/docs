```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

messages = "Generative models are managed using prompts. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model."

def main():
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    model = sdk.models.completions("yandexgpt")

    result = model.tokenize(messages)

    for token in result:
        print(token)


if __name__ == "__main__":
    main()
```