---
sourcePath: en/_sdk-ref/sdk-ref/types/search_api.md
---
# Search API

## Generative serch

*typeddict* yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**DateFilterType**{#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType}

Date filter dict type for generative search.

Example:

```python
>>> filter_ = {'date': '>20240125'}
```

#|
|| Required Keys | 

- **date** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**FormatFilterType**{#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType}

Format filter dict type for generative search.

Example:

```python
>>> filter_ = {'format': 'xlsx'}
```

#|
|| Required Keys | 

- **format** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**LangFilterType**{#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType}

Language filter dict type for generative search.

Example:

```python
>>> filter_ = {'lang': 'ru'}
```

#|
|| Required Keys | 

- **lang** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**GenerativeSearchConfig**{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig}

GenerativeSearchConfig(site: ‘tuple[str, …] | None’ = None, host: ‘tuple[str, …] | None’ = None, url: ‘tuple[str, …] | None’ = None, fix\_misspell: ‘bool | None’ = None, enable\_nrfm\_docs: ‘bool | None’ = None, search\_filters: ‘tuple[FilterType, …] | None’ = None)

**site**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.site}

Parameter for limiting search to specific location or list of sites.

**host**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.host}

Parameter for limiting search to specific location or list of hosts.

**url**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.url}

Parameter for limiting search to specific location or list of urls.

**fix\_misspell**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.fix_misspell}

tells to backend to fix or not to fix misspels in queries.

**enable\_nrfm\_docs**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.enable_nrfm_docs}

tells to backend to include or not to include pages, which are not available via direct clicks from given sites/hosts/urls to search result.

**search\_filters**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[DateFilterType](#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) | [FormatFilterType](#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) | [LangFilterType](#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.search_filters}

allows to limit search results with additional filters.

**\_\_init\_\_**(*site=None*, *host=None*, *url=None*, *fix\_misspell=None*, *enable\_nrfm\_docs=None*, *search\_filters=None*){#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.__init__i}

#|
|| Parameters | 

- **site** ([*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, ...] \| None*)
- **host** ([*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, ...] \| None*)
- **url** ([*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, ...] \| None*)
- **fix\_misspell** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\| None*)
- **enable\_nrfm\_docs** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\| None*)
- **search\_filters** ([*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*DateFilterType*](#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)*, ...] \| None*) ||
|| Return type | None ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.result.**SearchSource**{#yandex_cloud_ml_sdk._search_api.generative.result.SearchSource}

Source document found for user query.

Might be used or not used in generative answer itself.

**url**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.SearchSource.url}

Url of the document

**title**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.SearchSource.title}

Title of the document

**used**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._search_api.generative.result.SearchSource.used}

Has this source been used in generative answer or not

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.result.**SearchQuery**{#yandex_cloud_ml_sdk._search_api.generative.result.SearchQuery}

SearchQuery(text: ‘str’, req\_id: ‘str’)

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.SearchQuery.text}

Text of the search query

**req\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.SearchQuery.req_id}

Request id

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.result.**GenerativeSearchResult**{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult}

A class representing the result of a generative search request.

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.text}

Generative answer itself. Note that footnootes like **[N]** in the text refers to **GenerativeSearchResult.sources[N]** source.

**role**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.role}

Message sender role; in case of the generative search, model always answers with the “assistant” role.

**fixed\_misspell\_query**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.fixed_misspell_query}

Fixed query string in case of query was fixed

**is\_answer\_rejected**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.is_answer_rejected}

Anwer was rejected by some reasons, probably because of the ethics constrictions

**is\_bullet\_answer**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.is_bullet_answer}

Model was unable to give good answer and returned bulleted list with some info.

**sources**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SearchSource](#yandex_cloud_ml_sdk._search_api.generative.result.SearchSource)*]... ,{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.sources}

List of documents found by user query; every element number matches with footnotes in the **.text** attribute.

**search\_queries**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SearchQuery](#yandex_cloud_ml_sdk._search_api.generative.result.SearchQuery)*]... ,{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.search_queries}

List of search queries sent to model

*property* **content**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.content}

Alias to **GenerativeSearchResult.text**.

