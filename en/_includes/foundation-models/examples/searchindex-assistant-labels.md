```python
import pathlib
from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.search_indexes import (
    VectorSearchIndexType,
)

# Local path to the source files.
mypath = "<path_to_files_with_examples>"

# The `file_labels` variable contains metadata that will be assigned to the source files.
# 
file_labels = [
    {"bali": "File with the description of tours to Bali"},
    {"kazakhstan": "File with the description of the proposal for Kazakhstan"},
]

# The `index_label` variable contains metadata that will be assigned to the search index.
# 
index_label = {
    "promo": "The index contains general information about Bali and Kazakhstan",
    "visas": "The index contains information on visa policies for entry to Bali and Kazakhstan",
}

def main():
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    # Load the source files and assign them the metadata from the `file_labels` variable.
    # The files will be stored for five days.
    paths = pathlib.Path(mypath).iterdir()
    files = []
    file_count = 0
    for path in paths:
        file = sdk.files.upload(
            path,
            ttl_days=5,
            expiration_policy="static",
            name=str(path),
            labels=file_labels[file_count]
        )
        files.append(file)
        file_count += 1

    # Creating an index for vector search and assigning metadata to the index.
    operation = sdk.search_indexes.create_deferred(
        files,
        index_type=VectorSearchIndexType(),
        name="the-bali-and-kazakhstan-index",
        labels=index_label,
    )

    # Waiting for the search index to be created.
    search_index = operation.wait()

    # Creating a tool to work with the search index.
    # Or even several indexes if that were the case.
    tool = sdk.tools.search_index(search_index)

    # Creating an assistant for the Latest {{ gpt-pro }} model.
    # It will use the search index tool.
    assistant = sdk.assistants.create("yandexgpt", tools=[tool])
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

        # Displaying the response on the screen.
        print(f"Answer: {result.text}")

        input_text = input(
            'Enter your question to the assistant ("exit" to end the dialog): '
        )

    # Displaying some of the attributes of the _citations_ property: information about the used source files, their contents and metadata assigned, as well as information about the index and its metadata.
    # 
    # 
    # You can use the assigned metadata (labels) to apply additional filters to the resulting values.
    # 
    print("Citations:")
    for citation in result.citations:
        for source in citation.sources:
            print(f"    {source.text=}")
            print(f"    {source.file.name=}")
            print(f"        {source.file.labels=}")
            print(f"    {source.search_index.name=}")
            print(f"        {source.search_index.labels=}")

    # Deleting things you no longer need.
    search_index.delete()
    thread.delete()
    assistant.delete()

    for file in files:
        file.delete()


if __name__ == "__main__":
    main()
```