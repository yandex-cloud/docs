# Error codes

If search queries are handled incorrectly, server [responses](../concepts/response.md) contain the `error` tag.

Format:

```xml
<error code="error code">
Error text description</error>
```

The table below contains codes and descriptions of the most common errors that may occur when handling search queries.

#|
|| **Error code** | **Description**||
|| 1 |
Query text (value provided in the `query` field) contains a syntax error.

For example, two consecutive slash characters (`//`) are sent as a query.
||
|| 2 | An empty search query is made (the `query` field set to Null is sent). ||
|| 15 | No search results available for the search query made. ||
|| 18 |
Cannot validate the transmitted XML file or incorrect request parameters are set. Possible causes include:

- Incorrect tags or tag values are provided.
- The request body contains non-escaped special characters, such as the ampersand (`&`).
- A page with search results whose positions exceed 1,000 is requested. For example, if each page contains 10 search results, an error is returned at an attempt to request 101st and further pages with results.
||
|| 19 | A search query contains incompatible parameters (e.g., incompatible values of the `groupings` element). ||
|| 20 | Unknown error cause. If you encounter this error again, contact [support]({{ link-console-support }}). ||
|| 31 | The request includes an ID of a folder (the `folderid` field) whose user has not [registered](../operations/registration.md) with {{ search-api }}. ||
|| 32 | Limit on the allowed daily number of queries exceeded. Learn about the [limits](../concepts/limits.md) and request a quota increase. ||
|| 33 | IP address a search query was sent from does not match the one(s) specified during [registration](../operations/registration.md). ||
|| 37 | Error in request parameters. Mandatory parameters may be missing or mutually exclusive parameters may be defined. ||
|| 42 | The provided API key failed authentication or authorization. Check that your API key is valid and that the [service account](../../iam/concepts/users/service-accounts.md) used to send requests has the `search-api.executor` [role](../security/index.md). ||
|| 44 | The IP address you are trying to access is no longer supported. Fix the value to match the address specified during registration. ||
|| 48 | The search type specified during registration is different from the type used to request data. Correct the search type in your request or the management console. ||
|| 55 | The maximum [allowed number of requests per second](../concepts/limits.md) has been exceeded. ||
|| 100 | It is highly likely that a request is made by a bot. If this error occurs, the user should be returned a CAPTCHA. ||
|#