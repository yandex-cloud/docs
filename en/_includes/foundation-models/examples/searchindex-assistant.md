```python
#!/usr/bin/env python3

from __future__ import annotations
import pathlib
from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.search_indexes import StaticIndexChunkingStrategy, TextSearchIndexType

def local_path(path: str) -> pathlib.Path:
    return pathlib.Path(__file__).parent / path


def main() -> None:
    sdk = YCloudML(folder_id="<folder_ID>", auth="<API_key>")

    # Uploading files with examples
    # The files will be stored for five days
    files = []
    for path in ['bali.md', 'kazakhstan.md']:
        file = sdk.files.upload(
            local_path(path),
            ttl_days=5,
            expiration_policy="static",
        )
        files.append(file)

    # Creating an index for full-text search through the uploaded files
    # The maximum fragment size is 700 tokens, with a 300-token overlap
    operation = sdk.search_indexes.create_deferred(
        files,
        index_type=TextSearchIndexType(
            chunking_strategy=StaticIndexChunkingStrategy(
                max_chunk_size_tokens=700,
                chunk_overlap_tokens=300,
            )
        )
    )

    # Waiting until the search index is created
    search_index = operation.wait()

    # Creating a tool to work with one or even more than one search index, as needed
    tool = sdk.tools.search_index(search_index)
    
    # Creating an assistant for the Latest {{ gpt-pro }} model
    # It will use the search index tool
    assistant = sdk.assistants.create('yandexgpt', tools=[tool])
    thread = sdk.threads.create()

    thread.write("How much is a visa to Bali?")
    run = assistant.run(thread)
    result = run.wait()
    print('Answer:', result.text)

    # Delete everything you no longer need
    search_index.delete()
    thread.delete()
    assistant.delete()

    for file in files:
        file.delete()


if __name__ == '__main__':
    main()
```

Where:

* `<folder_ID>`: ID of the folder in which the service account was created.
* `<API_key>`: Service account API key you got earlier.