Only to add some compatibility with raw Search API answer which have “content” field in protobufs and REST answers unlike other parts of this SDK.

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**FilterType**{#yandex_cloud_ml_sdk._search_api.generative.result.yandex_cloud_ml_sdk._search_api.generative.config.FilterType}

yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**FilterType**{#yandex_cloud_ml_sdk._search_api.generative.config.FilterType}

Generative search filter type which describes dict formats eligible to use with generative search API.

alias of [**DateFilterType**](#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) | [**FormatFilterType**](#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) | [**LangFilterType**](#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)

## General

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.types.**SearchGroup**{#yandex_cloud_ml_sdk._search_api.types.SearchGroup}

SearchGroup(documents: ‘tuple[XMLSearchDocumentTypeT, …]’)

**documents**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[XMLSearchDocumentTypeT](other.md#yandex_cloud_ml_sdk._search_api.types.XMLSearchDocumentTypeT)*]... ,{#yandex_cloud_ml_sdk._search_api.types.SearchGroup.documents}

**count**(*value*) → integer -- return number of occurrences of value{#yandex_cloud_ml_sdk._search_api.types.SearchGroup.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_cloud_ml_sdk._search_api.types.SearchGroup.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

## Web search

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.web.result.**WebSearchDocument**{#yandex_cloud_ml_sdk._search_api.web.result.WebSearchDocument}

WebSearchDocument(url: ‘str | None’, domain: ‘str | None’, modtime: ‘datetime.datetime | None’, title: ‘str | None’, lang: ‘str | None’, extra: ‘NestedDict’, passages: ‘tuple[str, …]’)

**url**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.web.result.WebSearchDocument.url}

**domain**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.web.result.WebSearchDocument.domain}

**title**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.web.result.WebSearchDocument.title}

**modtime**\: *[datetime](https://docs.python.org/3/library/datetime.html#datetime.datetime) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.web.result.WebSearchDocument.modtime}

**lang**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.web.result.WebSearchDocument.lang}

**extra**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str) | [NestedDict](other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._search_api.utils.NestedDict)*]{#yandex_cloud_ml_sdk._search_api.web.result.WebSearchDocument.extra}

**passages**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str)*]... ,{#yandex_cloud_ml_sdk._search_api.web.result.WebSearchDocument.passages}

## Image search

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.image.result.**ImageSearchDocument**{#yandex_cloud_ml_sdk._search_api.image.result.ImageSearchDocument}

ImageSearchDocument(url: ‘str | None’, domain: ‘str | None’, modtime: ‘datetime.datetime | None’, width: ‘int | None’, height: ‘int | None’, format: ‘str | None’, extra: ‘NestedDict’)

**width**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.image.result.ImageSearchDocument.width}

**height**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.image.result.ImageSearchDocument.height}

**format**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.image.result.ImageSearchDocument.format}

**extra**\: *[NestedDict](other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._search_api.utils.NestedDict)*{#yandex_cloud_ml_sdk._search_api.image.result.ImageSearchDocument.extra}

**url**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.image.result.ImageSearchDocument.url}

**domain**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.image.result.ImageSearchDocument.domain}

**modtime**\: *[datetime.datetime](https://docs.python.org/3/library/datetime.html#datetime.datetime) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.image.result.ImageSearchDocument.modtime}

## Search by image

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.by\_image.result.**ByImageSearchDocument**{#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument}

ByImageSearchDocument(url: ‘str’, format: ‘str | None’, width: ‘int’, height: ‘int’, passage: ‘str’, host: ‘str’, page\_title: ‘str’, page\_url: ‘str’)

**url**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument.url}

Image URL.

**format**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument.format}

Image format.

**width**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument.width}

Image width.

**height**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument.height}

Image height.

**passage**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument.passage}

Text passage.

**host**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument.host}

Document host.

**page\_title**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument.page_title}

Document title.

**page\_url**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.by_image.result.ByImageSearchDocument.page_url}

Document URL.

