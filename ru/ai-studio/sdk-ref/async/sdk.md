# Async SDK

## *class* yandex\_ai\_studio\_sdk.**AsyncAIStudio**{#yandex_ai_studio_sdk.AsyncAIStudio}

The main class that needs to be instantiated to work with SDK.

**tools**\: *[AsyncTools](tools.md#yandex_ai_studio_sdk._tools.domain.AsyncTools)*{#yandex_ai_studio_sdk.AsyncAIStudio.tools}

Domain for creating various tools for assistants and function calling

**models**\: *[AsyncModels](models/domain.md#yandex_ai_studio_sdk._models.AsyncModels)*{#yandex_ai_studio_sdk.AsyncAIStudio.models}

Domain for working with models (inference and tuning)

**files**\: *[AsyncFiles](files.md#yandex_ai_studio_sdk._files.domain.AsyncFiles)*{#yandex_ai_studio_sdk.AsyncAIStudio.files}

Domain for working with files (a part of the Asssistants API)

**threads**\: *[AsyncThreads](threads.md#yandex_ai_studio_sdk._threads.domain.AsyncThreads)*{#yandex_ai_studio_sdk.AsyncAIStudio.threads}

Domain for working with threads (a part of the Assistants API)

**assistants**\: *[AsyncAssistants](assistants.md#yandex_ai_studio_sdk._assistants.domain.AsyncAssistants)*{#yandex_ai_studio_sdk.AsyncAIStudio.assistants}

Domain for working with assistants (a part of the Assistants API)

**runs**\: *[AsyncRuns](runs.md#yandex_ai_studio_sdk._runs.domain.AsyncRuns)*{#yandex_ai_studio_sdk.AsyncAIStudio.runs}

Domain for working with assistants’ runs (a part of the Assistants API)

**search\_api**\: *[AsyncSearchAPIDomain](search_api.md#yandex_ai_studio_sdk._search_api.domain.AsyncSearchAPIDomain)*{#yandex_ai_studio_sdk.AsyncAIStudio.search_api}

Domain for working with [Search API](https://yandex.cloud/docs/search-api)

**search\_indexes**\: *[AsyncSearchIndexes](search_indexes.md#yandex_ai_studio_sdk._search_indexes.domain.AsyncSearchIndexes)*{#yandex_ai_studio_sdk.AsyncAIStudio.search_indexes}

Domain for working with search indexes (a part of the Assistants API)

**datasets**\: *[AsyncDatasets](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets)*{#yandex_ai_studio_sdk.AsyncAIStudio.datasets}

Domain for working with datasets

**tuning**\: *[AsyncTuning](tuning.md#yandex_ai_studio_sdk._tuning.domain.AsyncTuning)*{#yandex_ai_studio_sdk.AsyncAIStudio.tuning}

Domain for working with tuning

**batch**\: *[AsyncBatch](batch.md#yandex_ai_studio_sdk._batch.domain.AsyncBatch)*{#yandex_ai_studio_sdk.AsyncAIStudio.batch}

Domain for working with batch tasks

**chat**\: *[AsyncChat](chat/domain.md#yandex_ai_studio_sdk._chat.AsyncChat)*{#yandex_ai_studio_sdk.AsyncAIStudio.chat}

Domain for working with [Yandex Cloud OpenAI Compatible API\_BaseSDK\_URL](https://yandex.cloud/docs/ai-studio/concepts/openai-compatibility).

**speechkit**\: *[AsyncSpeechKitDomain](speechkit/domain.md#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain)*{#yandex_ai_studio_sdk.AsyncAIStudio.speechkit}

Domain for working with [Yandex SpeechKit](https://yandex.cloud/docs/speechkit) services.

**\_\_init\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *folder\_id=Undefined*, *endpoint=Undefined*, *auth=Undefined*, *retry\_policy=Undefined*, *yc\_profile=Undefined*, *service\_map=Undefined*, *interceptors=Undefined*, *enable\_server\_data\_logging=Undefined*, *verify=Undefined*){#yandex_ai_studio_sdk.AsyncAIStudio.__init__i}

Construct a new asynchronous sdk instance.

#|
|| Parameters | 

- **folder\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – Yandex Cloud folder identifier which will be billed for models usage. In case of default Undefined value, the parameter will be taken from the environment variable **YC\_FOLDER\_ID**.
- **endpoint** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – domain:port pair for Yandex Cloud API or any other grpc compatible target. In case of **None** passed it turns off service endpoint discovery mechanism and requires **service\_map** to be passed.
- **auth** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseAuth*](../internals/bases.md#yandex_ai_studio_sdk._auth.BaseAuth) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – string with API Key, IAM token or one of yandex\_ai\_studio\_sdk.auth objects; in case of default Undefined value, the token will be taken from one of the environment variables: **YC\_OAUTH\_TOKEN**, **YC\_TOKEN**, **YC\_IAM\_TOKEN**, or **YC\_API\_KEY**.
- **service\_map** (*Dict[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – a way to redefine endpoints for one or more cloud subservices with a format of dict **{"service\_name": "service\_address"}**.
- **enable\_server\_data\_logging** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – when passed bool, we will add *x-data-logging-enabled: <value>* to all of requests, which will enable or disable logging of user data on server side. It will do something only on those parts of backends which supports this option.
- **verify** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*pathlib.Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*os.PathLike*](https://docs.python.org/3/library/os.html#os.PathLike)) – SSL certificates (a.k.a CA bundle) used to verify the identity of requested hosts. Either *True* (default CA bundle), a path to an SSL certificate file, or *False* (which will disable verification).
- **retry\_policy** ([*RetryPolicy*](../retry.md#yandex_ai_studio_sdk._retry.RetryPolicy) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **yc\_profile** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **interceptors** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*ClientInterceptor*](https://grpc.github.io/grpc/python/grpc_asyncio.html#grpc.aio.ClientInterceptor)*] \|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) ||
|#

**setup\_default\_logging**(*log\_level='INFO'*, *log\_format='[%(levelname)1.1s %(asctime)s %(name)s:%(lineno)d] %(message)s'*, *date\_format='%Y-%m-%d %H:%M:%S'*){#yandex_ai_studio_sdk.AsyncAIStudio.setup_default_logging}

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
  - [**AsyncModels**](models/domain.md#yandex_ai_studio_sdk._models.AsyncModels)
    - [**AsyncModels.completions**](models/domain.md#yandex_ai_studio_sdk._models.AsyncModels.completions)
    - [**AsyncModels.text\_embeddings**](models/domain.md#yandex_ai_studio_sdk._models.AsyncModels.text_embeddings)
    - [**AsyncModels.text\_classifiers**](models/domain.md#yandex_ai_studio_sdk._models.AsyncModels.text_classifiers)
    - [**AsyncModels.image\_generation**](models/domain.md#yandex_ai_studio_sdk._models.AsyncModels.image_generation)
- [Assistants domain](assistants.md)
  - [**AsyncAssistants**](assistants.md#yandex_ai_studio_sdk._assistants.domain.AsyncAssistants)
    - [**AsyncAssistants.create()**](assistants.md#yandex_ai_studio_sdk._assistants.domain.AsyncAssistants.create)
    - [**AsyncAssistants.get()**](assistants.md#yandex_ai_studio_sdk._assistants.domain.AsyncAssistants.get)
    - [**AsyncAssistants.list()**](assistants.md#yandex_ai_studio_sdk._assistants.domain.AsyncAssistants.list)
  - [**AsyncAssistant**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant)
    - [**AsyncAssistant.update()**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.update)
    - [**AsyncAssistant.delete()**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.delete)
    - [**AsyncAssistant.list\_versions()**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.list_versions)
    - [**AsyncAssistant.run()**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.run)
    - [**AsyncAssistant.run\_stream()**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.run_stream)
    - [**AsyncAssistant.max\_prompt\_tokens**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.max_prompt_tokens)
    - [**AsyncAssistant.name**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.name)
    - [**AsyncAssistant.description**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.description)
    - [**AsyncAssistant.created\_by**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.created_by)
    - [**AsyncAssistant.created\_at**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.created_at)
    - [**AsyncAssistant.updated\_by**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.updated_by)
    - [**AsyncAssistant.updated\_at**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.updated_at)
    - [**AsyncAssistant.expires\_at**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.expires_at)
    - [**AsyncAssistant.labels**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.labels)
    - [**AsyncAssistant.expiration\_config**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.expiration_config)
    - [**AsyncAssistant.model**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.model)
    - [**AsyncAssistant.instruction**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.instruction)
    - [**AsyncAssistant.prompt\_truncation\_options**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.prompt_truncation_options)
    - [**AsyncAssistant.tools**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.tools)
    - [**AsyncAssistant.response\_format**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.response_format)
    - [**AsyncAssistant.id**](assistants.md#yandex_ai_studio_sdk._assistants.assistant.AsyncAssistant.id)
- [Tools domain](tools.md)
  - [**AsyncTools**](tools.md#yandex_ai_studio_sdk._tools.domain.AsyncTools)
    - [**AsyncTools.function**](tools.md#yandex_ai_studio_sdk._tools.domain.AsyncTools.function)
    - [**AsyncTools.generative\_search()**](tools.md#yandex_ai_studio_sdk._tools.domain.AsyncTools.generative_search)
    - [**AsyncTools.rephraser**](tools.md#yandex_ai_studio_sdk._tools.domain.AsyncTools.rephraser)
    - [**AsyncTools.search\_index()**](tools.md#yandex_ai_studio_sdk._tools.domain.AsyncTools.search_index)
  - [Types](tools.md#types)
    - [**AsyncToolCall**](tools.md#yandex_ai_studio_sdk._tools.tool_call.AsyncToolCall)
      - [**AsyncToolCall.id**](tools.md#yandex_ai_studio_sdk._tools.tool_call.AsyncToolCall.id)
      - [**AsyncToolCall.function**](tools.md#yandex_ai_studio_sdk._tools.tool_call.AsyncToolCall.function)
    - [**AsyncFunctionCall**](tools.md#yandex_ai_studio_sdk._tools.function_call.AsyncFunctionCall)
      - [**AsyncFunctionCall.name**](tools.md#yandex_ai_studio_sdk._tools.function_call.AsyncFunctionCall.name)
      - [**AsyncFunctionCall.arguments**](tools.md#yandex_ai_studio_sdk._tools.function_call.AsyncFunctionCall.arguments)
- [Files domain](files.md)
  - [**AsyncFiles**](files.md#yandex_ai_studio_sdk._files.domain.AsyncFiles)
    - [**AsyncFiles.upload\_bytes()**](files.md#yandex_ai_studio_sdk._files.domain.AsyncFiles.upload_bytes)
    - [**AsyncFiles.upload()**](files.md#yandex_ai_studio_sdk._files.domain.AsyncFiles.upload)
    - [**AsyncFiles.get()**](files.md#yandex_ai_studio_sdk._files.domain.AsyncFiles.get)
    - [**AsyncFiles.list()**](files.md#yandex_ai_studio_sdk._files.domain.AsyncFiles.list)
  - [**AsyncFile**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile)
    - [**AsyncFile.get\_url()**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.get_url)
    - [**AsyncFile.update()**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.update)
    - [**AsyncFile.delete()**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.delete)
    - [**AsyncFile.download\_as\_bytes()**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.download_as_bytes)
    - [**AsyncFile.name**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.name)
    - [**AsyncFile.description**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.description)
    - [**AsyncFile.mime\_type**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.mime_type)
    - [**AsyncFile.created\_by**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.created_by)
    - [**AsyncFile.created\_at**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.created_at)
    - [**AsyncFile.updated\_by**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.updated_by)
    - [**AsyncFile.updated\_at**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.updated_at)
    - [**AsyncFile.expires\_at**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.expires_at)
    - [**AsyncFile.labels**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.labels)
    - [**AsyncFile.expiration\_config**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.expiration_config)
    - [**AsyncFile.id**](files.md#yandex_ai_studio_sdk._files.file.AsyncFile.id)
- [Threads domain](threads.md)
  - [**AsyncThreads**](threads.md#yandex_ai_studio_sdk._threads.domain.AsyncThreads)
    - [**AsyncThreads.create()**](threads.md#yandex_ai_studio_sdk._threads.domain.AsyncThreads.create)
    - [**AsyncThreads.get()**](threads.md#yandex_ai_studio_sdk._threads.domain.AsyncThreads.get)
    - [**AsyncThreads.list()**](threads.md#yandex_ai_studio_sdk._threads.domain.AsyncThreads.list)
  - [**AsyncThread**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread)
    - [**AsyncThread.update()**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.update)
    - [**AsyncThread.delete()**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.delete)
    - [**AsyncThread.write()**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.write)
    - [**AsyncThread.read()**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.read)
    - [**AsyncThread.name**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.name)
    - [**AsyncThread.description**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.description)
    - [**AsyncThread.created\_by**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.created_by)
    - [**AsyncThread.created\_at**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.created_at)
    - [**AsyncThread.updated\_by**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.updated_by)
    - [**AsyncThread.updated\_at**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.updated_at)
    - [**AsyncThread.expires\_at**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.expires_at)
    - [**AsyncThread.labels**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.labels)
    - [**AsyncThread.expiration\_config**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.expiration_config)
    - [**AsyncThread.id**](threads.md#yandex_ai_studio_sdk._threads.thread.AsyncThread.id)
- [Runs domain](runs.md)
  - [**AsyncRuns**](runs.md#yandex_ai_studio_sdk._runs.domain.AsyncRuns)
    - [**AsyncRuns.get()**](runs.md#yandex_ai_studio_sdk._runs.domain.AsyncRuns.get)
    - [**AsyncRuns.get\_last\_by\_thread()**](runs.md#yandex_ai_studio_sdk._runs.domain.AsyncRuns.get_last_by_thread)
    - [**AsyncRuns.list()**](runs.md#yandex_ai_studio_sdk._runs.domain.AsyncRuns.list)
  - [**AsyncRun**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun)
    - [**AsyncRun.listen()**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.listen)
    - [**AsyncRun.submit\_tool\_results()**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.submit_tool_results)
    - [**AsyncRun.cancel()**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.cancel)
    - [**AsyncRun.custom\_max\_prompt\_tokens**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.custom_max_prompt_tokens)
    - [**AsyncRun.get\_result()**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.get_result)
    - [**AsyncRun.get\_status()**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.get_status)
    - [**AsyncRun.wait()**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.wait)
    - [**AsyncRun.id**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.id)
    - [**AsyncRun.assistant\_id**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.assistant_id)
    - [**AsyncRun.thread\_id**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.thread_id)
    - [**AsyncRun.created\_by**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.created_by)
    - [**AsyncRun.created\_at**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.created_at)
    - [**AsyncRun.labels**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.labels)
    - [**AsyncRun.custom\_temperature**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.custom_temperature)
    - [**AsyncRun.custom\_max\_tokens**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.custom_max_tokens)
    - [**AsyncRun.custom\_prompt\_truncation\_options**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.custom_prompt_truncation_options)
    - [**AsyncRun.custom\_response\_format**](runs.md#yandex_ai_studio_sdk._runs.run.AsyncRun.custom_response_format)
- [Search indexes domain](search_indexes.md)
  - [**AsyncSearchIndexes**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.domain.AsyncSearchIndexes)
    - [**AsyncSearchIndexes.create\_deferred()**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.domain.AsyncSearchIndexes.create_deferred)
    - [**AsyncSearchIndexes.get()**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.domain.AsyncSearchIndexes.get)
    - [**AsyncSearchIndexes.list()**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.domain.AsyncSearchIndexes.list)
  - [**AsyncSearchIndex**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex)
    - [**AsyncSearchIndex.update()**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.update)
    - [**AsyncSearchIndex.delete()**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.delete)
    - [**AsyncSearchIndex.get\_file()**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.get_file)
    - [**AsyncSearchIndex.list\_files()**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.list_files)
    - [**AsyncSearchIndex.add\_files\_deferred()**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.add_files_deferred)
    - [**AsyncSearchIndex.folder\_id**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.folder_id)
    - [**AsyncSearchIndex.name**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.name)
    - [**AsyncSearchIndex.description**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.description)
    - [**AsyncSearchIndex.created\_by**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.created_by)
    - [**AsyncSearchIndex.created\_at**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.created_at)
    - [**AsyncSearchIndex.updated\_by**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.updated_by)
    - [**AsyncSearchIndex.updated\_at**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.updated_at)
    - [**AsyncSearchIndex.expires\_at**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.expires_at)
    - [**AsyncSearchIndex.labels**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.labels)
    - [**AsyncSearchIndex.index\_type**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.index_type)
    - [**AsyncSearchIndex.expiration\_config**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.expiration_config)
    - [**AsyncSearchIndex.id**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex.id)
- [Search API domain](search_api.md)
  - [**AsyncSearchAPIDomain**](search_api.md#yandex_ai_studio_sdk._search_api.domain.AsyncSearchAPIDomain)
    - [**AsyncSearchAPIDomain.generative**](search_api.md#yandex_ai_studio_sdk._search_api.domain.AsyncSearchAPIDomain.generative)
    - [**AsyncSearchAPIDomain.web**](search_api.md#yandex_ai_studio_sdk._search_api.domain.AsyncSearchAPIDomain.web)
    - [**AsyncSearchAPIDomain.image**](search_api.md#yandex_ai_studio_sdk._search_api.domain.AsyncSearchAPIDomain.image)
    - [**AsyncSearchAPIDomain.by\_image**](search_api.md#yandex_ai_studio_sdk._search_api.domain.AsyncSearchAPIDomain.by_image)
  - [Generative search](search_api.md#generative-search)
    - [**AsyncGenerativeSearchFunction**](search_api.md#yandex_ai_studio_sdk._search_api.generative.function.AsyncGenerativeSearchFunction)
      - [**AsyncGenerativeSearchFunction.\_\_call\_\_()**](search_api.md#yandex_ai_studio_sdk._search_api.generative.function.AsyncGenerativeSearchFunction.__call__i)
      - [**AsyncGenerativeSearchFunction.available\_formats**](search_api.md#yandex_ai_studio_sdk._search_api.generative.function.AsyncGenerativeSearchFunction.available_formats)
    - [**AsyncGenerativeSearch**](search_api.md#yandex_ai_studio_sdk._search_api.generative.generative.AsyncGenerativeSearch)
      - [**AsyncGenerativeSearch.run()**](search_api.md#yandex_ai_studio_sdk._search_api.generative.generative.AsyncGenerativeSearch.run)
      - [**AsyncGenerativeSearch.as\_tool()**](search_api.md#yandex_ai_studio_sdk._search_api.generative.generative.AsyncGenerativeSearch.as_tool)
      - [**AsyncGenerativeSearch.config**](search_api.md#yandex_ai_studio_sdk._search_api.generative.generative.AsyncGenerativeSearch.config)
      - [**AsyncGenerativeSearch.configure()**](search_api.md#yandex_ai_studio_sdk._search_api.generative.generative.AsyncGenerativeSearch.configure)
      - [**AsyncGenerativeSearch.fine\_tuned**](search_api.md#yandex_ai_studio_sdk._search_api.generative.generative.AsyncGenerativeSearch.fine_tuned)
      - [**AsyncGenerativeSearch.name**](search_api.md#yandex_ai_studio_sdk._search_api.generative.generative.AsyncGenerativeSearch.name)
      - [**AsyncGenerativeSearch.owner**](search_api.md#yandex_ai_studio_sdk._search_api.generative.generative.AsyncGenerativeSearch.owner)
      - [**AsyncGenerativeSearch.uri**](search_api.md#yandex_ai_studio_sdk._search_api.generative.generative.AsyncGenerativeSearch.uri)
      - [**AsyncGenerativeSearch.version**](search_api.md#yandex_ai_studio_sdk._search_api.generative.generative.AsyncGenerativeSearch.version)
  - [Web search](search_api.md#id2)
    - [**AsyncWebSearchFunction**](search_api.md#yandex_ai_studio_sdk._search_api.web.function.AsyncWebSearchFunction)
      - [**AsyncWebSearchFunction.\_\_call\_\_()**](search_api.md#yandex_ai_studio_sdk._search_api.web.function.AsyncWebSearchFunction.__call__i)
    - [**AsyncWebSearch**](search_api.md#yandex_ai_studio_sdk._search_api.web.web.AsyncWebSearch)
      - [**AsyncWebSearch.run()**](search_api.md#yandex_ai_studio_sdk._search_api.web.web.AsyncWebSearch.run)
      - [**AsyncWebSearch.run\_deferred()**](search_api.md#yandex_ai_studio_sdk._search_api.web.web.AsyncWebSearch.run_deferred)
      - [**AsyncWebSearch.config**](search_api.md#yandex_ai_studio_sdk._search_api.web.web.AsyncWebSearch.config)
      - [**AsyncWebSearch.configure()**](search_api.md#yandex_ai_studio_sdk._search_api.web.web.AsyncWebSearch.configure)
      - [**AsyncWebSearch.fine\_tuned**](search_api.md#yandex_ai_studio_sdk._search_api.web.web.AsyncWebSearch.fine_tuned)
      - [**AsyncWebSearch.name**](search_api.md#yandex_ai_studio_sdk._search_api.web.web.AsyncWebSearch.name)
      - [**AsyncWebSearch.owner**](search_api.md#yandex_ai_studio_sdk._search_api.web.web.AsyncWebSearch.owner)
      - [**AsyncWebSearch.uri**](search_api.md#yandex_ai_studio_sdk._search_api.web.web.AsyncWebSearch.uri)
      - [**AsyncWebSearch.version**](search_api.md#yandex_ai_studio_sdk._search_api.web.web.AsyncWebSearch.version)
    - [**AsyncWebSearchResult**](search_api.md#yandex_ai_studio_sdk._search_api.web.result.AsyncWebSearchResult)
      - [**AsyncWebSearchResult.next\_page()**](search_api.md#yandex_ai_studio_sdk._search_api.web.result.AsyncWebSearchResult.next_page)
      - [**AsyncWebSearchResult.next\_page\_deferred()**](search_api.md#yandex_ai_studio_sdk._search_api.web.result.AsyncWebSearchResult.next_page_deferred)
      - [**AsyncWebSearchResult.count()**](search_api.md#yandex_ai_studio_sdk._search_api.web.result.AsyncWebSearchResult.count)
      - [**AsyncWebSearchResult.docs**](search_api.md#yandex_ai_studio_sdk._search_api.web.result.AsyncWebSearchResult.docs)
      - [**AsyncWebSearchResult.index()**](search_api.md#yandex_ai_studio_sdk._search_api.web.result.AsyncWebSearchResult.index)
      - [**AsyncWebSearchResult.xml**](search_api.md#yandex_ai_studio_sdk._search_api.web.result.AsyncWebSearchResult.xml)
      - [**AsyncWebSearchResult.groups**](search_api.md#yandex_ai_studio_sdk._search_api.web.result.AsyncWebSearchResult.groups)
      - [**AsyncWebSearchResult.page**](search_api.md#yandex_ai_studio_sdk._search_api.web.result.AsyncWebSearchResult.page)
  - [Image search](search_api.md#image-search)
    - [**AsyncImageSearchFunction**](search_api.md#yandex_ai_studio_sdk._search_api.image.function.AsyncImageSearchFunction)
      - [**AsyncImageSearchFunction.\_\_call\_\_()**](search_api.md#yandex_ai_studio_sdk._search_api.image.function.AsyncImageSearchFunction.__call__i)
    - [**AsyncImageSearch**](search_api.md#yandex_ai_studio_sdk._search_api.image.image.AsyncImageSearch)
      - [**AsyncImageSearch.run()**](search_api.md#yandex_ai_studio_sdk._search_api.image.image.AsyncImageSearch.run)
      - [**AsyncImageSearch.config**](search_api.md#yandex_ai_studio_sdk._search_api.image.image.AsyncImageSearch.config)
      - [**AsyncImageSearch.configure()**](search_api.md#yandex_ai_studio_sdk._search_api.image.image.AsyncImageSearch.configure)
      - [**AsyncImageSearch.fine\_tuned**](search_api.md#yandex_ai_studio_sdk._search_api.image.image.AsyncImageSearch.fine_tuned)
      - [**AsyncImageSearch.name**](search_api.md#yandex_ai_studio_sdk._search_api.image.image.AsyncImageSearch.name)
      - [**AsyncImageSearch.owner**](search_api.md#yandex_ai_studio_sdk._search_api.image.image.AsyncImageSearch.owner)
      - [**AsyncImageSearch.uri**](search_api.md#yandex_ai_studio_sdk._search_api.image.image.AsyncImageSearch.uri)
      - [**AsyncImageSearch.version**](search_api.md#yandex_ai_studio_sdk._search_api.image.image.AsyncImageSearch.version)
    - [**AsyncImageSearchResult**](search_api.md#yandex_ai_studio_sdk._search_api.image.result.AsyncImageSearchResult)
      - [**AsyncImageSearchResult.next\_page()**](search_api.md#yandex_ai_studio_sdk._search_api.image.result.AsyncImageSearchResult.next_page)
      - [**AsyncImageSearchResult.count()**](search_api.md#yandex_ai_studio_sdk._search_api.image.result.AsyncImageSearchResult.count)
      - [**AsyncImageSearchResult.docs**](search_api.md#yandex_ai_studio_sdk._search_api.image.result.AsyncImageSearchResult.docs)
      - [**AsyncImageSearchResult.index()**](search_api.md#yandex_ai_studio_sdk._search_api.image.result.AsyncImageSearchResult.index)
      - [**AsyncImageSearchResult.xml**](search_api.md#yandex_ai_studio_sdk._search_api.image.result.AsyncImageSearchResult.xml)
      - [**AsyncImageSearchResult.groups**](search_api.md#yandex_ai_studio_sdk._search_api.image.result.AsyncImageSearchResult.groups)
      - [**AsyncImageSearchResult.page**](search_api.md#yandex_ai_studio_sdk._search_api.image.result.AsyncImageSearchResult.page)
  - [Search by image](search_api.md#id5)
    - [**AsyncByImageSearchFunction**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.function.AsyncByImageSearchFunction)
      - [**AsyncByImageSearchFunction.\_\_call\_\_()**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.function.AsyncByImageSearchFunction.__call__i)
    - [**AsyncByImageSearch**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch)
      - [**AsyncByImageSearch.run()**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch.run)
      - [**AsyncByImageSearch.run\_from\_url()**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch.run_from_url)
      - [**AsyncByImageSearch.run\_from\_id()**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch.run_from_id)
      - [**AsyncByImageSearch.config**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch.config)
      - [**AsyncByImageSearch.configure()**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch.configure)
      - [**AsyncByImageSearch.fine\_tuned**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch.fine_tuned)
      - [**AsyncByImageSearch.name**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch.name)
      - [**AsyncByImageSearch.owner**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch.owner)
      - [**AsyncByImageSearch.uri**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch.uri)
      - [**AsyncByImageSearch.version**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.by_image.AsyncByImageSearch.version)
    - [**AsyncByImageSearchResult**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.result.AsyncByImageSearchResult)
      - [**AsyncByImageSearchResult.next\_page()**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.result.AsyncByImageSearchResult.next_page)
      - [**AsyncByImageSearchResult.count()**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.result.AsyncByImageSearchResult.count)
      - [**AsyncByImageSearchResult.docs**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.result.AsyncByImageSearchResult.docs)
      - [**AsyncByImageSearchResult.index()**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.result.AsyncByImageSearchResult.index)
      - [**AsyncByImageSearchResult.images**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.result.AsyncByImageSearchResult.images)
      - [**AsyncByImageSearchResult.cbir\_id**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.result.AsyncByImageSearchResult.cbir_id)
      - [**AsyncByImageSearchResult.page**](search_api.md#yandex_ai_studio_sdk._search_api.by_image.result.AsyncByImageSearchResult.page)
- [Datasets domain](datasets.md)
  - [**AsyncDatasets**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets)
    - [**AsyncDatasets.get()**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.get)
    - [**AsyncDatasets.list()**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.list)
    - [**AsyncDatasets.list\_upload\_formats()**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.list_upload_formats)
    - [**AsyncDatasets.list\_upload\_schemas()**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.list_upload_schemas)
    - [**AsyncDatasets.completions**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.completions)
    - [**AsyncDatasets.draft\_from\_path()**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.draft_from_path)
    - [**AsyncDatasets.text\_classifiers\_binary**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.text_classifiers_binary)
    - [**AsyncDatasets.text\_classifiers\_multiclass**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.text_classifiers_multiclass)
    - [**AsyncDatasets.text\_classifiers\_multilabel**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.text_classifiers_multilabel)
    - [**AsyncDatasets.text\_embeddings\_pair**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.text_embeddings_pair)
    - [**AsyncDatasets.text\_embeddings\_triplet**](datasets.md#yandex_ai_studio_sdk._datasets.domain.AsyncDatasets.text_embeddings_triplet)
  - [**AsyncDataset**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset)
    - [**AsyncDataset.update()**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.update)
    - [**AsyncDataset.delete()**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.delete)
    - [**AsyncDataset.list\_upload\_formats()**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.list_upload_formats)
    - [**AsyncDataset.download()**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.download)
    - [**AsyncDataset.read()**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.read)
    - [**AsyncDataset.folder\_id**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.folder_id)
    - [**AsyncDataset.name**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.name)
    - [**AsyncDataset.description**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.description)
    - [**AsyncDataset.metadata**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.metadata)
    - [**AsyncDataset.created\_by**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.created_by)
    - [**AsyncDataset.created\_at**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.created_at)
    - [**AsyncDataset.updated\_at**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.updated_at)
    - [**AsyncDataset.labels**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.labels)
    - [**AsyncDataset.allow\_data\_logging**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.allow_data_logging)
    - [**AsyncDataset.status**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.status)
    - [**AsyncDataset.task\_type**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.task_type)
    - [**AsyncDataset.rows**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.rows)
    - [**AsyncDataset.size\_bytes**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.size_bytes)
    - [**AsyncDataset.validation\_errors**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.validation_errors)
    - [**AsyncDataset.id**](datasets.md#yandex_ai_studio_sdk._datasets.dataset.AsyncDataset.id)
  - [**AsyncDatasetDraft**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft)
    - [**AsyncDatasetDraft.upload\_deferred()**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.upload_deferred)
    - [**AsyncDatasetDraft.upload()**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.upload)
    - [**AsyncDatasetDraft.allow\_data\_logging**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.allow_data_logging)
    - [**AsyncDatasetDraft.configure()**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.configure)
    - [**AsyncDatasetDraft.description**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.description)
    - [**AsyncDatasetDraft.labels**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.labels)
    - [**AsyncDatasetDraft.metadata**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.metadata)
    - [**AsyncDatasetDraft.name**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.name)
    - [**AsyncDatasetDraft.path**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.path)
    - [**AsyncDatasetDraft.task\_type**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.task_type)
    - [**AsyncDatasetDraft.upload\_format**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.upload_format)
    - [**AsyncDatasetDraft.validate()**](datasets.md#yandex_ai_studio_sdk._datasets.draft.AsyncDatasetDraft.validate)
- [Tuning domain](tuning.md)
  - [**AsyncTuning**](tuning.md#yandex_ai_studio_sdk._tuning.domain.AsyncTuning)
    - [**AsyncTuning.get()**](tuning.md#yandex_ai_studio_sdk._tuning.domain.AsyncTuning.get)
    - [**AsyncTuning.list()**](tuning.md#yandex_ai_studio_sdk._tuning.domain.AsyncTuning.list)
- [Batch domain](batch.md)
  - [**AsyncBatch**](batch.md#yandex_ai_studio_sdk._batch.domain.AsyncBatch)
    - [**AsyncBatch.get()**](batch.md#yandex_ai_studio_sdk._batch.domain.AsyncBatch.get)
    - [**AsyncBatch.list\_operations()**](batch.md#yandex_ai_studio_sdk._batch.domain.AsyncBatch.list_operations)
    - [**AsyncBatch.list\_info()**](batch.md#yandex_ai_studio_sdk._batch.domain.AsyncBatch.list_info)
  - [**AsyncBatchTaskOperation**](batch.md#yandex_ai_studio_sdk._types.batch.operation.AsyncBatchTaskOperation)
    - [**AsyncBatchTaskOperation.delete()**](batch.md#yandex_ai_studio_sdk._types.batch.operation.AsyncBatchTaskOperation.delete)
    - [**AsyncBatchTaskOperation.get\_task\_info()**](batch.md#yandex_ai_studio_sdk._types.batch.operation.AsyncBatchTaskOperation.get_task_info)
    - [**AsyncBatchTaskOperation.cancel()**](batch.md#yandex_ai_studio_sdk._types.batch.operation.AsyncBatchTaskOperation.cancel)
    - [**AsyncBatchTaskOperation.get\_result()**](batch.md#yandex_ai_studio_sdk._types.batch.operation.AsyncBatchTaskOperation.get_result)
    - [**AsyncBatchTaskOperation.get\_status()**](batch.md#yandex_ai_studio_sdk._types.batch.operation.AsyncBatchTaskOperation.get_status)
    - [**AsyncBatchTaskOperation.id**](batch.md#yandex_ai_studio_sdk._types.batch.operation.AsyncBatchTaskOperation.id)
    - [**AsyncBatchTaskOperation.task\_id**](batch.md#yandex_ai_studio_sdk._types.batch.operation.AsyncBatchTaskOperation.task_id)
    - [**AsyncBatchTaskOperation.wait()**](batch.md#yandex_ai_studio_sdk._types.batch.operation.AsyncBatchTaskOperation.wait)
- [Chat domain](chat/domain.md)
  - [**AsyncChat**](chat/domain.md#yandex_ai_studio_sdk._chat.AsyncChat)
    - [**AsyncChat.completions**](chat/domain.md#yandex_ai_studio_sdk._chat.AsyncChat.completions)
    - [**AsyncChat.text\_embeddings**](chat/domain.md#yandex_ai_studio_sdk._chat.AsyncChat.text_embeddings)
- [SpheechKit domain](speechkit/domain.md)
  - [**AsyncSpeechKitDomain**](speechkit/domain.md#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain)
    - [**AsyncSpeechKitDomain.text\_to\_speech**](speechkit/domain.md#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.text_to_speech)
    - [**AsyncSpeechKitDomain.tts**](speechkit/domain.md#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.tts)