---
sourcePath: en/_sdk-ref/sdk-ref/sync/sdk.md
---
# SDK

## *class* yandex\_cloud\_ml\_sdk.**YCloudML**{#yandex_cloud_ml_sdk.YCloudML}

The main class that needs to be instantiated to work with SDK.

**tools**\: *[Tools](tools.md#yandex_cloud_ml_sdk._tools.domain.Tools)*{#yandex_cloud_ml_sdk.YCloudML.tools}

Domain for creating various tools for assistants and function calling

**models**\: *[Models](models/domain.md#yandex_cloud_ml_sdk._models.Models)*{#yandex_cloud_ml_sdk.YCloudML.models}

Domain for working with models (inference and tuning)

**files**\: *[Files](files.md#yandex_cloud_ml_sdk._files.domain.Files)*{#yandex_cloud_ml_sdk.YCloudML.files}

Domain for working with files (a part of the Asssistants API)

**threads**\: *[Threads](threads.md#yandex_cloud_ml_sdk._threads.domain.Threads)*{#yandex_cloud_ml_sdk.YCloudML.threads}

Domain for working with threads (a part of the Assistants API)

**assistants**\: *[Assistants](assistants.md#yandex_cloud_ml_sdk._assistants.domain.Assistants)*{#yandex_cloud_ml_sdk.YCloudML.assistants}

Domain for working with assistants (a part of the Assistants API)

**runs**\: *[Runs](runs.md#yandex_cloud_ml_sdk._runs.domain.Runs)*{#yandex_cloud_ml_sdk.YCloudML.runs}

Domain for working with assistants’ runs (a part of the Assistants API)

**search\_api**\: *[SearchAPIDomain](search_api.md#yandex_cloud_ml_sdk._search_api.domain.SearchAPIDomain)*{#yandex_cloud_ml_sdk.YCloudML.search_api}

Domain for working with [Search API](https://yandex.cloud/docs/search-api)

**search\_indexes**\: *[SearchIndexes](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.domain.SearchIndexes)*{#yandex_cloud_ml_sdk.YCloudML.search_indexes}

Domain for working with search indexes (a part of the Assistants API)

**datasets**\: *[Datasets](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets)*{#yandex_cloud_ml_sdk.YCloudML.datasets}

Domain for working with datasets

**tuning**\: *[Tuning](tuning.md#yandex_cloud_ml_sdk._tuning.domain.Tuning)*{#yandex_cloud_ml_sdk.YCloudML.tuning}

Domain for working with tuning

**batch**\: *[Batch](batch.md#yandex_cloud_ml_sdk._batch.domain.Batch)*{#yandex_cloud_ml_sdk.YCloudML.batch}

Domain for working with batch tasks

**chat**\: *[Chat](chat/domain.md#yandex_cloud_ml_sdk._chat.Chat)*{#yandex_cloud_ml_sdk.YCloudML.chat}

**\_\_init\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *folder\_id*, *endpoint=Undefined*, *auth=Undefined*, *retry\_policy=Undefined*, *yc\_profile=Undefined*, *service\_map=Undefined*, *interceptors=Undefined*, *enable\_server\_data\_logging=Undefined*, *verify=Undefined*){#yandex_cloud_ml_sdk.YCloudML.__init__i}

Construct a new asynchronous sdk instance.

#|
|| Parameters | 

- **folder\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – Yandex Cloud folder identifier which will be billed for models usage.
- **endpoint** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – domain:port pair for Yandex Cloud API or any other grpc compatible target. In case of **None** passed it turns off service endpoint discovery mechanism and requires **service\_map** to be passed.
- **auth** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseAuth*](../internals/bases.md#yandex_cloud_ml_sdk._auth.BaseAuth) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – string with API Key, IAM token or one of yandex\_cloud\_ml\_sdk.auth objects; in case of default Undefined value, there will be a mechanism to get token from environment
- **service\_map** (*Dict[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – a way to redefine endpoints for one or more cloud subservices with a format of dict **{"service\_name": "service\_address"}**.
- **enable\_server\_data\_logging** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – when passed bool, we will add *x-data-logging-enabled: <value>* to all of requests, which will enable or disable logging of user data on server side. It will do something only on those parts of backends which supports this option.
- **verify** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*pathlib.Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*os.PathLike*](https://docs.python.org/3/library/os.html#os.PathLike)) – SSL certificates (a.k.a CA bundle) used to verify the identity of requested hosts. Either *True* (default CA bundle), a path to an SSL certificate file, or *False* (which will disable verification).
- **retry\_policy** ([*RetryPolicy*](../retry.md#yandex_cloud_ml_sdk._retry.RetryPolicy) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **yc\_profile** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **interceptors** ([*Sequence*](https://docs.python.org/3/library/typing.html#typing.Sequence)*[*[*ClientInterceptor*](https://grpc.github.io/grpc/python/grpc_asyncio.html#grpc.aio.ClientInterceptor)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) ||
|#

**setup\_default\_logging**(*log\_level='INFO'*, *log\_format='[%(levelname)1.1s %(asctime)s %(name)s:%(lineno)d] %(message)s'*, *date\_format='%Y-%m-%d %H:%M:%S'*){#yandex_cloud_ml_sdk.YCloudML.setup_default_logging}

Sets up the default logging configuration.

Read more about log\_levels, log\_format, and date\_format in [Python documentation (logging)](https://docs.python.org/3/library/logging.html).

#|
|| Parameters | 

- **log\_level** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['CRITICAL', 'FATAL', 'ERROR', 'WARN', 'WARNING', 'INFO', 'DEBUG', 'TRACE'] \| ~typing.Literal['critical', 'fatal', 'error', 'warn', 'warning', 'info', 'debug', 'TRACE'] \| int*) – The logging level to set.
- **log\_format** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The format of the log messages.
- **date\_format** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The format for timestamps in log messages. ||
|| Returns | The instance of the SDK with logging configured. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

- [Models domain](models/domain.md)
  - [**Models**](models/domain.md#yandex_cloud_ml_sdk._models.Models)
    - [**Models.completions**](models/domain.md#yandex_cloud_ml_sdk._models.Models.completions)
    - [**Models.text\_embeddings**](models/domain.md#yandex_cloud_ml_sdk._models.Models.text_embeddings)
    - [**Models.text\_classifiers**](models/domain.md#yandex_cloud_ml_sdk._models.Models.text_classifiers)
    - [**Models.image\_generation**](models/domain.md#yandex_cloud_ml_sdk._models.Models.image_generation)
- [Assistants domain](assistants.md)
  - [**Assistants**](assistants.md#yandex_cloud_ml_sdk._assistants.domain.Assistants)
    - [**Assistants.create()**](assistants.md#yandex_cloud_ml_sdk._assistants.domain.Assistants.create)
    - [**Assistants.get()**](assistants.md#yandex_cloud_ml_sdk._assistants.domain.Assistants.get)
    - [**Assistants.list()**](assistants.md#yandex_cloud_ml_sdk._assistants.domain.Assistants.list)
  - [**Assistant**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant)
    - [**Assistant.update()**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.update)
    - [**Assistant.delete()**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.delete)
    - [**Assistant.list\_versions()**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.list_versions)
    - [**Assistant.run()**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.run)
    - [**Assistant.run\_stream()**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.run_stream)
    - [**Assistant.max\_prompt\_tokens**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.max_prompt_tokens)
    - [**Assistant.name**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.name)
    - [**Assistant.description**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.description)
    - [**Assistant.created\_by**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.created_by)
    - [**Assistant.created\_at**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.created_at)
    - [**Assistant.updated\_by**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.updated_by)
    - [**Assistant.updated\_at**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.updated_at)
    - [**Assistant.expires\_at**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.expires_at)
    - [**Assistant.labels**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.labels)
    - [**Assistant.expiration\_config**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.expiration_config)
    - [**Assistant.model**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.model)
    - [**Assistant.instruction**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.instruction)
    - [**Assistant.prompt\_truncation\_options**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.prompt_truncation_options)
    - [**Assistant.tools**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.tools)
    - [**Assistant.response\_format**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.response_format)
    - [**Assistant.id**](assistants.md#yandex_cloud_ml_sdk._assistants.assistant.Assistant.id)
- [Tools domain](tools.md)
  - [**Tools**](tools.md#yandex_cloud_ml_sdk._tools.domain.Tools)
    - [**Tools.function**](tools.md#yandex_cloud_ml_sdk._tools.domain.Tools.function)
    - [**Tools.rephraser**](tools.md#yandex_cloud_ml_sdk._tools.domain.Tools.rephraser)
    - [**Tools.search\_index()**](tools.md#yandex_cloud_ml_sdk._tools.domain.Tools.search_index)
  - [Types](tools.md#types)
    - [**ToolCall**](tools.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCall)
      - [**ToolCall.id**](tools.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCall.id)
      - [**ToolCall.function**](tools.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCall.function)
    - [**FunctionCall**](tools.md#yandex_cloud_ml_sdk._tools.function_call.FunctionCall)
      - [**FunctionCall.name**](tools.md#yandex_cloud_ml_sdk._tools.function_call.FunctionCall.name)
      - [**FunctionCall.arguments**](tools.md#yandex_cloud_ml_sdk._tools.function_call.FunctionCall.arguments)
- [Files domain](files.md)
  - [**Files**](files.md#yandex_cloud_ml_sdk._files.domain.Files)
    - [**Files.upload\_bytes()**](files.md#yandex_cloud_ml_sdk._files.domain.Files.upload_bytes)
    - [**Files.upload()**](files.md#yandex_cloud_ml_sdk._files.domain.Files.upload)
    - [**Files.get()**](files.md#yandex_cloud_ml_sdk._files.domain.Files.get)
    - [**Files.list()**](files.md#yandex_cloud_ml_sdk._files.domain.Files.list)
  - [**File**](files.md#yandex_cloud_ml_sdk._files.file.File)
    - [**File.get\_url()**](files.md#yandex_cloud_ml_sdk._files.file.File.get_url)
    - [**File.update()**](files.md#yandex_cloud_ml_sdk._files.file.File.update)
    - [**File.delete()**](files.md#yandex_cloud_ml_sdk._files.file.File.delete)
    - [**File.download\_as\_bytes()**](files.md#yandex_cloud_ml_sdk._files.file.File.download_as_bytes)
    - [**File.name**](files.md#yandex_cloud_ml_sdk._files.file.File.name)
    - [**File.description**](files.md#yandex_cloud_ml_sdk._files.file.File.description)
    - [**File.mime\_type**](files.md#yandex_cloud_ml_sdk._files.file.File.mime_type)
    - [**File.created\_by**](files.md#yandex_cloud_ml_sdk._files.file.File.created_by)
    - [**File.created\_at**](files.md#yandex_cloud_ml_sdk._files.file.File.created_at)
    - [**File.updated\_by**](files.md#yandex_cloud_ml_sdk._files.file.File.updated_by)
    - [**File.updated\_at**](files.md#yandex_cloud_ml_sdk._files.file.File.updated_at)
    - [**File.expires\_at**](files.md#yandex_cloud_ml_sdk._files.file.File.expires_at)
    - [**File.labels**](files.md#yandex_cloud_ml_sdk._files.file.File.labels)
    - [**File.expiration\_config**](files.md#yandex_cloud_ml_sdk._files.file.File.expiration_config)
    - [**File.id**](files.md#yandex_cloud_ml_sdk._files.file.File.id)
- [Threads domain](threads.md)
  - [**Threads**](threads.md#yandex_cloud_ml_sdk._threads.domain.Threads)
    - [**Threads.create()**](threads.md#yandex_cloud_ml_sdk._threads.domain.Threads.create)
    - [**Threads.get()**](threads.md#yandex_cloud_ml_sdk._threads.domain.Threads.get)
    - [**Threads.list()**](threads.md#yandex_cloud_ml_sdk._threads.domain.Threads.list)
  - [**Thread**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread)
    - [**Thread.update()**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.update)
    - [**Thread.delete()**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.delete)
    - [**Thread.write()**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.write)
    - [**Thread.read()**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.read)
    - [**Thread.name**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.name)
    - [**Thread.description**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.description)
    - [**Thread.created\_by**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.created_by)
    - [**Thread.created\_at**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.created_at)
    - [**Thread.updated\_by**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.updated_by)
    - [**Thread.updated\_at**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.updated_at)
    - [**Thread.expires\_at**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.expires_at)
    - [**Thread.labels**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.labels)
    - [**Thread.expiration\_config**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.expiration_config)
    - [**Thread.id**](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread.id)
- [Runs domain](runs.md)
  - [**Runs**](runs.md#yandex_cloud_ml_sdk._runs.domain.Runs)
    - [**Runs.get()**](runs.md#yandex_cloud_ml_sdk._runs.domain.Runs.get)
    - [**Runs.get\_last\_by\_thread()**](runs.md#yandex_cloud_ml_sdk._runs.domain.Runs.get_last_by_thread)
    - [**Runs.list()**](runs.md#yandex_cloud_ml_sdk._runs.domain.Runs.list)
  - [**Run**](runs.md#yandex_cloud_ml_sdk._runs.run.Run)
    - [**Run.listen()**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.listen)
    - [**Run.submit\_tool\_results()**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.submit_tool_results)
    - [**Run.cancel()**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.cancel)
    - [**Run.custom\_max\_prompt\_tokens**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.custom_max_prompt_tokens)
    - [**Run.get\_result()**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.get_result)
    - [**Run.get\_status()**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.get_status)
    - [**Run.wait()**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.wait)
    - [**Run.id**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.id)
    - [**Run.assistant\_id**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.assistant_id)
    - [**Run.thread\_id**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.thread_id)
    - [**Run.created\_by**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.created_by)
    - [**Run.created\_at**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.created_at)
    - [**Run.labels**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.labels)
    - [**Run.custom\_temperature**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.custom_temperature)
    - [**Run.custom\_max\_tokens**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.custom_max_tokens)
    - [**Run.custom\_prompt\_truncation\_options**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.custom_prompt_truncation_options)
    - [**Run.custom\_response\_format**](runs.md#yandex_cloud_ml_sdk._runs.run.Run.custom_response_format)
- [Search indexes domain](search_indexes.md)
  - [**SearchIndexes**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.domain.SearchIndexes)
    - [**SearchIndexes.create\_deferred()**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.domain.SearchIndexes.create_deferred)
    - [**SearchIndexes.get()**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.domain.SearchIndexes.get)
    - [**SearchIndexes.list()**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.domain.SearchIndexes.list)
  - [**SearchIndex**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex)
    - [**SearchIndex.update()**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.update)
    - [**SearchIndex.delete()**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.delete)
    - [**SearchIndex.get\_file()**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.get_file)
    - [**SearchIndex.list\_files()**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.list_files)
    - [**SearchIndex.add\_files\_deferred()**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.add_files_deferred)
    - [**SearchIndex.folder\_id**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.folder_id)
    - [**SearchIndex.name**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.name)
    - [**SearchIndex.description**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.description)
    - [**SearchIndex.created\_by**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.created_by)
    - [**SearchIndex.created\_at**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.created_at)
    - [**SearchIndex.updated\_by**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.updated_by)
    - [**SearchIndex.updated\_at**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.updated_at)
    - [**SearchIndex.expires\_at**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.expires_at)
    - [**SearchIndex.labels**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.labels)
    - [**SearchIndex.index\_type**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.index_type)
    - [**SearchIndex.expiration\_config**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.expiration_config)
    - [**SearchIndex.id**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex.id)
- [Search API domain](search_api.md)
  - [**SearchAPIDomain**](search_api.md#yandex_cloud_ml_sdk._search_api.domain.SearchAPIDomain)
    - [**SearchAPIDomain.generative**](search_api.md#yandex_cloud_ml_sdk._search_api.domain.SearchAPIDomain.generative)
  - [**GenerativeSearchFunction**](search_api.md#yandex_cloud_ml_sdk._search_api.generative.function.GenerativeSearchFunction)
    - [**GenerativeSearchFunction.\_\_call\_\_()**](search_api.md#yandex_cloud_ml_sdk._search_api.generative.function.GenerativeSearchFunction.__call__i)
    - [**GenerativeSearchFunction.available\_formats**](search_api.md#yandex_cloud_ml_sdk._search_api.generative.function.GenerativeSearchFunction.available_formats)
  - [**GenerativeSearch**](search_api.md#yandex_cloud_ml_sdk._search_api.generative.generative.GenerativeSearch)
    - [**GenerativeSearch.run()**](search_api.md#yandex_cloud_ml_sdk._search_api.generative.generative.GenerativeSearch.run)
    - [**GenerativeSearch.config**](search_api.md#yandex_cloud_ml_sdk._search_api.generative.generative.GenerativeSearch.config)
    - [**GenerativeSearch.configure()**](search_api.md#yandex_cloud_ml_sdk._search_api.generative.generative.GenerativeSearch.configure)
    - [**GenerativeSearch.uri**](search_api.md#yandex_cloud_ml_sdk._search_api.generative.generative.GenerativeSearch.uri)
- [Datasets domain](datasets.md)
  - [**Datasets**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets)
    - [**Datasets.get()**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.get)
    - [**Datasets.list()**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.list)
    - [**Datasets.list\_upload\_formats()**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.list_upload_formats)
    - [**Datasets.list\_upload\_schemas()**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.list_upload_schemas)
    - [**Datasets.completions**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.completions)
    - [**Datasets.draft\_from\_path()**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.draft_from_path)
    - [**Datasets.text\_classifiers\_binary**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_classifiers_binary)
    - [**Datasets.text\_classifiers\_multiclass**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_classifiers_multiclass)
    - [**Datasets.text\_classifiers\_multilabel**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_classifiers_multilabel)
    - [**Datasets.text\_embeddings\_pair**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_embeddings_pair)
    - [**Datasets.text\_embeddings\_triplet**](datasets.md#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_embeddings_triplet)
  - [**Dataset**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset)
    - [**Dataset.update()**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.update)
    - [**Dataset.delete()**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.delete)
    - [**Dataset.list\_upload\_formats()**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.list_upload_formats)
    - [**Dataset.download()**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.download)
    - [**Dataset.read()**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.read)
    - [**Dataset.folder\_id**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.folder_id)
    - [**Dataset.name**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.name)
    - [**Dataset.description**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.description)
    - [**Dataset.metadata**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.metadata)
    - [**Dataset.created\_by**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.created_by)
    - [**Dataset.created\_at**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.created_at)
    - [**Dataset.updated\_at**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.updated_at)
    - [**Dataset.labels**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.labels)
    - [**Dataset.allow\_data\_logging**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.allow_data_logging)
    - [**Dataset.status**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.status)
    - [**Dataset.task\_type**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.task_type)
    - [**Dataset.rows**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.rows)
    - [**Dataset.size\_bytes**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.size_bytes)
    - [**Dataset.validation\_errors**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.validation_errors)
    - [**Dataset.id**](datasets.md#yandex_cloud_ml_sdk._datasets.dataset.Dataset.id)
  - [**DatasetDraft**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft)
    - [**DatasetDraft.upload\_deferred()**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.upload_deferred)
    - [**DatasetDraft.upload()**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.upload)
    - [**DatasetDraft.allow\_data\_logging**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.allow_data_logging)
    - [**DatasetDraft.configure()**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.configure)
    - [**DatasetDraft.description**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.description)
    - [**DatasetDraft.labels**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.labels)
    - [**DatasetDraft.metadata**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.metadata)
    - [**DatasetDraft.name**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.name)
    - [**DatasetDraft.path**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.path)
    - [**DatasetDraft.task\_type**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.task_type)
    - [**DatasetDraft.upload\_format**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.upload_format)
    - [**DatasetDraft.validate()**](datasets.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.validate)
- [Tuning domain](tuning.md)
  - [**Tuning**](tuning.md#yandex_cloud_ml_sdk._tuning.domain.Tuning)
    - [**Tuning.get()**](tuning.md#yandex_cloud_ml_sdk._tuning.domain.Tuning.get)
    - [**Tuning.list()**](tuning.md#yandex_cloud_ml_sdk._tuning.domain.Tuning.list)
- [Batch domain](batch.md)
  - [**Batch**](batch.md#yandex_cloud_ml_sdk._batch.domain.Batch)
    - [**Batch.get()**](batch.md#yandex_cloud_ml_sdk._batch.domain.Batch.get)
    - [**Batch.list\_operations()**](batch.md#yandex_cloud_ml_sdk._batch.domain.Batch.list_operations)
    - [**Batch.list\_info()**](batch.md#yandex_cloud_ml_sdk._batch.domain.Batch.list_info)
  - [**BatchTaskOperation**](batch.md#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation)
    - [**BatchTaskOperation.delete()**](batch.md#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.delete)
    - [**BatchTaskOperation.get\_task\_info()**](batch.md#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.get_task_info)
    - [**BatchTaskOperation.cancel()**](batch.md#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.cancel)
    - [**BatchTaskOperation.get\_result()**](batch.md#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.get_result)
    - [**BatchTaskOperation.get\_status()**](batch.md#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.get_status)
    - [**BatchTaskOperation.id**](batch.md#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.id)
    - [**BatchTaskOperation.task\_id**](batch.md#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.task_id)
    - [**BatchTaskOperation.wait()**](batch.md#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.wait)
- [Chat domain](chat/domain.md)
  - [**Chat**](chat/domain.md#yandex_cloud_ml_sdk._chat.Chat)
    - [**Chat.completions**](chat/domain.md#yandex_cloud_ml_sdk._chat.Chat.completions)