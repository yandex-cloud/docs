---
sourcePath: en/_sdk-ref/sdk-ref/async/search_api.md
---
# Search API domain

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.domain.**AsyncSearchAPIDomain**{#yandex_cloud_ml_sdk._search_api.domain.AsyncSearchAPIDomain}

Domain for working with [Yandex Search API](https://yandex.cloud/docs/search-api) services.

**generative**\: *[AsyncGenerativeSearchFunction](#yandex_cloud_ml_sdk._search_api.generative.function.AsyncGenerativeSearchFunction)*{#yandex_cloud_ml_sdk._search_api.domain.AsyncSearchAPIDomain.generative}

API for [generative response](https://yandex.cloud/docs/search-api/concepts/generative-response) service

**web**\: *[AsyncWebSearchFunction](#yandex_cloud_ml_sdk._search_api.web.function.AsyncWebSearchFunction)*{#yandex_cloud_ml_sdk._search_api.domain.AsyncSearchAPIDomain.web}

API for [web search](https://yandex.cloud/ru/docs/search-api/concepts/web-search) service

**image**\: *[AsyncImageSearchFunction](#yandex_cloud_ml_sdk._search_api.image.function.AsyncImageSearchFunction)*{#yandex_cloud_ml_sdk._search_api.domain.AsyncSearchAPIDomain.image}

API for [text image search](https://yandex.cloud/ru/docs/search-api/concepts/image-search#search-by-text-query) service

**by\_image**\: *[AsyncByImageSearchFunction](#yandex_cloud_ml_sdk._search_api.by_image.function.AsyncByImageSearchFunction)*{#yandex_cloud_ml_sdk._search_api.domain.AsyncSearchAPIDomain.by_image}

API for [search by image](https://yandex.cloud/ru/docs/search-api/concepts/image-search#search-by-image) service

## Generative search

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.function.**AsyncGenerativeSearchFunction**{#yandex_cloud_ml_sdk._search_api.generative.function.AsyncGenerativeSearchFunction}

Generative search function for creating search object which provides methods for invoking generative search.

**\_\_call\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *site=Undefined*, *host=Undefined*, *url=Undefined*, *fix\_misspell=Undefined*, *enable\_nrfm\_docs=Undefined*, *search\_filters=Undefined*){#yandex_cloud_ml_sdk._search_api.generative.function.AsyncGenerativeSearchFunction.__call__i}

Creates generative search object which provides methods for invoking generative search.

Not to be confused with **sdk.tools.generative\_search**. Tools domain is for creating tools for using in LLMs/Assistants and search\_api domain is for using Search API directly.

To learn more about parameters and their formats and possible values, refer to [generative search documentation](https://yandex.cloud/docs/search-api/concepts/generative-response#body)

NB: All of the **site**, **host**, **url** parameters are mutually exclusive.

#|
|| Parameters | 

- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of sites.
- **host** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of hosts.
- **url** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of URLs.
- **fix\_misspell** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – tells to backend to fix or not to fix misspels in queries.
- **enable\_nrfm\_docs** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – tells to backend to include or not to include pages, which are not available via direct clicks from given sites/hosts/urls to search result.
- **search\_filters** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)*] \|* [*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – allows to limit search results with additional filters.
```python
>>> date_filter = {'date': '<20250101'}
>>> format_filter = {'format': 'doc'}
>>> lang_filter = {'lang': 'ru'}
>>> search = sdk.search_api.generative(search_filters=[date_filter, format_filter, lang_filter])
```
 ||
|| Return type | [*GenerativeSearchTypeT*](../types/other.md#yandex_cloud_ml_sdk._search_api.generative.generative.GenerativeSearchTypeT) ||
|#

*property* **available\_formats**{#yandex_cloud_ml_sdk._search_api.generative.function.AsyncGenerativeSearchFunction.available_formats}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.generative.**AsyncGenerativeSearch**{#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch}

Generative search class which provides concrete methods for working with Search API and incapsulates search setting.

*async* **run**(*request*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.run}

Run a search query with given **request** and search settings of this generative search object.

To change initial search settings use **.configure** method:

```python
>>> search = sdk.search_api.generative(site="site")
>>> search = search.configure(site="other_site")
```

#|
|| Parameters | 

- **request** ([*TextMessage*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – search request, which could be either standalone request (message) or a list of messages, which represents a context of conversation with a model.

Also message could be one of the data formats:
- **"string"** – in case of string input message will be passed to a model with a **role="user"**;
- **{"text": "text", "role": "user"}** – in case of dict input, it will be passed with corresponding **"text"** and **"role"** dict keys;
- **MessageObject** – you could also pass any object which have a **text: str** and **role: str** attributes, allowing to reuse various result object, for example object you getting from compltions model run or result object from generative search itself;
- **["string"/dict/object]** – list or any other sequence of any above described formats.

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Return type | [*GenerativeSearchResult*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult) ||
|#

**as\_tool**(*description*){#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.as_tool}

Converts generative search instance to [**GenerativeSearchTool**](../types/tools.md#yandex_cloud_ml_sdk._tools.generative_search.GenerativeSearchTool) object which is eligible to use as tools in LLMs/Assistants.

#|
|| Parameters | **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – description of tool instance which also instructs model when to call it. ||
|| Return type | [*GenerativeSearchTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.generative_search.GenerativeSearchTool) ||
|#

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model_config.ConfigTypeT)*{#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *site=Undefined*, *host=Undefined*, *url=Undefined*, *fix\_misspell=Undefined*, *enable\_nrfm\_docs=Undefined*, *search\_filters=Undefined*){#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.configure}

Returns the new object with config fields overrode by passed values.

To learn more about parameters and their formats and possible values, refer to [generative search documentation](https://yandex.cloud/docs/search-api/concepts/generative-response#body)

NB: All of the **site**, **host**, **url** parameters are mutually exclusive and using one of them is mandatory.

#|
|| Parameters | 

- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – parameter for limiting search to specific location or list of sites.
- **host** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – parameter for limiting search to specific location or list of hosts.
- **url** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – parameter for limiting search to specific location or list of URLs.
- **fix\_misspell** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – tells to backend to fix or not to fix misspels in queries.
- **enable\_nrfm\_docs** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – tells to backend to include or not to include pages, which are not available via direct clicks from given sites/hosts/urls to search result.
- **search\_filters** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)*] \|* [*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – allows to limit search results with additional filters.
```python
>>> date_filter = {'date': '<20250101'}
>>> format_filter = {'format': 'doc'}
>>> lang_filter = {'lang': 'ru'}
>>> search = sdk.search_api.generative(search_filters=[date_filter, format_filter, lang_filter])
```
 ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.name}

*property* **owner**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.owner}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.uri}

*property* **version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.version}

## Web search

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.web.function.**AsyncWebSearchFunction**{#yandex_cloud_ml_sdk._search_api.web.function.AsyncWebSearchFunction}

Web search function for creating search object which provides methods for invoking web search.

**\_\_call\_\_**(*search\_type*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *family\_mode=Undefined*, *fix\_typo\_mode=Undefined*, *localization=Undefined*, *sort\_order=Undefined*, *sort\_mode=Undefined*, *group\_mode=Undefined*, *groups\_on\_page=Undefined*, *docs\_in\_group=Undefined*, *max\_passages=Undefined*, *region=Undefined*, *user\_agent=Undefined*, *metadata=Undefined*){#yandex_cloud_ml_sdk._search_api.web.function.AsyncWebSearchFunction.__call__i}

Creates web search object which provides methods for web search.

To learn more about parameters and their formats and possible values, refer to [web search documentation](https://yandex.cloud/ru/docs/search-api/concepts/web-search#parameters)

#|
|| Parameters | 

- **search\_type** ([*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)) – Search type.
- **family\_mode** ([*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Results filtering.
- **fix\_typo\_mode** ([*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search query typo correction setting
- **localization** ([*Localization*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.Localization) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*Localization*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.Localization)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search response notifications language. Affects the text in the **found-docs-human** tag and error messages
- **sort\_order** ([*SortOrder*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortOrder) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SortOrder*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortOrder)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search results sorting order
- **sort\_mode** ([*SortMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SortMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search results sorting mode rule
- **group\_mode** ([*GroupMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.GroupMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*GroupMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.GroupMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Result grouping method.
- **groups\_on\_page** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Maximum number of groups that can be returned per page.
- **docs\_in\_group** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Maximum number of documents that can be returned per group.
- **max\_passages** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Maximum number of passages that can be used when generating a document.
- **region** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search country or region ID that affects the document ranking rules.
- **user\_agent** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – String containing the User-Agent header. Use this parameter to have your search results optimized for a specific device and browser, including mobile search results.
- **metadata** ([*Mapping*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Mapping)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) ||
|| Return type | [*WebSearchTypeT*](../types/other.md#yandex_cloud_ml_sdk._search_api.web.web.WebSearchTypeT) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.web.web.**AsyncWebSearch**{#yandex_cloud_ml_sdk._search_api.web.web.AsyncWebSearch}

Web search class which provides concrete methods for working with Web Search API and incapsulates search setting.

*async* **run**(*query\: [str](https://docs.python.org/3/library/stdtypes.html#str)*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *format\: [Literal](https://docs.python.org/3/library/typing.html#typing.Literal)['parsed'] = 'parsed'*, *page\: [int](https://docs.python.org/3/library/functions.html#int) = 0*, *timeout\: [float](https://docs.python.org/3/library/functions.html#float) = 60*) → [AsyncWebSearchResult](#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult){#yandex_cloud_ml_sdk._search_api.web.web.AsyncWebSearch.run}

*async* **run**(*query\: [str](https://docs.python.org/3/library/stdtypes.html#str)*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *format\: [Literal](https://docs.python.org/3/library/typing.html#typing.Literal)['xml', 'html']*, *page\: [int](https://docs.python.org/3/library/functions.html#int) = 0*, *timeout\: [float](https://docs.python.org/3/library/functions.html#float) = 60*) → [bytes](https://docs.python.org/3/library/stdtypes.html#bytes)

Run a search query with given **query** and search settings of this web search object.

To change initial search settings use **.configure** method:

```python
>>> search = sdk.search_api.web(search_type='BE')
>>> search = search.configure(search_type='RU')
```

#|
|| Parameters | 

- **query** – Search query text.
- **format** – With default **parsed** value call returns a parsed Yandex Cloud ML SDK object; with other values method returns a raw bytes string.
- **page** – Requested page number.
- **timeout** – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Returns | Parsed search results object or bytes string depending on **format** parameter. ||
|#

*async* **run\_deferred**(*query\: [str](https://docs.python.org/3/library/stdtypes.html#str)*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *format\: [Literal](https://docs.python.org/3/library/typing.html#typing.Literal)['parsed'] = 'parsed'*, *page\: [int](https://docs.python.org/3/library/functions.html#int) = 0*, *timeout\: [float](https://docs.python.org/3/library/functions.html#float) = 60*) → [AsyncOperation](../types/operation.md#yandex_cloud_ml_sdk._types.operation.AsyncOperation)[[AsyncWebSearchResult](#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult)]{#yandex_cloud_ml_sdk._search_api.web.web.AsyncWebSearch.run_deferred}

*async* **run\_deferred**(*query\: [str](https://docs.python.org/3/library/stdtypes.html#str)*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *format\: [Literal](https://docs.python.org/3/library/typing.html#typing.Literal)['xml', 'html']*, *page\: [int](https://docs.python.org/3/library/functions.html#int) = 0*, *timeout\: [float](https://docs.python.org/3/library/functions.html#float) = 60*) → [AsyncOperation](../types/operation.md#yandex_cloud_ml_sdk._types.operation.AsyncOperation)[[bytes](https://docs.python.org/3/library/stdtypes.html#bytes)]

Run a deferred search query with given **query** and search settings of this web search object.

To change initial search settings use **.configure** method:

```python
>>> search = sdk.search_api.web(search_type='BE')
>>> search = search.configure(search_type='RU')
```

#|
|| Parameters | 

- **query** – Search query text.
- **format** – With default **parsed** value call returns an operation with parsed Yandex Cloud ML SDK return; with other values method returns an operation with raw bytes string return.
- **page** – Requested page number.
- **timeout** – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Returns | Operation with parsed search results object or bytes string return depending on **format** parameter. ||
|#

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model_config.ConfigTypeT)*{#yandex_cloud_ml_sdk._search_api.web.web.AsyncWebSearch.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *search\_type=Undefined*, *family\_mode=Undefined*, *fix\_typo\_mode=Undefined*, *localization=Undefined*, *sort\_order=Undefined*, *sort\_mode=Undefined*, *group\_mode=Undefined*, *groups\_on\_page=Undefined*, *docs\_in\_group=Undefined*, *max\_passages=Undefined*, *region=Undefined*, *user\_agent=Undefined*, *metadata=Undefined*){#yandex_cloud_ml_sdk._search_api.web.web.AsyncWebSearch.configure}

Returns the new object with config fields overrode by passed values.

To learn more about parameters and their formats and possible values, refer to [web search documentation](https://yandex.cloud/ru/docs/search-api/concepts/web-search#parameters)

#|
|| Parameters | 

- **search\_type** ([*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Search type.
- **family\_mode** ([*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Results filtering.
- **fix\_typo\_mode** ([*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Search query typo correction setting
- **localization** ([*Localization*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.Localization) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*Localization*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.Localization)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Search response notifications language. Affects the text in the **found-docs-human** tag and error messages
- **sort\_mode** ([*SortMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SortMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Search results sorting mode rule
- **sort\_order** ([*SortOrder*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortOrder) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SortOrder*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortOrder)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Search results sorting order
- **group\_mode** ([*GroupMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.GroupMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*GroupMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.GroupMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Result grouping method.
- **groups\_on\_page** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Maximum number of groups that can be returned per page.
- **docs\_in\_group** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Maximum number of documents that can be returned per group.
- **max\_passages** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Maximum number of passages that can be used when generating a document.
- **region** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Search country or region ID that affects the document ranking rules.
- **user\_agent** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – String containing the User-Agent header. Use this parameter to have your search results optimized for a specific device and browser, including mobile search results.
- **metadata** ([*Mapping*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Mapping)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.web.web.AsyncWebSearch.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.web.web.AsyncWebSearch.name}

*property* **owner**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.web.web.AsyncWebSearch.owner}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.web.web.AsyncWebSearch.uri}

*property* **version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.web.web.AsyncWebSearch.version}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.web.result.**AsyncWebSearchResult**{#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult}

A class representing the partially parsed result of a Web search request with XML format.

*async* **next\_page**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=None*){#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult.next_page}

Run a web search request with previous search parameters except page number being increment by one.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) – Timeout, or the maximum time to wait for the request to complete in seconds; if not given, initial timeout value from original search request are being used. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*async* **next\_page\_deferred**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=None*){#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult.next_page_deferred}

Launch a deferred web search request with previous search parameters except page number being increment by one.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) – Timeout, or the maximum time to wait for the request to complete in seconds; if not given, initial timeout value from original search request are being used. ||
|| Return type | [*AsyncOperation*](../types/operation.md#yandex_cloud_ml_sdk._types.operation.AsyncOperation)[[*AsyncWebSearchResult*](#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult)] ||
|#

**count**(*value*) → integer -- return number of occurrences of value{#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult.count}

*property* **docs**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[XMLSearchDocumentTypeT](../types/other.md#yandex_cloud_ml_sdk._search_api.types.XMLSearchDocumentTypeT)*]... ,{#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult.docs}

Returns all documents within search response.

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

**xml**\: *[bytes](https://docs.python.org/3/library/stdtypes.html#bytes)*{#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult.xml}

Non-parsed XML result of search request.

**groups**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SearchGroup](../types/search_api.md#yandex_cloud_ml_sdk._search_api.types.SearchGroup)[[XMLSearchDocumentTypeT](../types/other.md#yandex_cloud_ml_sdk._search_api.types.XMLSearchDocumentTypeT)*]... ,]{#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult.groups}

Parsed values of <group> tags within the response.

**page**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._search_api.web.result.AsyncWebSearchResult.page}

Returned search page number.

## Image search

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.image.function.**AsyncImageSearchFunction**{#yandex_cloud_ml_sdk._search_api.image.function.AsyncImageSearchFunction}

Image search function for creating search object which provides methods for invoking image search.

**\_\_call\_\_**(*search\_type*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *family\_mode=Undefined*, *fix\_typo\_mode=Undefined*, *format=Undefined*, *size=Undefined*, *orientation=Undefined*, *color=Undefined*, *site=Undefined*, *docs\_on\_page=Undefined*, *user\_agent=Undefined*){#yandex_cloud_ml_sdk._search_api.image.function.AsyncImageSearchFunction.__call__i}

Creates image search object which provides methods for image search.

To learn more about parameters and their formats and possible values, refer to [image search documentation](https://yandex.cloud/ru/docs/search-api/concepts/image-search#parameters)

#|
|| Parameters | 

- **search\_type** ([*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)) – Search type.
- **family\_mode** ([*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Results filtering.
- **fix\_typo\_mode** ([*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search query typo correction setting.
- **format** ([*ImageFormat*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageFormat) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageFormat*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageFormat)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Searching for images in a particular format.
- **size** ([*ImageSize*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageSize) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageSize*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageSize)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Searching for images of a particular size.
- **orientation** ([*ImageOrientation*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageOrientation*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Searching for images with a particular orientation.
- **color** ([*ImageColor*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageColor) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageColor*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageColor)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Searching for images containing a particular color.
- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Number of results per search result page.
- **docs\_on\_page** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Number of results per search result page.
- **user\_agent** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – String containing the User-Agent header. Use this parameter to have your search results optimized for a specific device and browser, including mobile search results. ||
|| Return type | [*ImageSearchTypeT*](../types/other.md#yandex_cloud_ml_sdk._search_api.image.image.ImageSearchTypeT) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.image.image.**AsyncImageSearch**{#yandex_cloud_ml_sdk._search_api.image.image.AsyncImageSearch}

Image search class which provides concrete methods for working with Image Search API and incapsulates search setting.

*async* **run**(*query\: [str](https://docs.python.org/3/library/stdtypes.html#str)*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *format\: [Literal](https://docs.python.org/3/library/typing.html#typing.Literal)['parsed'] = 'parsed'*, *page\: [int](https://docs.python.org/3/library/functions.html#int) = 0*, *timeout\: [float](https://docs.python.org/3/library/functions.html#float) = 60*) → [AsyncImageSearchResult](#yandex_cloud_ml_sdk._search_api.image.result.AsyncImageSearchResult){#yandex_cloud_ml_sdk._search_api.image.image.AsyncImageSearch.run}

*async* **run**(*query\: [str](https://docs.python.org/3/library/stdtypes.html#str)*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *format\: [Literal](https://docs.python.org/3/library/typing.html#typing.Literal)['xml']*, *page\: [int](https://docs.python.org/3/library/functions.html#int) = 0*, *timeout\: [float](https://docs.python.org/3/library/functions.html#float) = 60*) → [bytes](https://docs.python.org/3/library/stdtypes.html#bytes)

Run a search query with given **query** and search settings of this image search object.

To change initial search settings use **.configure** method:

```python
>>> search = sdk.search_api.image(search_type='BE')
>>> search = search.configure(search_type='RU')
```

#|
|| Parameters | 

- **query** – Search query text.
- **format** – With default **parsed** value call returns a parsed Yandex Cloud ML SDK object; with other values method returns a raw bytes string.
- **page** – Requested page number.
- **timeout** – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Returns | Parsed search results object or bytes string depending on **format** parameter. ||
|#

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model_config.ConfigTypeT)*{#yandex_cloud_ml_sdk._search_api.image.image.AsyncImageSearch.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *search\_type=Undefined*, *family\_mode=Undefined*, *fix\_typo\_mode=Undefined*, *format=Undefined*, *size=Undefined*, *orientation=Undefined*, *color=Undefined*, *site=Undefined*, *docs\_on\_page=Undefined*, *user\_agent=Undefined*){#yandex_cloud_ml_sdk._search_api.image.image.AsyncImageSearch.configure}

Returns the new object with config fields overrode by passed values.

To learn more about parameters and their formats and possible values, refer to [image search documentation](https://yandex.cloud/ru/docs/search-api/concepts/image-search#parameters)

#|
|| Parameters | 

- **search\_type** ([*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search type.
- **family\_mode** ([*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Results filtering.
- **fix\_typo\_mode** ([*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Search query typo correction setting
- **format** ([*ImageFormat*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageFormat) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageFormat*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageFormat)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Searching for images in a particular format.
- **size** ([*ImageSize*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageSize) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageSize*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageSize)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Searching for images of a particular size.
- **orientation** ([*ImageOrientation*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageOrientation*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Searching for images with a particular orientation.
- **color** ([*ImageColor*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageColor) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageColor*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageColor)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Searching for images containing a particular color.
- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Number of results per search result page.
- **docs\_on\_page** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Number of results per search result page.
- **user\_agent** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – String containing the User-Agent header. Use this parameter to have your search results optimized for a specific device and browser, including mobile search results. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.image.image.AsyncImageSearch.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.image.image.AsyncImageSearch.name}

*property* **owner**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.image.image.AsyncImageSearch.owner}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.image.image.AsyncImageSearch.uri}

*property* **version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.image.image.AsyncImageSearch.version}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.image.result.**AsyncImageSearchResult**{#yandex_cloud_ml_sdk._search_api.image.result.AsyncImageSearchResult}

A class representing the partially parsed result of a Image search request with XML format.

*async* **next\_page**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=None*){#yandex_cloud_ml_sdk._search_api.image.result.AsyncImageSearchResult.next_page}

Run a image search request with previous search parameters except page number being increment by one.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) – Timeout, or the maximum time to wait for the request to complete in seconds; if not given, initial timeout value from original search request are being used. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**count**(*value*) → integer -- return number of occurrences of value{#yandex_cloud_ml_sdk._search_api.image.result.AsyncImageSearchResult.count}

*property* **docs**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[XMLSearchDocumentTypeT](../types/other.md#yandex_cloud_ml_sdk._search_api.types.XMLSearchDocumentTypeT)*]... ,{#yandex_cloud_ml_sdk._search_api.image.result.AsyncImageSearchResult.docs}

Returns all documents within search response.

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_cloud_ml_sdk._search_api.image.result.AsyncImageSearchResult.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

**xml**\: *[bytes](https://docs.python.org/3/library/stdtypes.html#bytes)*{#yandex_cloud_ml_sdk._search_api.image.result.AsyncImageSearchResult.xml}

Non-parsed XML result of search request.

**groups**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SearchGroup](../types/search_api.md#yandex_cloud_ml_sdk._search_api.types.SearchGroup)[[XMLSearchDocumentTypeT](../types/other.md#yandex_cloud_ml_sdk._search_api.types.XMLSearchDocumentTypeT)*]... ,]{#yandex_cloud_ml_sdk._search_api.image.result.AsyncImageSearchResult.groups}

Parsed values of <group> tags within the response.

**page**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._search_api.image.result.AsyncImageSearchResult.page}

Returned search page number.

## Search by image

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.by\_image.function.**AsyncByImageSearchFunction**{#yandex_cloud_ml_sdk._search_api.by_image.function.AsyncByImageSearchFunction}

ByImage search function for creating search object which provides methods for invoking by\_image search.

**\_\_call\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *family\_mode=Undefined*, *site=Undefined*){#yandex_cloud_ml_sdk._search_api.by_image.function.AsyncByImageSearchFunction.__call__i}

Creates by\_image search object which provides methods for search by image.

To learn more about parameters and their formats and possible values, refer to [search by image documentation](https://yandex.cloud/ru/docs/search-api/concepts/image-search#request-body-by-pic)

#|
|| Parameters | 

- **family\_mode** ([*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Results filtering.
- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Restricts the search to the specific website. ||
|| Return type | [*ByImageSearchTypeT*](../types/other.md#yandex_cloud_ml_sdk._search_api.by_image.by_image.ByImageSearchTypeT) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.by\_image.by\_image.**AsyncByImageSearch**{#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch}

ByImage search class which provides concrete methods for working with ByImage Search API and incapsulates search setting.

*async* **run**(*image\_data*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page=0*, *timeout=60*){#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch.run}

Run a search query with given **image\_data** bytes and search settings of this by\_image search object.

To change initial search settings use **.configure** method:

```python
>>> search = sdk.search_api.by_image(site="ya.ru")
>>> search = search.configure(site="yandex.ru")
```

#|
|| Parameters | 

- **image\_data** ([*bytes*](https://docs.python.org/3/library/stdtypes.html#bytes)) – The image data to use for the search.
- **page** ([*int*](https://docs.python.org/3/library/functions.html#int)) – Requested page number.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Returns | Parsed search results object. ||
|| Return type | [*AsyncByImageSearchResult*](#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult) ||
|#

*async* **run\_from\_url**(*url*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page=0*, *timeout=60*){#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch.run_from_url}

Run a search query with given image located at **url** and search settings of this by\_image search object.

To change initial search settings use **.configure** method:

```python
>>> search = sdk.search_api.by_image(site="ya.ru")
>>> search = search.configure(site="yandex.ru")
```

#|
|| Parameters | 

- **url** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The image url to use for the search.
- **page** ([*int*](https://docs.python.org/3/library/functions.html#int)) – Requested page number.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Returns | Parsed search results object. ||
|| Return type | [*AsyncByImageSearchResult*](#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult) ||
|#

*async* **run\_from\_id**(*cbir\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page=0*, *timeout=60*){#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch.run_from_id}

Run a search query with given CBIR ID of the image and search settings of this by\_image search object.

To change initial search settings use **.configure** method:

```python
>>> search = sdk.search_api.by_image(site="ya.ru")
>>> search = search.configure(site="yandex.ru")
```

#|
|| Parameters | 

- **id** – CBIR ID of the image to use for the search.
- **page** ([*int*](https://docs.python.org/3/library/functions.html#int)) – Requested page number.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds.
- **cbir\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Returns | Parsed search results object. ||
|| Return type | [*AsyncByImageSearchResult*](#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult) ||
|#

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model_config.ConfigTypeT)*{#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *family\_mode=Undefined*, *site=Undefined*){#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch.configure}

Returns the new object with config fields overrode by passed values.

To learn more about parameters and their formats and possible values, refer to [search by image documentation](https://yandex.cloud/ru/docs/search-api/concepts/image-search#request-body-by-pic)

#|
|| Parameters | 

- **family\_mode** ([*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Results filtering.
- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – Restricts the search to the specific website. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch.name}

*property* **owner**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch.owner}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch.uri}

*property* **version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.by_image.by_image.AsyncByImageSearch.version}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.by\_image.result.**AsyncByImageSearchResult**{#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult}

A class representing the result of a search by image request.

*async* **next\_page**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=None*){#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult.next_page}

Run a search by image request with previous search parameters except page number being increment by one.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) – Timeout, or the maximum time to wait for the request to complete in seconds; if not given, initial timeout value from original search request are being used. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**count**(*value*) → integer -- return number of occurrences of value{#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult.count}

*property* **docs**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[ByImageSearchDocument](../types/search_api.md#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument)*]... ,{#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult.docs}

Synonym for .images attribute

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

**images**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[ByImageSearchDocument](../types/search_api.md#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument)*]... ,{#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult.images}

**cbir\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult.cbir_id}

**page**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._search_api.by_image.result.AsyncByImageSearchResult.page}

Returned search page number.