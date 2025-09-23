```python
#!/usr/bin/env python3

from __future__ import annotations

import pathlib

from yandex_cloud_ml_sdk import YCloudML

LABEL_KEY = 'yc-ml-sdk-example'
PATH = pathlib.Path(__file__)
NAME = f'example-{PATH.parent.name}-{PATH.name}'


def local_path(path: str) -> pathlib.Path:
   return pathlib.Path(__file__).parent / path


def get_search_index(sdk):
     # Function for retrieving or creating a search_index object

     for search_index in sdk.search_indexes.list():
         if search_index.labels and search_index.labels.get(LABEL_KEY) == NAME:
             print(f'using {search_index=}')
             break
     else:
         print('no search indexes found, creating new one')
         file = sdk.files.upload(
             local_path('turkey_example.txt')
         )
         operation = sdk.search_indexes.create_deferred(file, labels={LABEL_KEY: NAME})
         search_index = operation.wait()
         print(f'new {search_index=}')

         file.delete()

     return search_index


def delete_labeled_entities(iterator):
    # Cleanup function for deleting all iterator objects with the .labels attribute

    for entity in iterator:
       if entity.labels and entity.labels.get(LABEL_KEY) == NAME:
           print(f'deleting {entity.__class__.__name__} with id={entity.id!r}')
           entity.delete()

def main() -> None:
    sdk = YCloudML(
       folder_id="<folder_ID>",
       auth="<API_key>",
    )
    sdk.setup_default_logging(log_level='WARNING')

    search_index = get_search_index(sdk)
    labels = {LABEL_KEY: NAME}

    # Search index tool
    tool = sdk.tools.search_index(search_index)

    # Rephraser tool
    rephraser = sdk.tools.rephraser('rephraser', model_version='latest')
    tool_with_rephraser = sdk.tools.search_index(search_index, rephraser=rephraser)

    # Creating two assistants: one with rephraser and one without it
    assistant_wo_rephraser = sdk.assistants.create('yandexgpt', labels=labels, tools=[tool])
    assistant_with_rephraser = sdk.assistants.create('yandexgpt', labels=labels, tools=[tool_with_rephraser])

    # The following code sends queries with and without rephrasing
    # to demonstrate what it does.
    # You can use other queries.
    thread = sdk.threads.create(labels=labels)

    def run(query, rephrase: bool) -> None:
       assistant = assistant_with_rephraser if rephrase else assistant_wo_rephraser

       thread.write(query)
       run = assistant.run(thread)
       result = run.wait()

       print(f"Question: {query}")
       preposition = 'with' if rephrase else 'without'
       print(f"Answer {preposition} rephraser:\n    {result.text!r}")
       print()

    # Let's take two valid and two invalid queries:
    run('Where to escape to?', rephrase=False)  # 1
    run('Wher to cuutt looooose?', rephrase=False)  # 2
    run('Where to go for a break?', rephrase=False)  # 3
    run('Where to escape to?', rephrase=False)  # 4

    # The first two queries require rephrasing:
    run('Where to escape to?', rephrase=True)
    run('Wher to cuutt looooose?', rephrase=True)

    # Let's delete all queries and threads
    # but keep the search index because it takes a long time to create one.
    # You can reuse the search index you created.
    delete_labeled_entities(sdk.assistants.list())
    delete_labeled_entities(sdk.threads.list())


if __name__ == '__main__':
   main()
```