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
Cannot validate the transmitted XML file or incorrect request parameters are set. Possible cause:

- Incorrect tags or tag values are provided.
- The request body contains non-escaped special characters, such as the ampersand (`&`).
- A page with search results whose positions exceed 1,000 is requested. For example, if each page contains 10 search results, an error is returned at an attempt to request 101st and further pages with results.
||
|| 19 | A search query contains incompatible parameters (e.g., incompatible values of the `groupings` element). ||
|| 20 | Unknown error cause. If the error occurs again, contact support. ||
|| 31 | The user is not registered with the service. ||
|| 32 | Limit on the allowed daily number of queries exceeded. Learn about the [limits](../concepts/limits.md) and request a quota increase. ||
|| 33 | IP address a search query was sent from does not match the one(s) specified during [registration](../operations/registration.md). ||
|| 31 | The user with the specified username is not registered with the service. ||
|| 37 | Error in request parameters. Mandatory parameters may be missing or mutually exclusive parameters may be defined. ||
|| 42 | The key issued during registration is incorrect. Check if the IP address used to send requests is correct. ||
|| 43 | Incorrect API key version. Check if the IP address used to send requests is correct. ||
|| 44 | The IP address used for sending requests is no longer supported. Fix the value to match the address specified during registration. ||
|| 48 | The search type specified during registration is different from the type used to request data. Change the domain for making requests to the correct one. ||
|| 55 | The number of requests sent per second (RPS) has exceeded the [allowed value](../concepts/limits.md). ||
|| 100 | It is highly likely that a request is made by a bot. If this error occurs, the user should be returned a CAPTCHA. ||
|#