---
sourcePath: en/_sdk-ref/sdk-ref/async/search_api.md
---
# Search API domain

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.domain.**AsyncSearchAPIDomain**{#yandex_cloud_ml_sdk._search_api.domain.AsyncSearchAPIDomain}

Domain for working with [Yandex Search API](https://yandex.cloud/docs/search-api) services.

**generative**\: *[AsyncGenerativeSearchFunction](#yandex_cloud_ml_sdk._search_api.generative.function.AsyncGenerativeSearchFunction)*{#yandex_cloud_ml_sdk._search_api.domain.AsyncSearchAPIDomain.generative}

API for [generative response](https://yandex.cloud/docs/search-api/concepts/generative-response) service

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.function.**AsyncGenerativeSearchFunction**{#yandex_cloud_ml_sdk._search_api.generative.function.AsyncGenerativeSearchFunction}

Generative search function for creating search object which provides methods for invoking generative search.

**\_\_call\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *site=Undefined*, *host=Undefined*, *url=Undefined*, *fix\_misspell=Undefined*, *enable\_nrfm\_docs=Undefined*, *search\_filters=Undefined*){#yandex_cloud_ml_sdk._search_api.generative.function.AsyncGenerativeSearchFunction.__call__i}

Creates generative search object which provides methods for invoking generative search.

To learn more about parameters and their formats and possible values, refer to [generative search documentation](https://yandex.cloud/docs/search-api/concepts/generative-response#body)

NB: All of the **site**, **host**, **url** parameters are mutually exclusive and using one of them is mandatory.

#|
|| Parameters | 

- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of sites.
- **host** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of hosts.
- **url** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of URLs.
- **fix\_misspell** ([*bool*](https://docs.python.org/3/library/functions.html#bool)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – tells to backend to fix or not to fix misspels in queries.
- **enable\_nrfm\_docs** ([*bool*](https://docs.python.org/3/library/functions.html#bool)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – tells to backend to include or not to include pages, which are not available via direct clicks from given sites/hosts/urls to search result.
- **search\_filters** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType)* \| *[*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType)* \| *[*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)*] **\| *[*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType)* \| *[*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType)* \| *[*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – allows to limit search results with additional filters.
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

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.generative.**AsyncGenerativeSearch**{#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch}

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

- **request** ([*TextMessage*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage)* \| *[*TextMessageDict*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict)* \| *[*TextMessageProtocol*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol)* \| *[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage)* \| *[*TextMessageDict*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict)* \| *[*TextMessageProtocol*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol)* \| *[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – search request, which could be either standalone request (message) or a list of messages, which represents a context of conversation with a model.

Also message could be one of the data formats:
- **"string"** – in case of string input message will be passed to a model with a **role="user"**;
- **{"text": "text", "role": "user"}** – in case of dict input, it will be passed with corresponding **"text"** and **"role"** dict keys;
- **MessageObject** – you could also pass any object which have a **text: str** and **role: str** attributes, allowing to reuse various result object, for example object you getting from compltions model run or result object from generative search itself;
- **["string"/dict/object]** – list or any other sequence of any above described formats.

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Return type | [*GenerativeSearchResult*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult) ||
|#

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *site=Undefined*, *host=Undefined*, *url=Undefined*, *fix\_misspell=Undefined*, *enable\_nrfm\_docs=Undefined*, *search\_filters=Undefined*){#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.configure}

Returns the new object with config fields overrode by passed values.

To learn more about parameters and their formats and possible values, refer to [generative search documentation](https://yandex.cloud/docs/search-api/concepts/generative-response#body)

NB: All of the **site**, **host**, **url** parameters are mutually exclusive and using one of them is mandatory.

#|
|| Parameters | 

- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)* \| **None*) – parameter for limiting search to specific location or list of sites.
- **host** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)* \| **None*) – parameter for limiting search to specific location or list of hosts.
- **url** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)* \| **None*) – parameter for limiting search to specific location or list of URLs.
- **fix\_misspell** ([*bool*](https://docs.python.org/3/library/functions.html#bool)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)* \| **None*) – tells to backend to fix or not to fix misspels in queries.
- **enable\_nrfm\_docs** ([*bool*](https://docs.python.org/3/library/functions.html#bool)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)* \| **None*) – tells to backend to include or not to include pages, which are not available via direct clicks from given sites/hosts/urls to search result.
- **search\_filters** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType)* \| *[*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType)* \| *[*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)*] **\| *[*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType)* \| *[*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType)* \| *[*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)* \| **None*) – allows to limit search results with additional filters.
```python
>>> date_filter = {'date': '<20250101'}
>>> format_filter = {'format': 'doc'}
>>> lang_filter = {'lang': 'ru'}
>>> search = sdk.search_api.generative(search_filters=[date_filter, format_filter, lang_filter])
```
 ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.generative.AsyncGenerativeSearch.uri}