---
title: Error codes {{ search-api-name }}
description: If search queries are handled incorrectly, server responses contain the error tag.
---

# Error codes

If search queries are handled incorrectly, the server [response](../concepts/response.md) contains the `error` tag.

Format:

```xml
<error code="error code">
Text description of the error</error>
```

The table below contains codes and descriptions of the most common errors that may occur when handling search queries.

#|
|| **Error code** | **Description**||
|| 1 | 
Query text (`query` field value) contains a syntax error.

For example, two consecutive slash characters (`//`) are provided as a query. 
||
|| 2 | The search query is empty (the `query` field has an empty value). ||
|| 15 | No search results are available for the search query. ||
|| 18 | 
Unable to validate the transmitted XML file, or query parameters are incorrect. Possible causes:

- Incorrect tags or tag values are provided.
- The query body contains unescaped special characters, e.g., the ampersand (`&`), etc.
- A page with search results whose positions exceed 1,000 is requested. For example, if each page contains 10 search results, an error is returned at an attempt to request 101st and further pages with results. 
||
|| 19 | The search query contains incompatible parameters (e.g., incompatible `groupings` values). ||
|| 20 | Unknown error cause. If you encounter this error again, contact [support]({{ link-console-support }}). ||
|| 31 | The query includes an ID of a folder (`folderid`) whose user has not [registered](../operations/workaround.md) in {{ search-api }}. ||
|| 32 | Limit on the allowed number of queries per day was exceeded. Learn about the [limits](../concepts/limits.md) and request a quota increase. ||
|| 33 | The IP address the search query was sent from does not match the one(s) specified during [registration](../operations/workaround.md). ||
|| 37 | Error in query parameters. Some required parameters may be missing or mutually exclusive parameters defined. ||
|| 42 | The provided API key failed authentication or authorization. Check that your API key is valid and that the [service account](../../iam/concepts/users/service-accounts.md) used to send requests has the `search-api.executor` [role](../security/index.md). ||
|| 44 | The IP address you are trying to access is no longer supported. Fix the value to match the address specified during registration. ||
|| 48 | The search type specified during registration is different from the type used to request data. Correct the search type in your query or the management console. ||
|| 55 | The maximum [allowed number of queries per second](../concepts/limits.md) was exceeded. ||
|| 100 | It is highly likely that the query is bot-generated. If this error occurs, the user should get a CAPTCHA again. ||
|| 10002 | The [maximum number of words](../concepts/limits.md#search-api-limits) per search query was exceeded. ||
|#