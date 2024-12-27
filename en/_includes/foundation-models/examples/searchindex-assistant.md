```python
#!/usr/bin/env python3

from __future__ import annotations

import pathlib

from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.search_indexes import (
    StaticIndexChunkingStrategy,
    TextSearchIndexType,
)

mypath = "<path_to_files_with_examples>"


def main():
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    paths = pathlib.Path(mypath).iterdir()

    # Uploading files with examples
    # The files will be stored for five days
    files = []
    for path in paths:
        file = sdk.files.upload(
            path,
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
        ),
    )

    # Waiting until the search index is created
    search_index = operation.wait()

    # Creating a tool to work with the search index
    # or multiple search indexes if that was the case
    tool = sdk.tools.search_index(search_index)

    # Creating an assistant for the Latest {{ gpt-pro }} model
    # It will use the search index tool
    assistant = sdk.assistants.create("yandexgpt", tools=[tool])
    thread = sdk.threads.create()

    input_text = ""

    while input_text != "exit":
        print("Enter your question to the assistant:")
        input_text = input()
        if input_text != "exit":
            thread.write(input_text)

            # Providing the model with the whole thread contents
            run = assistant.run(thread)

            # To get the result, wait until the run is complete
            result = run.wait()

            # Displaying the response
            print(f"Answer: {result.text}")

    # You can view all the messages stored in the thread
    print("Outputting the whole message history when exiting the chat:")
    for message in thread:
        print(f"    {message=}")
        print(f"    {message.text=}\n")

    # Deleting everything you no longer need
    search_index.delete()
    thread.delete()
    assistant.delete()

    for file in files:
        file.delete()


if __name__ == "__main__":
    main()
```