## Enum-like settings

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**SearchType**{#yandex_cloud_ml_sdk._search_api.enums.SearchType}

Search type.

**RU** = *1*{#yandex_cloud_ml_sdk._search_api.enums.SearchType.RU}

**TR** = *2*{#yandex_cloud_ml_sdk._search_api.enums.SearchType.TR}

**COM** = *3*{#yandex_cloud_ml_sdk._search_api.enums.SearchType.COM}

**KK** = *4*{#yandex_cloud_ml_sdk._search_api.enums.SearchType.KK}

**BE** = *5*{#yandex_cloud_ml_sdk._search_api.enums.SearchType.BE}

**UZ** = *6*{#yandex_cloud_ml_sdk._search_api.enums.SearchType.UZ}

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.SearchType.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.SearchType.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.SearchType.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.SearchType.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.SearchType.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.SearchType.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.SearchType.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.SearchType.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.SearchType.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.SearchType.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.SearchType.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.SearchType.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**FamilyMode**{#yandex_cloud_ml_sdk._search_api.enums.FamilyMode}

Results filtering.

**NONE** = *1*{#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.NONE}

Filtering is disabled. Search results include any documents regardless of their contents.

**MODERATE** = *2*{#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.MODERATE}

Moderate filter (default value). Documents of the Adult category are excluded from search results unless a query is explicitly made for searching resources of this category.

**STRICT** = *3*{#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.STRICT}

Regardless of a search query, documents of the Adult category and those with profanity are excluded from search results.

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.FamilyMode.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**FixTypoMode**{#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode}

Search query typo correction setting

**ON** = *1*{#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.ON}

Automatically correct typos (default value).

**OFF** = *2*{#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.OFF}

Autocorrection is off.

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**SortOrder**{#yandex_cloud_ml_sdk._search_api.enums.SortOrder}

Search results sorting order

**ASC** = *1*{#yandex_cloud_ml_sdk._search_api.enums.SortOrder.ASC}

Reverse order from oldest to most recent.

**DESC** = *2*{#yandex_cloud_ml_sdk._search_api.enums.SortOrder.DESC}

Direct order from most recent to oldest (default).

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.SortOrder.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.SortOrder.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.SortOrder.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.SortOrder.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.SortOrder.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.SortOrder.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.SortOrder.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.SortOrder.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.SortOrder.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.SortOrder.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.SortOrder.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.SortOrder.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**SortMode**{#yandex_cloud_ml_sdk._search_api.enums.SortMode}

Search results sorting mode rule

**BY\_RELEVANCE** = *1*{#yandex_cloud_ml_sdk._search_api.enums.SortMode.BY_RELEVANCE}

Sort documents by relevance (default value).

**BY\_TIME** = *2*{#yandex_cloud_ml_sdk._search_api.enums.SortMode.BY_TIME}

Sort documents by update time.

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.SortMode.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.SortMode.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.SortMode.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.SortMode.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.SortMode.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.SortMode.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.SortMode.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.SortMode.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.SortMode.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.SortMode.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.SortMode.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.SortMode.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**GroupMode**{#yandex_cloud_ml_sdk._search_api.enums.GroupMode}

Result grouping method.

**FLAT** = *1*{#yandex_cloud_ml_sdk._search_api.enums.GroupMode.FLAT}

Flat grouping. Each group contains a single document.

**DEEP** = *2*{#yandex_cloud_ml_sdk._search_api.enums.GroupMode.DEEP}

Grouping by domain. Each group contains documents from one domain.

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.GroupMode.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.GroupMode.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.GroupMode.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.GroupMode.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.GroupMode.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.GroupMode.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.GroupMode.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.GroupMode.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.GroupMode.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.GroupMode.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.GroupMode.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.GroupMode.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**Localization**{#yandex_cloud_ml_sdk._search_api.enums.Localization}

Maximum number of groups that can be returned per page.

**RU** = *1*{#yandex_cloud_ml_sdk._search_api.enums.Localization.RU}

**UK** = *2*{#yandex_cloud_ml_sdk._search_api.enums.Localization.UK}

**BE** = *3*{#yandex_cloud_ml_sdk._search_api.enums.Localization.BE}

**KK** = *4*{#yandex_cloud_ml_sdk._search_api.enums.Localization.KK}

**TR** = *5*{#yandex_cloud_ml_sdk._search_api.enums.Localization.TR}

**EN** = *6*{#yandex_cloud_ml_sdk._search_api.enums.Localization.EN}

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.Localization.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.Localization.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.Localization.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.Localization.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.Localization.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.Localization.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.Localization.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.Localization.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.Localization.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.Localization.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.Localization.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.Localization.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**Format**{#yandex_cloud_ml_sdk._search_api.enums.Format}

Search result format

**XML** = *1*{#yandex_cloud_ml_sdk._search_api.enums.Format.XML}

**HTML** = *2*{#yandex_cloud_ml_sdk._search_api.enums.Format.HTML}

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.Format.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.Format.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.Format.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.Format.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.Format.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.Format.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.Format.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.Format.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.Format.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.Format.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.Format.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.Format.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**ImageFormat**{#yandex_cloud_ml_sdk._search_api.enums.ImageFormat}

**JPEG** = *1*{#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.JPEG}

JPG format.

**GIF** = *2*{#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.GIF}

GIF format.

**PNG** = *3*{#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.PNG}

PNG format.

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.ImageFormat.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**ImageOrientation**{#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation}

**VERTICAL** = *1*{#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.VERTICAL}

Horizontal orientation.

**HORIZONTAL** = *2*{#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.HORIZONTAL}

Vertical orientation.

**SQUARE** = *3*{#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.SQUARE}

Square aspect ratio.

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**ImageSize**{#yandex_cloud_ml_sdk._search_api.enums.ImageSize}

**ENORMOUS** = *1*{#yandex_cloud_ml_sdk._search_api.enums.ImageSize.ENORMOUS}

Very large images (larger than 1,600 × 1,200 pixels).

**LARGE** = *2*{#yandex_cloud_ml_sdk._search_api.enums.ImageSize.LARGE}

Large images (from 800 × 600 to 1,600 × 1,200 pixels).

**MEDIUM** = *3*{#yandex_cloud_ml_sdk._search_api.enums.ImageSize.MEDIUM}

Medium images (from 150 × 150 to 800 × 600 pixels).

**SMALL** = *4*{#yandex_cloud_ml_sdk._search_api.enums.ImageSize.SMALL}

Small images (from 32 × 32 to 150 × 150 pixels).

**TINY** = *5*{#yandex_cloud_ml_sdk._search_api.enums.ImageSize.TINY}

Icons (up to 32 × 32 pixels).

**WALLPAPER** = *6*{#yandex_cloud_ml_sdk._search_api.enums.ImageSize.WALLPAPER}

Desktop wallpapers.

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.ImageSize.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.ImageSize.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.ImageSize.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.ImageSize.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.ImageSize.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.ImageSize.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.ImageSize.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.ImageSize.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.ImageSize.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.ImageSize.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.ImageSize.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.ImageSize.__init__i}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.enums.**ImageColor**{#yandex_cloud_ml_sdk._search_api.enums.ImageColor}

**COLOR** = *1*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.COLOR}

Color images.

**GRAYSCALE** = *2*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.GRAYSCALE}

Black and white images.

**RED** = *3*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.RED}

Red is the main color of the image.

**ORANGE** = *4*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.ORANGE}

Orange is the main color of the image.

**YELLOW** = *5*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.YELLOW}

Yellow is the main color of the image.

**GREEN** = *6*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.GREEN}

Green is the main color of the image.

**CYAN** = *7*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.CYAN}

Cyan is the main color of the image.

**BLUE** = *8*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.BLUE}

Blue is the main color of the image.

**VIOLET** = *9*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.VIOLET}

Violet is the main color of the image.

**WHITE** = *10*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.WHITE}

White is the main color of the image.

**BLACK** = *11*{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.BLACK}

Black is the main color of the image.

*classmethod* **Unknown**(*name*, *value*){#yandex_cloud_ml_sdk._search_api.enums.ImageColor.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_api.enums.ImageColor.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_api.enums.ImageColor.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_api.enums.ImageColor.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_api.enums.ImageColor.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_api.enums.ImageColor.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._search_api.enums.ImageColor.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_api.enums.ImageColor.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_api.enums.ImageColor.__init__i}