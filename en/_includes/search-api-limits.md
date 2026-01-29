#### Quotas {#search-api-quotas}

| Type of limit | Value |
| ----- | ----- |
| **[API v2](../search-api/concepts/index.md#api-v2)** | |
| Number of synchronous requests per hour | 10,000 |
| Number of synchronous requests per second | 10 |
| Number of synchronous requests per second to get a generative response | 1 |
| Number of deferred requests per hour | 35,000 |
| Number of deferred requests per second | 10 |
| Number of requests per second for results of a deferred request | 10 |
| Number of requests per hour for search with generative response| 1,000 |
| Number of requests per hour for image search by text description |10,000 |
| Number of requests per second for image search by text description | 10 |
| Number of requests per hour for image search by image | 36,000 |
| Number of requests per second for image search by image | 10 |


#### Limits {#search-api-limits}

| Type of limit | Value |
| ----- | ----- |
| Number of results returned | Up to 250 |
| Maximum request length | {{ search-api-request-ch }} |
| Maximum number of words per request | {{ search-api-request-w }} |
| Minimum processing time for a request in deferred mode | 5 minutes |
| **Requests with [generative response](../search-api/concepts/generative-response.md)** | |
| Maximum number of websites per request | 5 |
| Maximum number of hosts per request | 5 |
| Maximum number of pages per request | 10 |