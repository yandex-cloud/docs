```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_ai_studio_sdk import AIStudio

messages = "Generative models are managed using prompts. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt is, the more accurate the model's output is going to be."


def main():
    sdk = AIStudio(
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