---
title: CDN and shielding server request logs reference
description: This section contains descriptions of log fields of CDN and shielding server requests for different providers.
---

# CDN and shielding server request logs reference

CDN and shielding server request logs differ depending on your [provider](concepts/providers.md).

Learn more about exporting logs in the [Log export](concepts/logs.md) section.

## {{ cdn-full-name }} {#yc-cdn}

{{ cdn-full-name }} logs are stored in JSON format. One log entry represents one request to a CDN server.

### Log example {#yc-cdn-example}

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

## EdgeCDN {#edgecdn}

[EdgeCDN](https://edgecenter.ru/en/cdn) logs contain information about user requests that are received by caching CDN servers and the precache server (if [shielding is enabled](https://edgecenter.ru/en/knowledge-base/cdn/origin-shielding) for the resource). Logs are stored in text format. One log entry represents one request to a CDN server.

### Log format {#edgecdn-format}

```text
"$remote_addr" "-" "$remote_user" "[$time_local]" "$request" "$status" "$body_bytes_sent" "$http_referer" "$http_user_agent" "$bytes_sent"
"$edgename" "$scheme""$host" "$request_time" "$upstream_response_time" "$request_length" "$http_range" "[$responding_node]"
"$upstream_cache_status" "$upstream_response_length" "$upstream_addr" "$gcdn_api_client_id" "$gcdn_api_resource_id" "$uid_got" "$uid_set"
"$geoip_country_code" "$geoip_city" "$shield_type" "$server_addr" "$server_port" "$upstream_status" "-" "$upstream_connect_time"
"$upstream_header_time" "$shard_addr" "$geoip2_data_asnumber" "$connection" "$connection_requests" "$request_id" "$http_x_forwarded_proto"
"$http_x_forwarded_request_id" "$ssl_cipher" "$ssl_session_id" "$ssl_session_reused" "$sent_http_content_type" "$real_tcpinfo_rtt"
"$http_x_forwarded_http_ver" "$vp_enabled" "$geoip2_region"
```

### Log example {#edgecdn-example}

```
"0.0.0.0" "-" "-" "[26/Apr/2019:09:47:40 +0000]" "GET /ContentCommon/images/image.png HTTP/1.1" "200" "1514283" "https://example.com/videos/10"
"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 YaBrowser/16.10.0.2309 Safari/537.36"
"1514848" "[dh-up-gc18]" "https" "cdn.example.com" "1.500" "0.445" "157" "bytes=0-1901653" "[dh]" "MISS" "10485760" "0.0.0.0:80" "2510" "7399" "-"
"-" "KZ" "-" "shield_no" "0.0.0.0" "80" "206" "-" "0.000" "0.200" "0.0.0.0" "asnumber" "106980391" "1" "c1c0f12ab35b7cccccd5dc0a********" "-" "-"
"ECDHE-RSA-AES256-GCM-SHA384" "28a4184139cb43cdc79006cf2d1a4ac9********" "r" "application/json" "11863" "HTTP/1.1" "1" "AMU"
```

### Log variables {#edgecdn-fields}

EdgeCDN system variables do not carry valuable information for client analysis.

#|
|| **Variable** | **Value from the example** | **Comment** ||
|| `$remote_addr` | `0.0.0.0` | User IP address. ||
|| `-` | `-` | This field is not used. ||
|| `$remote_user` | Internal system variable. | Username used in Basic authentication. ||
|| `[$time_local]` | `[26/Apr/2019:09:47:40 +0000]` | Local time in [Common Log Format](https://www.w3.org/Daemon/User/Config/Logging.html#common-logfile-format). ||
|| `$request` | 

```bash
GET
/ContentCommon/images/image.png
HTTP/1.1
```

| HTTP request type, path to requested file, HTTP version. ||
|| `$status` | `200` | CDN server response code. ||
|| `$body_bytes_sent` | `1514283` | Number of bytes transmitted to the client, excluding the response header. ||
|| `$http_referer` | `https://example.com/videos/10` | URL the user came from. ||
|| `$http_user_agent` | `Mozilla/5.0...` | User Agent the user used to request the file (browser or another program). ||
|| `$bytes_sent` | `1514848` | Number of bytes transmitted to the user. ||
|| `[$edgename]` | `[dh-up-gc18]` | Name of the responding CDN server in EdgeCDN. ||
|| `$scheme` | `https` | Request protocol (HTTP or HTTPS). ||
|| `$host` | `cdn.example.com` | Personal domain of the CDN resource. ||
|| `$request_time` | `1.500` | Request processing time, which is time elapsed from when the first bytes were read from the client until the log entry was made after the last bytes were sent to the client, in seconds with millisecond precision. ||
|| `$upstream_response_time` | `0.445` | Time spent to get the response from the source, in seconds with millisecond precision. For multiple responses, the time should be separated by commas and colons. ||
|| `$request_length` | `157` | Request length (including the request line, header, and body). ||
|| `$http_range` | `bytes=0-1901653` | Size of the file fragment in a Range request. ||
|| `[$responding_node]` | `dh` | Name of the responding EdgeCDN data center. ||
|| `$upstream_cache_status` | `MISS` | Status of the requested file in the CDN cache:

* `HIT`: File released from cache.
* `STALE`: File is stale as the source did not respond or responded incorrectly during cache update.
* `UPDATING`: File is stale as it is undergoing an update following the previous request.
* `REVALIDATED`: It was established by executing the proxy_cache_revalidate directive that the file on the source has not changed.
* `EXPIRED`: Cache TTL has expired, but the file matches the file from the source. A request to the source is sent for recaching.
* `MISS`: File not released from cache, proxied from the source.
* `BYPASS`: On first request for the file after clearing the cache. ||
|| `$upstream_response_length` | `10485760` | Length of response from source, stored in bytes. For multiple responses, lengths should be separated by commas and colons. ||
|| `$upstream_addr` | `0.0.0.0:80` | Source IP address and port. ||
|| `$gcdn_api_client_id` | Internal system variable. | Your ID in the EdgeCDN system. ||
|| `$gcdn_api_resource_id` | Internal system variable. | Your resource's ID in EdgeCDN. ||
|| `$uid_got` | Internal system variable. | Cookie name and received user ID. ||
|| `$uid_set` | Internal system variable. | Cookie name and issued user ID. ||
|| `$geoip_country_code` | `KZ` | User's country code. ||
|| `$geoip_city` | `-` | User's city code. ||
|| `$shield_type` | Internal system variable. | The shielding on this resource is:
* `shield_old`: Enabled.
* `shield_no`: Disabled. ||
|| `$server_addr` | Internal system variable. | IP address of responding anycast zone or CDN server. ||
|| `$server_port` | Internal system variable. | Port the request arrived on. ||
|| `$upstream_status` | `206` | Source response code. ||
|| `-` | `-` | This field is not used. ||
|| `$upstream_connect_time` | `0.000` | Time spent to connect to the source, in seconds with millisecond precision. ||
|| `$upstream_header_time` | `0.200` | Time spent to get response headers from the source, in seconds with millisecond precision. ||
|| `$shard_addr` | Internal system variable. | IP address of the CDN server that initially accepted the client's request with sharding enabled for the resource. ||
|| `$geoip2_data_asnumber` | `asnumber` | Number of the autonomous system the user's request originated from. ||
|| `$connection` | Internal system variable. | Sequence number of the connection. ||
|| `$connection_requests` | Internal system variable. | Current number of requests in the connection. ||
|| `$request_id` | Internal system variable. | Unique request ID generated from 16 random bytes, in hexadecimal format. ||
|| `$http_x_forwarded_proto` | `-` | Initial incoming request protocol (HTTP or HTTPS). ||
|| `$http_x_forwarded_request_id` | Internal system variable. | Initial ID of the incoming request. ||
|| `$ssl_cipher` | Internal system variable. | Cipher used for the established SSL connection. ||
|| `$ssl_session_id` | Internal system variable. | Established SSL connection session ID. ||
|| `$ssl_session_reused` | Internal system variable. | Returns `r` if the session was reused; otherwise returns `.`. ||
|| `$sent_http_content_type` | `application/json` | Value of HTTP Content-Type header indicating the MIME type of the transmitted resource. ||
|| `$real_tcpinfo_rtt` | `11863` | Average time required to transmit a packet to and from the server (latency). ||
|| `$http_x_forwarded_http_ver` | `HTTP/1.1` | HTTP version in the user's request. ||
|| `$vp_enabled` | `1` | Flag for whether the streaming platform feature is enabled.
* `1`: Enabled.
* `0`: Disabled. ||
|| `$geoip2_region` | `AMU` | Region name according to the [ISO 3166-2](https://www.iso.org/iso-3166-country-codes.html) standard. ||
|#

You can learn more about EdgeCDN logs in [this EdgeCenter guide](https://edgecenter.ru/knowledge-base/cdn/raw-logs).

#### See also {#see-also}

* [Log export](concepts/logs.md)
* [Configuring log export](operations/resources/configure-logs.md)
