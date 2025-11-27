---
title: Managing {{ vector-store-name }} search index
description: Follow this guide to use the {{ vector-store-name }} API to create, modify, and delete a search index, which will allow you to implement a retrieval augmented generation (RAG) scenario using {{ retrieval-tool-name }}.
---

# Managing {{ vector-store-name }} search index

[AI agents](../../concepts/agents/index.md) can use semantic search based on context obtained from external knowledge base files. This additional context is stored in {{ vector-store-name }} [search indexes](../../concepts/search/vectorstore.md): special {{ foundation-models-full-name }} vector storages created using the {{ vector-store-name }} API, in which documents are represented as vectors ([embeddings](../../concepts/embeddings.md)).

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- Python {#python}

  1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `ai.assistants.editor` and `ai.languageModels.user` [roles](../../security/index.md#service-roles) to it.
  1. [Get](../get-api-key.md#run-client) and save the service account's [API key](../../../iam/concepts/authorization/api-key.md).
  
        {% note info %}
        
        If you are using [Windows](https://en.wikipedia.org/wiki/Microsoft_Windows), we recommend [installing](https://learn.microsoft.com/en-us/windows/wsl/install) the [WSL](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) shell first and using it to proceed.
        
        {% endnote %}

  1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. Install the OpenAI [library](https://github.com/openai/openai-python) for Python:

      ```bash
      pip install openai
      ```

{% endlist %}

## Upload the source files {#upload-files}

Before creating a search index, upload the files you want to index to {{ vector-store-name }}:

{% list tabs group=programming_language %}

- Python {#python}

  1. {% include [download-context-file-step](../../../_includes/ai-studio/assistants/download-context-file-step.md) %}
  1. Create a file named `upload.py` and paste the following code into it:

      ```python
      import os
      import pathlib
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API_key>"
      YANDEX_FOLDER_ID = "<folder_ID>"


      # Local file for indexing
      def local_path(path: str) -> pathlib.Path:
          return pathlib.Path(__file__).parent / path


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          # Uploading multiple files
          file_names = ["bali.md", "kazakhstan.md"]
          file_ids = []

          print("Uploading files...")
          for fname in file_names:
              f = client.files.create(
                  file=open(local_path(fname), "rb"),
                  # The `assistants` value is used for all files that need to connect
                  # to the Vector Store API
                  purpose="assistants",
              )
              print(f"{fname} uploaded:", f.id)
              file_ids.append(f.id)


      if __name__ == "__main__":
          main()
      ```

      Where:

      * `YANDEX_API_KEY`: Service account [API key](../../../iam/concepts/authorization/api-key.md) you got before you started.
      * `YANDEX_FOLDER_ID`: ID of the [folder](../../../resource-manager/operations/folder/get-id.md) for operations with the {{ vector-store-name }} API.

  1. Run the file you created:

      ```bash
      python3 upload.py
      ```

      Result:

      ```text
      Uploading files...
      bali.md uploaded: fvt5ajp8l83v********
      kazakhstan.md uploaded: fvtbq10jv46r********
      ```

      Save the uploaded files' IDs you got: you will need them to create a search index.

{% endlist %}

## Create a {{ vector-store-name }} search index {#create-index}

Create a search index from the files uploaded in the previous step:

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `index.py` and paste the following code into it:

      ```python
      import os
      import pathlib
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API_key>"
      YANDEX_FOLDER_ID = "<folder_ID>"


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          input_file_ids = ["<file_1_ID>", "<file_2_ID>"]

          # Creating a search index with several files
          print("Creating a search index...")
          vector_store = client.vector_stores.create(
              # Descriptive index name
              name="Support knowledge base",
              # Your file labels
              metadata={"key": "value"},
              # Index lifetime
              # last_active_at: since last active
              expires_after={"anchor": "last_active_at", "days": 1},
              # or created_at: since created
              # expires_after={"anchor": "created_at", "days": 1},
              file_ids=input_file_ids,  # <- list of files
          )
          vector_store_id = vector_store.id
          print("Vector store created:", vector_store_id)

          # Waiting for the search index to get ready
          while True:
              vector_store = client.vector_stores.retrieve(vector_store_id)
              print("Vector store status:", vector_store.status)
              # in_progress: Index building in progress (files are being uploaded, divided into fragments, embeddings are being calculated).
              # completed: All set, you can begin searching.
              # failed: Something went wrong while building the index.
              if vector_store.status == "completed":
                  break
              time.sleep(2)

          print("Vector store is ready for use.")


      if __name__ == "__main__":
          main()
      ```

      Where `input_file_ids` is a list of IDs of uploaded source files.

  1. Run the file you created:

      ```bash
      python3 index.py
      ```

      Result:

      ```text
      Creating a search index...
      Vector store created: fvt9ef7q28n5b2c9quh8
      Vector store status: in_progress
      Vector store status: in_progress
      Vector store status: in_progress
      Vector store status: in_progress
      Vector store status: completed
      Vector store is ready for use.
      ```

      Save the resulting index ID. You will need it to execute a search query.

{% endlist %}

## Run a search through the {{ vector-store-name }} index {#search-index}

To run a search through the index, provide the index ID and the text of your query to the {{ vector-store-name }} API:

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `query.py` and paste the following code into it:

      ```python
      import os
      import pathlib
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API_key>"
      YANDEX_FOLDER_ID = "<folder_ID>"


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          index_id = "<search_index_ID>"

          # Searching through the index
          query = "Cost of a trip to Bali"
          print(f"Searching based on query: {query}")
          results = client.vector_stores.search(index_id, query=query)
          for r in results:
              print("Result:", r)


      if __name__ == "__main__":
          main()
      ```

      Where `index_id` is the {{ vector-store-name }} search index ID you got in the previous step.

  1. Run the file you created:

      ```bash
      python3 query.py
      ```

      Result:

      ```text
      Searching based on query: Cost of a trip to Bali
      Result: VectorStoreSearchResponse(attributes={}, content=[Content(text='**Bali is a tropical paradise 
      full of unforgettable experiences!**\n\nWe invite you to spend an amazing vacation in Bali. This 
      magical Indonesian island is famous for its beautiful beaches, unique culture, and warm hospitality 
      of its people. Enjoy its natural beauty, try local cuisine, and make 
      new friends. **What do I need for the trip?** To enter Indonesia, you will need a visa. Here 
      is the list of documents you need to get a visa:\n* Passport valid for at least 
      six months from your entry date. * Two photos as per the 
      consulate requirements. * Hotel booking confirmation or a letter for alternative accommodation. * Round-trip booking or 
      tickets. * Form filled out in English. Note that requirements may change, 
      so be sure to check the current information on the consulate or visa center's website when planning your 
      trip. The visa fee is 300 rubles. Don't miss out on the opportunity to visit this beautiful island 
      for a vibrant vacation! Book your Bali vacation today! **We look forward to seeing you!**', type='text', 
      valid=True)], file_id='fvt5ajp8l83v********', filename='bali.md', score=0.9999999979850982, valid=True)

      Result: VectorStoreSearchResponse(attributes={}, content=[Content(text='**Kazakhstan: A journey 
      to the heart of Eurasia**\n\nDiscover Kazakhstan, a fascinating country where East meets West. 
      Enjoy its endless steppes, majestic mountains, historical landmarks, 
      and the warm hospitality of its people. **What do I need for the trip?** To enter Kazakhstan from Russia, you 
      will need the following documents:\n* Passport valid for at least 3 months 
      beyond your trip. * Migration card (issued in-flight or at the border). * Medical 
      insurance (optional but recommended). Don't miss out on the opportunity to visit this beautiful country 
      for a vibrant vacation! Book your Kazakhstan vacation today! **We look forward to seeing you!**', 
      type='text', valid=True)], file_id='fvtbq10jv46r********', filename='kazakhstan.md', score=0.0, 
      valid=True)
      ```

      As a result, the {{ vector-store-name }} API will return text fragments stating the file name and ID, as well as the search query's relevance score for each fragment.

{% endlist %}

## Remove one of the source files from the index {#remove-file}

To remove a source file from the search index, provide the index ID and the file ID to the {{ vector-store-name }} API:

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `remove_file.py` and paste the following code into it:

      ```python
      import os
      import pathlib
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API_key>"
      YANDEX_FOLDER_ID = "<folder_ID>"


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          index_id = "<search_index_ID>"

          file_to_delete = "<ID_of_file_to_delete>"

          # Deleting one file from the index
          print("Deleting one file from the search index...")
          deleted_file = client.vector_stores.files.delete(
              file_to_delete, vector_store_id=index_id
          )
          print(f"{file_to_delete} deleted from index:", deleted_file)


      if __name__ == "__main__":
          main()
      ```

      Where:

      * `index_id`: {{ vector-store-name }} search index ID you got earlier.
      * `file_to_delete`: ID of the file you need to delete. You got the IDs earlier when uploading the files and when performing a search query.

  1. Run the file you created:

      ```bash
      python3 remove_file.py
      ```

      Result:

      ```text
      Deleting one file from the search index...
      fvt5ajp8l83v******** deleted from the index: VectorStoreFileDeleted(id='fvt5ajp8l83v********', deleted=True, object='vector_store.file.deleted', valid=True)
      ```

{% endlist %}

## Delete the {{ vector-store-name }} search index {#delete-index}

To delete the entire search index, provide its ID to the {{ vector-store-name }} API:

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `delete_index.py` and paste the following code into it:

      ```python
      import os
      import pathlib
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API_key>"
      YANDEX_FOLDER_ID = "<folder_ID>"


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          index_id = "<search_index_ID>"

          # Deleting the entire vector store
          deleted_store = client.vector_stores.delete(index_id)
          print("Vector store deleted:", deleted_store)


      if __name__ == "__main__":
          main()
      ```

      Where `index_id` is the {{ vector-store-name }} search index ID you got earlier.

  1. Run the file you created:

      ```bash
      python3 delete_index.py
      ```

      Result:

      ```text
      Vector store deleted: VectorStoreDeleted(id='fvt9ef7q28n5********', deleted=True, object='vector_store.deleted', valid=True)
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/search/vectorstore.md)
* [{#T}](../assistant/create-with-searchindex.md)