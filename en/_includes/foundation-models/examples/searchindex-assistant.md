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

    # Uploading files with examples.
    # The files will be stored for five days.
    files = []
    for path in paths:
        file = sdk.files.upload(
            path,
            ttl_days=5,
            expiration_policy="static",
        )
        files.append(file)

    # Creating an index for full-text search through the uploaded files.
    # This example sets the chunk size
    # of up to 700 tokens, with a 300-token overlap.
    operation = sdk.search_indexes.create_deferred(
        files,
        index_type=TextSearchIndexType(
            chunking_strategy=StaticIndexChunkingStrategy(
                max_chunk_size_tokens=700,
                chunk_overlap_tokens=300,
            )
        ),
    )

    # Waiting for the search index to be created.
    search_index = operation.wait()

    # Creating a tool to work with the search index.
    # Or even several indexes if that were the case.
    tool = sdk.tools.search_index(search_index)

    # Creating an assistant for the Latest {{ gpt-pro }} model.
    # It will use the VectorStore tool.
    assistant = sdk.assistants.create(
        "yandexgpt", 
        instruction = "You are an internal corporate documentation assistant. Answer politely. If the information is not in the documents below, don't make up your answer.", 
        tools=[tool])
    thread = sdk.threads.create()

    input_text = input(
        'Enter your question to the assistant ("exit" to end the dialog): '
    )

    while input_text.lower() != "exit":
        thread.write(input_text)

        # Giving the whole thread content to the model.
        run = assistant.run(thread)

        # To get the result, wait until the run is complete.
        result = run.wait()

        # Displaying the response.
        print("Response: ", result.text)

        # Displaying some of the _citations_ property attributes: information
        # about utilized chunks created from the source files.
        # To display the entire contents of the _citations_ property,
        # run this command: print(result.citations).
        count = 1
        for citation in result.citations:
            for source in citation.sources:
                if source.type != "filechunk":
                    continue
                print(
                    f"* Contents of fragment No.{count}: {source.parts}"
                )
                print(
                    f"* Search index ID in fragment No.{count}: {source.search_index.id}"
                )
                print(
                    f"* Search index type settings in fragment No.{count}: {source.search_index.index_type}"
                )
                print(
                    f"* Source file ID for fragment No.{count}: {source.file.id}"
                )
                print(
                    f"* Source file MIME type for fragment No.{count}: {source.file.mime_type}"
                )
                print()

            count += 1

        input_text = input(
            'Enter your question to the assistant ("exit" to end the dialog): '
        )

    # Delete everything you no longer need.
    search_index.delete()
    thread.delete()
    assistant.delete()

    for file in files:
        file.delete()


if __name__ == "__main__":
    main()
```