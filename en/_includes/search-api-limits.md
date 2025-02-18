#### Quotas {#search-api-quotas}

| Type of limit | Value |
| ----- | ----- |
| **[API v1](../search-api/concepts/index.md#api-v1)** | | 
| Number of synchronous requests per day | 100 000</br></br>Daily limit resets at 00:00:00 [GMT](https://en.wikipedia.org/wiki/Greenwich_Mean_Time) (00:03:00 [UTC+3](https://en.wikipedia.org/wiki/UTC%2B03:00)) |
| Number of synchronous requests per hour (`hourly_limits`) | Depends on the time of day^1^</br>From 00:00:00 to 00:59:59: 30% of the daily quota</br>From 00:59:59 to 03:59:59: 40% of the daily quota</br>From 04:00:00 to 07:59:59: 60% of the daily quota</br>From 08:00:00 to 08:59:59: 40% of the daily quota</br> From 09:00:00 to 09:59:59: 30% of the daily quota</br> From 10:00:00 to 10:59:59: 20% of the daily quota</br> From 11:00:00 to 22:59:59: 10% of the daily quota</br> From 23:00:00 to 23:59:59: 20% of the daily quota  |
| Number of synchronous requests per second (`rps_restriction`) | Depends on the number of requests per hour: `rps_restriction` = `hourly_limits`/3,420  |
| **[API v2](../search-api/concepts/index.md#api-v2)** | |
| Number of synchronous requests per hour | 10,000 |
| Number of synchronous requests per second | 10 |
| Number of deferred requests per hour | 150 000 |
| Number of deferred requests per second | 50 |
| Number of requests, per second, for results of a deferred request | 50 |

^1^ The time zone is [UTC+3](https://en.wikipedia.org/wiki/UTC%2B03:00).

> For example, if the quota is 100,000 requests per day, you can send a maximum of 10,000 requests per hour from 11:00:00 to 22:59:59 (approximately 3 requests per second) and a maximum of 40,000 requests (approximately 11 requests per second) from 08:00:00 to 08:59:59. 
> If you increase your daily quota of requests to 200,000, you can send a maximum of 20,000 requests per hour from 11:00:00 to 22:59:59 (approximately six requests per second) and a maximum of 80,000 requests (approximately 22 requests per second) from 08:00:00 to 08:59:59. 


#### Limits {#search-api-limits}

| Type of limit | Value |
| ----- | ----- |
| Number of results returned | Up to 250 |
| Maximum request length | {{ search-api-request-ch }} |
| Maximum number of words per request | {{ search-api-request-w }} |
| Minimum processing time for a request in deferred mode | 5 minutes |