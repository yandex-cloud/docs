#### Quotas {#search-api-quotas}

| Type of limit | Value |
| ----- | ----- |
| Number of requests per day | 1,000 |
| Number of requests per hour (`hourly_limits`) | Depends on the time of day^1^</br>From 00:00:00 to 00:59:59: 30% of the daily quota</br>From 00:59:59 to 03:59:59: 40% of the daily quota</br>From 04:00:00 to 07:59:59: 60% of the daily quota</br>From 08:00:00 to 08:59:59: 40% of the daily quota</br> From 09:00:00 to 09:59:59: 30% of the daily quota</br> From 10:00:00 to 10:59:59: 20% of the daily quota</br> From 11:00:00 to 22:59:59: 10% of the daily quota</br> From 23:00:00 to 23:59:59: 20% of the daily quota |
| Number of requests per second (`rps_restriction`) | Depends on the number of requests per hour: `rps_restriction` = `hourly_limits`/3420 |

^1^ The time zone is [UTC+3](https://en.wikipedia.org/wiki/UTC%2B03:00).

> For example, if the quota is 1,000 requests per day, you can send a maximum of 100 requests per hour from 11:00:00 to 22:59:59 (approximately, one request every 30 seconds) and a maximum of 400 requests (approximately, one request every 8 seconds) from 08:00:00 to 08:59:59.
> If you increase the quota for the number of requests per day to 2,000, you can send a maximum of 200 requests per hour from 11:00:00 to 22:59:59 (approximately, one request every 15 seconds) and a maximum of 800 requests (approximately, one request every 4 seconds) from 08:00:00 to 08:59:59.


#### Limits {#search-api-limits}

| Type of limit | Value |
| ----- | ----- |
| Number of results returned | Up to 1,000 |
| Maximum request length | {{ search-api-request-ch }} |
| Maximum number of words per request | {{ search-api-request-w }} |