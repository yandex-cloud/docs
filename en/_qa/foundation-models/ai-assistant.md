# AI assistant

## General questions about AI assistants {#general}

#### How do I write effective instructions for an AI assistant? {#assistant-instruction}

When creating an AI assistant, provide a detailed plain-language description of what your assistant should do in the `instruction` field. Here is an example:

```
You are a support specialist. Your task is to answer questions on the topic. 
If the context does not have the answer, make no assumptions.
Stick strictly to the context. 
Keep your responses short but informative.
```

#### Does the assistant wait for the model to complete its response before proceeding to the next event? {#does-assistant-wait-for-models-response}

Yes. A single assistant run triggers a single model call. The model receives your [prompt](../../foundation-models/concepts/index.md#prompt), invokes the required tools, waits for the results, and then generates a response.

#### Can I cancel a request and interrupt an ongoing model response? {#cancel-request}

No, you cannot cancel a submitted request. To limit the model's response length, use the `maxTokens` parameter.

#### Can I send multiple requests to the same thread from different assistants concurrently? {#send-multiple-requests-to-same-thread}

Yes, there are no restrictions on concurrent use.

#### How do I prevent the transfer of context from the previous request? {#avoid-context-transfer}

You can specify the number of thread messages to send to the model with each new request using the `thread_num_messages` parameter. This way you can control how much context to use for the response, including messages from both the user and the model.

You can also create a new thread for each request and delete the old one.

#### Can the assistant detect images in text files? {#detect-image-in-text-files}

We plan to add support for image input.

#### Does {{ ai-studio-name }} have native monitoring and quality assessment tools? {#monitoring-tool}

We are actively developing {{ ai-studio-name }} and plan to introduce monitoring and quality assessment tools.

#### Which languages does the AI assistant support? {#languages}

The main {{ gpt-pro }} languages are Russian and English. Soon, we will release new large open-source models that will work well with other languages.

#### What are the differences between the RC and Latest versions? {#difference-between-rc-and-latest}

We are continuously enhancing the response quality and features of our models. Once internal metrics show the new model version is ready, we publish the updates to the RC branch for testing and notify users in our [release notes](../../foundation-models/release-notes/index.md). 

Learn more about the model lifecycle [here](../../foundation-models/concepts/generation/models.md#model-lifecycle).


## Tokens and billing {#tokens-and-billing}

#### How do I spend tokens when using the AI assistant? {#tokens-spend}

Just like with generative models, you pay for both request and model response [tokens](../../foundation-models/concepts/generation/tokens.md). This also includes context from the knowledge base and chat history. You can use the `maxTokens` parameter to limit the number of tokens in the model's response.

#### How can I estimate the number of tokens in text files beforehand? {#pre-estimate-number-of-tokens}

To estimate the text size in tokens, use a tokenizer. For more information, see [{#T}](../../foundation-models/operations/generation/evaluate-request.md).

#### Do I get charged for the model's response to a request that triggered the ethics filter? {#is-triggered-response-charged}

No, you do not get charged for such responses.

#### Do I get charged for creating search indexes, uploading files through the Files API, or storing files and indexes? {#is-until-ttl-expires-charged}

{{ assistant-api }} is at the [Preview](../../overview/concepts/launch-stages.md) stage. Creating or storing files, threads, or indexes is free of charge.

## Working with indexes {#indexes}

#### How do I set up a knowledge base for my AI assistant? {#implement-knowledge-base}

To set up a knowledge base for your AI assistant:

* Create your documents as Markdown files.
* Keep as much information in plain text as possible.
* Remove any footnotes and comments to make the content concise and clear.
* If your documents contain tables, convert them to Markdown format.
* Make sure each text chunk is big enough to include the largest tables from your documents.

#### How can I build an assistant that can search documents, use them to generate responses, and provide source links? {#assistant-which-can-search-through-set-of-articles}

Upload your documents to the assistant's [search index](../../foundation-models/concepts/assistant/search-index.md). The assistant will then return answers that include both links to the source documents and exact text chunks the model used to generate the response.

For more information, see [{#T}](../../foundation-models/operations/assistant/create-with-searchindex.md).

#### How do I add, update, or delete documents from the index? {#add-update-delete-operations}

To add a new document to your index, use the `append` operation.

To update a document, you need to rebuild the entire index.


#### How do I upload files directly from an object storage without saving them to my computer? {#download-files-directly-from-s3}

You can create a script that pulls data directly from your storage and uploads it to your AI assistant using the `sdk.files.upload_bytes()` method.

#### What method should I use to upload files from RAM? {#method-to-use-when-download-files-from-ram}

The `sdk.files.upload_bytes()` method works best for this kind of upload.

#### What happens if I delete a file used in the index? {#auto-deletion}

After the [search index](../../foundation-models/concepts/assistant/search-index.md) is created, it does not rely on files anymore. If you delete a file, the assistant will keep working correctly, but its responses will not include the link to that file.

#### Can I set up my AI assistant to provide no links when the index has no relevant content? {#set-assistant-to-not-provide-links-if-no-relevant-info}

Currently, this setting is not supported.


#### Can I connect multiple indexes to the same assistant? {#connect-set-of-indexes}

Currently, you can only connect one [search index](../../foundation-models/concepts/assistant/search-index.md) to each assistant.

You can either update the assistant with a new index or create two assistants, each with its own index.

#### Can I select a specific file for my AI assistant to search for an answer? {#specify-search-for-answer}

If you want your AI assistant to answer based on a specific file, create a dedicated [search index](../../foundation-models/concepts/assistant/search-index.md) for that file and update the assistant to use it.

You can also [create](../../foundation-models/operations/assistant/create-with-searchindex.md) multiple assistants with different indexes.

## Working with functions and tools {#functions-and-tools}

#### Can the model work with a toolchain? {#can-model-work-with-tool-chain}

To use a toolchain, you need a wrapper, such as [LangGraph](https://www.langchain.com/langgraph). For an example of how to work with a toolchain using LangGraph, see [this repository](https://github.com/yandex-datasphere/advanced-assistant/blob/main/langgraph-agent.ipynb).

#### How can I improve the quality of function calls? {#improve-function-calls-quality}

To improve the quality of function calls:

* Add usage examples to the function descriptions. 
* Set clear conditions for function calls in the instructions for your AI assistant. 
* Expand parameter descriptions by specifying typical values. 

#### How do I manage function selection and calling conditions in the assistant? {#manage-function-selection}

Implement fallback logic to call a function when it is not explicitly selected but the input contains relevant keywords. Use an external intent analyzer to improve recognition quality.