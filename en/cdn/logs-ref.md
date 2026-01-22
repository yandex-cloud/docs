---
title: CDN and shielding server request logs reference
description: This section contains descriptions of log fields of CDN and shielding server requests for different providers.
---

# CDN and shielding server request logs reference

{{ cdn-full-name }} logs are stored in JSON format. One log entry represents one request to a CDN server.

Learn more about exporting logs in the [Log export](concepts/logs.md) section.

## Log example {#yc-cdn-example}

```json
{
  "resource_id": "cdnrxyssrqvk********",
  "timestamp_ms": "2025-11-17 16:23:18.798",
  "bytes_sent": 103356,
  "request_uri": "/probe/test_file_102400.mp4?size=102400",
  "status": "200",
  "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 YaBrowser/25.8.0.0 Safari/537.36",
  "request_id": "3ecf1d50********",
  "remote_addr": "178.19.*.*",
  "upstream_addr": "",
  "request_time": 0,
  "upstream_cache_status": "HIT",
  "http_host": "*******.cdn.yandex.net",
  "upstream_response_time": ""
}
```

### Log fields {#yc-cdn-fields}

#|
|| **Field** | **Type** | **Description** ||
|| `resource_id` | String | Client resource ID. ||
|| `timestamp_ms` | String | Event time (UTC). ||
|| `bytes_sent` | Int64 | Total number of bytes sent to the client, including the response header. ||
|| `request_uri` | String | Full original resource URI received by the [PoP](./concepts/points-of-presence.md) server. ||
|| `status` | String | Response code sent to the client for the request. ||
|| `user_agent` | String | Identifies the client browser that has made the request. ||
|| `request_id` | String | Internal request ID within the service. ||
|| `remote_addr` | String | IP of the client that has made the request. ||
|| `upstream_addr` | String | IP address of the source that has responded to the request. This field will be empty if the response originated from the PoP server cache. ||
|| `request_time` | Float | Request processing time in seconds. It is the time elapsed from when the first bytes were read from the client until the log entry was made after the last bytes were sent to the client. ||
|| `upstream_cache_status` | String | Cache processing status. The possible values are:

* `HIT`: Response retrieved from cache.
* `MISS`: Response retrieved after accessing the source.
* `BYPASS`: Cache bypassed, response retrieved after accessing the source.
* `EXPIRED`: Cache TTL expired, response retrieved after accessing the source.
* `STALE`: Obsolete (stale) cache was given. ||
|| `http_host` | String | Domain name specified by the client in the Host HTTP header when accessing the server. ||
|| `upstream_response_time` | String | Source response time. This field will be empty if the response originated from the PoP server cache. ||
|#

#### See also {#see-also}

* [Log export](concepts/logs.md)
* [Configuring log export](operations/resources/configure-logs.md)
