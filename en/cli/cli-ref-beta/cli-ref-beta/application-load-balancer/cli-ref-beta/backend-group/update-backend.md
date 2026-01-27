---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/application-load-balancer/cli-ref-beta/backend-group/update-backend.md
---

# yc beta application-load-balancer backend-group update-backend

Updates the specified backend.

#### Command Usage

Syntax:

`yc beta application-load-balancer backend-group update-backend <BACKEND-GROUP-ID>`

#### Flags

#|
||Flag | Description ||
|| `--backend-group-id` | `string`

ID of the backend group to update the backend in. ||
|| `--http` | `shorthand/json`

New settings for the HTTP backend.

Shorthand Syntax:

```hcl
{
  backend-type = storage-bucket={
    bucket = str
  } | target-groups={
    target-group-ids = str,...
  },
  backend-weight = int,
  healthchecks = [
    {
      healthcheck = grpc={
        service-name = str
      } | http={
        expected-statuses = int,...,
        host = str,
        path = str,
        use-http2 = bool
      } | stream={
        receive = {
          payload = text=str
        },
        send = {
          payload = text=str
        }
      },
      healthcheck-port = int,
      healthy-threshold = int,
      interval = duration,
      interval-jitter-percent = double,
      timeout = duration,
      transport-settings = plaintext={} | tls={
        sni = str,
        validation-context = {
          trusted-ca = trusted-ca-bytes=str | trusted-ca-id=str
        }
      },
      unhealthy-threshold = int
    }, ...
  ],
  load-balancing-config = {
    locality-aware-routing-percent = int,
    mode = ROUND_ROBIN|RANDOM|LEAST_REQUEST|MAGLEV_HASH,
    panic-threshold = int,
    strict-locality = bool
  },
  name = str,
  port = int,
  tls = {
    sni = str,
    validation-context = {
      trusted-ca = trusted-ca-bytes=str | trusted-ca-id=str
    }
  },
  use-http2 = bool
}
```

JSON Syntax:

```json
{
  "backend-type": {
    "storage-bucket": {
      "bucket": "str"
    },
    "target-groups": {
      "target-group-ids": [
        "str", ...
      ]
    }
  },
  "backend-weight": "int",
  "healthchecks": [
    {
      "healthcheck": {
        "grpc": {
          "service-name": "str"
        },
        "http": {
          "expected-statuses": [
            "int", ...
          ],
          "host": "str",
          "path": "str",
          "use-http2": "bool"
        },
        "stream": {
          "receive": {
            "payload": {
              "text": "str"
            }
          },
          "send": {
            "payload": {
              "text": "str"
            }
          }
        }
      },
      "healthcheck-port": "int",
      "healthy-threshold": "int",
      "interval": "duration",
      "interval-jitter-percent": "double",
      "timeout": "duration",
      "transport-settings": {
        "plaintext": {},
        "tls": {
          "sni": "str",
          "validation-context": {
            "trusted-ca": {
              "trusted-ca-bytes": "str",
              "trusted-ca-id": "str"
            }
          }
        }
      },
      "unhealthy-threshold": "int"
    }, ...
  ],
  "load-balancing-config": {
    "locality-aware-routing-percent": "int",
    "mode": "ROUND_ROBIN|RANDOM|LEAST_REQUEST|MAGLEV_HASH",
    "panic-threshold": "int",
    "strict-locality": "bool"
  },
  "name": "str",
  "port": "int",
  "tls": {
    "sni": "str",
    "validation-context": {
      "trusted-ca": {
        "trusted-ca-bytes": "str",
        "trusted-ca-id": "str"
      }
    }
  },
  "use-http2": "bool"
}
```

Fields:

```
backend-weight -> (int)
  Backend weight. Traffic is distributed between backends of a backend group according to their weights. Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. If the weight is non-positive, traffic is not sent to the backend.
healthchecks -> ([]struct)
  Health checks to perform on targets from target groups. For details about health checking, see documentation. If no health checks are specified, active health checking is not performed.
  healthcheck-port -> (int)
    Port used for health checks. If not specified, the backend port ([HttpBackend.port] or [GrpcBackend.port]) is used for health checks.
  healthy-threshold -> (int)
    Number of consecutive successful health checks required to mark an unhealthy target as healthy. Both '0' and '1' values amount to one successful check required. The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. Default value: '0'.
  interval -> (duration)
    Base interval between consecutive health checks.
  interval-jitter-percent -> (double)
  timeout -> (duration)
    Health check timeout. The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed.
  unhealthy-threshold -> (int)
    Number of consecutive failed health checks required to mark a healthy target as unhealthy. Both '0' and '1' values amount to one unsuccessful check required. The value is ignored if a health check is failed due to an HTTP '503 Service Unavailable' response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. Default value: '0'.
  healthcheck -> (oneof<grpc|http|stream>)
    Oneof healthcheck field
    stream -> (struct)
      TCP stream health check settings.
      receive -> (struct)
        Data that must be contained in the messages received from targets for a successful health check. If not specified, no messages are expected from targets, and those that are received are not checked.
        payload -> (oneof<text>)
          Oneof payload field
          text -> (string)
            Payload text.
      send -> (struct)
        Message sent to targets during TCP data transfer. If not specified, no data is sent to the target.
        payload -> (oneof<text>)
          Oneof payload field
          text -> (string)
            Payload text.
    http -> (struct)
      HTTP health check settings.
      expected-statuses -> ([]int)
        A list of HTTP response statuses considered healthy. By default only 200 HTTP status code considered healthy.
      host -> (string)
        Value for the HTTP/1.1 'Host' header or the HTTP/2 ':authority' pseudo-header used in requests to targets.
      path -> (string)
        HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 ':path' pseudo-header.
      use-http2 -> (bool)
        Enables HTTP/2 usage in health checks. Default value: 'false', HTTP/1.1 is used.
    grpc -> (struct)
      gRPC health check settings.
      service-name -> (string)
        Name of the gRPC service to be checked. If not specified, overall health is checked. For details about the concept, see GRPC Health Checking Protocol.
  transport-settings -> (oneof<plaintext|tls>)
    Oneof transport-settings field
    plaintext -> (struct)
    tls -> (struct)
      sni -> (string)
        SNI string for TLS connections.
      validation-context -> (struct)
        Validation context for backend TLS connections.
        trusted-ca -> (oneof<trusted-ca-bytes|trusted-ca-id>)
          Oneof trusted-ca field
          trusted-ca-id -> (string)
          trusted-ca-bytes -> (string)
            X.509 certificate contents in PEM format.
load-balancing-config -> (struct)
  Load balancing configuration for the backend.
  locality-aware-routing-percent -> (int)
    Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see documentation. If there are no healthy backends in an availability zone, all the traffic is divided between other zones. If [strict_locality] is 'true', the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. Default value: '0'.
  mode -> (struct)
    Load balancing mode for the backend. For details about load balancing modes, see documentation.
  panic-threshold -> (int)
    Threshold for panic mode. If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see documentation. If the value is '0', panic mode will never be activated and traffic is routed only to healthy backends at all times. Default value: '0'.
  strict-locality -> (bool)
    Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. If set to 'true' and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see documentation. If 'strict_locality' is 'true', the value specified in [locality_aware_routing_percent] is ignored. Default value: 'false'.
name -> (string)
  Name of the backend.
port -> (int)
  Port used by all targets to receive traffic.
tls -> (struct)
  Settings for TLS connections between load balancer nodes and backend targets. If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context]. If not specified, the load balancer establishes unencrypted HTTP connections with targets.
  sni -> (string)
    Server Name Indication (SNI) string for TLS connections.
  validation-context -> (struct)
    Validation context for TLS connections.
    trusted-ca -> (oneof<trusted-ca-bytes|trusted-ca-id>)
      Oneof trusted-ca field
      trusted-ca-id -> (string)
      trusted-ca-bytes -> (string)
        X.509 certificate contents in PEM format.
use-http2 -> (bool)
  Enables HTTP/2 usage in connections between load balancer nodes and backend targets. Default value: 'false', HTTP/1.1 is used.
backend-type -> (oneof<storage-bucket|target-groups>)
  Oneof backend-type field
  target-groups -> (struct)
    Target groups that belong to the backend. For details about target groups, see documentation.
    target-group-ids -> ([]string)
      List of ID's of target groups that belong to the backend. To get the ID's of all available target groups, make a [TargetGroupService.List] request.
  storage-bucket -> (struct)
    Object Storage bucket to use as the backend. For details about buckets, see documentation. If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see documentation.
    bucket -> (string)
      Name of the bucket.
``` ||
|| `--grpc` | `shorthand/json`

New settings for the gRPC backend.

Shorthand Syntax:

```hcl
{
  backend-type = target-groups={
    target-group-ids = str,...
  },
  backend-weight = int,
  healthchecks = [
    {
      healthcheck = grpc={
        service-name = str
      } | http={
        expected-statuses = int,...,
        host = str,
        path = str,
        use-http2 = bool
      } | stream={
        receive = {
          payload = text=str
        },
        send = {
          payload = text=str
        }
      },
      healthcheck-port = int,
      healthy-threshold = int,
      interval = duration,
      interval-jitter-percent = double,
      timeout = duration,
      transport-settings = plaintext={} | tls={
        sni = str,
        validation-context = {
          trusted-ca = trusted-ca-bytes=str | trusted-ca-id=str
        }
      },
      unhealthy-threshold = int
    }, ...
  ],
  load-balancing-config = {
    locality-aware-routing-percent = int,
    mode = ROUND_ROBIN|RANDOM|LEAST_REQUEST|MAGLEV_HASH,
    panic-threshold = int,
    strict-locality = bool
  },
  name = str,
  port = int,
  tls = {
    sni = str,
    validation-context = {
      trusted-ca = trusted-ca-bytes=str | trusted-ca-id=str
    }
  }
}
```

JSON Syntax:

```json
{
  "backend-type": {
    "target-groups": {
      "target-group-ids": [
        "str", ...
      ]
    }
  },
  "backend-weight": "int",
  "healthchecks": [
    {
      "healthcheck": {
        "grpc": {
          "service-name": "str"
        },
        "http": {
          "expected-statuses": [
            "int", ...
          ],
          "host": "str",
          "path": "str",
          "use-http2": "bool"
        },
        "stream": {
          "receive": {
            "payload": {
              "text": "str"
            }
          },
          "send": {
            "payload": {
              "text": "str"
            }
          }
        }
      },
      "healthcheck-port": "int",
      "healthy-threshold": "int",
      "interval": "duration",
      "interval-jitter-percent": "double",
      "timeout": "duration",
      "transport-settings": {
        "plaintext": {},
        "tls": {
          "sni": "str",
          "validation-context": {
            "trusted-ca": {
              "trusted-ca-bytes": "str",
              "trusted-ca-id": "str"
            }
          }
        }
      },
      "unhealthy-threshold": "int"
    }, ...
  ],
  "load-balancing-config": {
    "locality-aware-routing-percent": "int",
    "mode": "ROUND_ROBIN|RANDOM|LEAST_REQUEST|MAGLEV_HASH",
    "panic-threshold": "int",
    "strict-locality": "bool"
  },
  "name": "str",
  "port": "int",
  "tls": {
    "sni": "str",
    "validation-context": {
      "trusted-ca": {
        "trusted-ca-bytes": "str",
        "trusted-ca-id": "str"
      }
    }
  }
}
```

Fields:

```
backend-weight -> (int)
  Backend weight. Traffic is distributed between backends of a backend group according to their weights. Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. If the weight is non-positive, traffic is not sent to the backend.
healthchecks -> ([]struct)
  Health checks to perform on targets from target groups. For details about health checking, see documentation. If no health checks are specified, active health checking is not performed.
  healthcheck-port -> (int)
    Port used for health checks. If not specified, the backend port ([HttpBackend.port] or [GrpcBackend.port]) is used for health checks.
  healthy-threshold -> (int)
    Number of consecutive successful health checks required to mark an unhealthy target as healthy. Both '0' and '1' values amount to one successful check required. The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. Default value: '0'.
  interval -> (duration)
    Base interval between consecutive health checks.
  interval-jitter-percent -> (double)
  timeout -> (duration)
    Health check timeout. The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed.
  unhealthy-threshold -> (int)
    Number of consecutive failed health checks required to mark a healthy target as unhealthy. Both '0' and '1' values amount to one unsuccessful check required. The value is ignored if a health check is failed due to an HTTP '503 Service Unavailable' response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. Default value: '0'.
  healthcheck -> (oneof<grpc|http|stream>)
    Oneof healthcheck field
    stream -> (struct)
      TCP stream health check settings.
      receive -> (struct)
        Data that must be contained in the messages received from targets for a successful health check. If not specified, no messages are expected from targets, and those that are received are not checked.
        payload -> (oneof<text>)
          Oneof payload field
          text -> (string)
            Payload text.
      send -> (struct)
        Message sent to targets during TCP data transfer. If not specified, no data is sent to the target.
        payload -> (oneof<text>)
          Oneof payload field
          text -> (string)
            Payload text.
    http -> (struct)
      HTTP health check settings.
      expected-statuses -> ([]int)
        A list of HTTP response statuses considered healthy. By default only 200 HTTP status code considered healthy.
      host -> (string)
        Value for the HTTP/1.1 'Host' header or the HTTP/2 ':authority' pseudo-header used in requests to targets.
      path -> (string)
        HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 ':path' pseudo-header.
      use-http2 -> (bool)
        Enables HTTP/2 usage in health checks. Default value: 'false', HTTP/1.1 is used.
    grpc -> (struct)
      gRPC health check settings.
      service-name -> (string)
        Name of the gRPC service to be checked. If not specified, overall health is checked. For details about the concept, see GRPC Health Checking Protocol.
  transport-settings -> (oneof<plaintext|tls>)
    Oneof transport-settings field
    plaintext -> (struct)
    tls -> (struct)
      sni -> (string)
        SNI string for TLS connections.
      validation-context -> (struct)
        Validation context for backend TLS connections.
        trusted-ca -> (oneof<trusted-ca-bytes|trusted-ca-id>)
          Oneof trusted-ca field
          trusted-ca-id -> (string)
          trusted-ca-bytes -> (string)
            X.509 certificate contents in PEM format.
load-balancing-config -> (struct)
  Load balancing configuration for the backend.
  locality-aware-routing-percent -> (int)
    Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see documentation. If there are no healthy backends in an availability zone, all the traffic is divided between other zones. If [strict_locality] is 'true', the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. Default value: '0'.
  mode -> (struct)
    Load balancing mode for the backend. For details about load balancing modes, see documentation.
  panic-threshold -> (int)
    Threshold for panic mode. If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see documentation. If the value is '0', panic mode will never be activated and traffic is routed only to healthy backends at all times. Default value: '0'.
  strict-locality -> (bool)
    Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. If set to 'true' and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see documentation. If 'strict_locality' is 'true', the value specified in [locality_aware_routing_percent] is ignored. Default value: 'false'.
name -> (string)
  Name of the backend.
port -> (int)
  Port used by all targets to receive traffic.
tls -> (struct)
  Settings for TLS connections between load balancer nodes and backend targets. If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context]. If not specified, the load balancer establishes unencrypted HTTP connections with targets.
  sni -> (string)
    Server Name Indication (SNI) string for TLS connections.
  validation-context -> (struct)
    Validation context for TLS connections.
    trusted-ca -> (oneof<trusted-ca-bytes|trusted-ca-id>)
      Oneof trusted-ca field
      trusted-ca-id -> (string)
      trusted-ca-bytes -> (string)
        X.509 certificate contents in PEM format.
backend-type -> (oneof<target-groups>)
  Oneof backend-type field
  target-groups -> (struct)
    Target groups that belong to the backend.
    target-group-ids -> ([]string)
      List of ID's of target groups that belong to the backend. To get the ID's of all available target groups, make a [TargetGroupService.List] request.
``` ||
|| `--stream` | `shorthand/json`

New settings for the stream (TCP) backend.

Shorthand Syntax:

```hcl
{
  backend-type = target-groups={
    target-group-ids = str,...
  },
  backend-weight = int,
  enable-proxy-protocol = bool,
  healthchecks = [
    {
      healthcheck = grpc={
        service-name = str
      } | http={
        expected-statuses = int,...,
        host = str,
        path = str,
        use-http2 = bool
      } | stream={
        receive = {
          payload = text=str
        },
        send = {
          payload = text=str
        }
      },
      healthcheck-port = int,
      healthy-threshold = int,
      interval = duration,
      interval-jitter-percent = double,
      timeout = duration,
      transport-settings = plaintext={} | tls={
        sni = str,
        validation-context = {
          trusted-ca = trusted-ca-bytes=str | trusted-ca-id=str
        }
      },
      unhealthy-threshold = int
    }, ...
  ],
  keep-connections-on-host-health-failure = bool,
  load-balancing-config = {
    locality-aware-routing-percent = int,
    mode = ROUND_ROBIN|RANDOM|LEAST_REQUEST|MAGLEV_HASH,
    panic-threshold = int,
    strict-locality = bool
  },
  name = str,
  port = int,
  tls = {
    sni = str,
    validation-context = {
      trusted-ca = trusted-ca-bytes=str | trusted-ca-id=str
    }
  }
}
```

JSON Syntax:

```json
{
  "backend-type": {
    "target-groups": {
      "target-group-ids": [
        "str", ...
      ]
    }
  },
  "backend-weight": "int",
  "enable-proxy-protocol": "bool",
  "healthchecks": [
    {
      "healthcheck": {
        "grpc": {
          "service-name": "str"
        },
        "http": {
          "expected-statuses": [
            "int", ...
          ],
          "host": "str",
          "path": "str",
          "use-http2": "bool"
        },
        "stream": {
          "receive": {
            "payload": {
              "text": "str"
            }
          },
          "send": {
            "payload": {
              "text": "str"
            }
          }
        }
      },
      "healthcheck-port": "int",
      "healthy-threshold": "int",
      "interval": "duration",
      "interval-jitter-percent": "double",
      "timeout": "duration",
      "transport-settings": {
        "plaintext": {},
        "tls": {
          "sni": "str",
          "validation-context": {
            "trusted-ca": {
              "trusted-ca-bytes": "str",
              "trusted-ca-id": "str"
            }
          }
        }
      },
      "unhealthy-threshold": "int"
    }, ...
  ],
  "keep-connections-on-host-health-failure": "bool",
  "load-balancing-config": {
    "locality-aware-routing-percent": "int",
    "mode": "ROUND_ROBIN|RANDOM|LEAST_REQUEST|MAGLEV_HASH",
    "panic-threshold": "int",
    "strict-locality": "bool"
  },
  "name": "str",
  "port": "int",
  "tls": {
    "sni": "str",
    "validation-context": {
      "trusted-ca": {
        "trusted-ca-bytes": "str",
        "trusted-ca-id": "str"
      }
    }
  }
}
```

Fields:

```
backend-weight -> (int)
  Backend weight. Traffic is distributed between backends of a backend group according to their weights. Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. If the weight is non-positive, traffic is not sent to the backend.
enable-proxy-protocol -> (bool)
  If set, proxy protocol will be enabled for this backend.
healthchecks -> ([]struct)
  Health checks to perform on targets from target groups. For details about health checking, see documentation. If no health checks are specified, active health checking is not performed.
  healthcheck-port -> (int)
    Port used for health checks. If not specified, the backend port ([HttpBackend.port] or [GrpcBackend.port]) is used for health checks.
  healthy-threshold -> (int)
    Number of consecutive successful health checks required to mark an unhealthy target as healthy. Both '0' and '1' values amount to one successful check required. The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. Default value: '0'.
  interval -> (duration)
    Base interval between consecutive health checks.
  interval-jitter-percent -> (double)
  timeout -> (duration)
    Health check timeout. The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed.
  unhealthy-threshold -> (int)
    Number of consecutive failed health checks required to mark a healthy target as unhealthy. Both '0' and '1' values amount to one unsuccessful check required. The value is ignored if a health check is failed due to an HTTP '503 Service Unavailable' response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. Default value: '0'.
  healthcheck -> (oneof<grpc|http|stream>)
    Oneof healthcheck field
    stream -> (struct)
      TCP stream health check settings.
      receive -> (struct)
        Data that must be contained in the messages received from targets for a successful health check. If not specified, no messages are expected from targets, and those that are received are not checked.
        payload -> (oneof<text>)
          Oneof payload field
          text -> (string)
            Payload text.
      send -> (struct)
        Message sent to targets during TCP data transfer. If not specified, no data is sent to the target.
        payload -> (oneof<text>)
          Oneof payload field
          text -> (string)
            Payload text.
    http -> (struct)
      HTTP health check settings.
      expected-statuses -> ([]int)
        A list of HTTP response statuses considered healthy. By default only 200 HTTP status code considered healthy.
      host -> (string)
        Value for the HTTP/1.1 'Host' header or the HTTP/2 ':authority' pseudo-header used in requests to targets.
      path -> (string)
        HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 ':path' pseudo-header.
      use-http2 -> (bool)
        Enables HTTP/2 usage in health checks. Default value: 'false', HTTP/1.1 is used.
    grpc -> (struct)
      gRPC health check settings.
      service-name -> (string)
        Name of the gRPC service to be checked. If not specified, overall health is checked. For details about the concept, see GRPC Health Checking Protocol.
  transport-settings -> (oneof<plaintext|tls>)
    Oneof transport-settings field
    plaintext -> (struct)
    tls -> (struct)
      sni -> (string)
        SNI string for TLS connections.
      validation-context -> (struct)
        Validation context for backend TLS connections.
        trusted-ca -> (oneof<trusted-ca-bytes|trusted-ca-id>)
          Oneof trusted-ca field
          trusted-ca-id -> (string)
          trusted-ca-bytes -> (string)
            X.509 certificate contents in PEM format.
keep-connections-on-host-health-failure -> (bool)
  If a backend host becomes unhealthy (as determined by the configured health checks), keep connections to the failed host.
load-balancing-config -> (struct)
  Load balancing configuration for the backend.
  locality-aware-routing-percent -> (int)
    Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see documentation. If there are no healthy backends in an availability zone, all the traffic is divided between other zones. If [strict_locality] is 'true', the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. Default value: '0'.
  mode -> (struct)
    Load balancing mode for the backend. For details about load balancing modes, see documentation.
  panic-threshold -> (int)
    Threshold for panic mode. If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see documentation. If the value is '0', panic mode will never be activated and traffic is routed only to healthy backends at all times. Default value: '0'.
  strict-locality -> (bool)
    Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. If set to 'true' and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see documentation. If 'strict_locality' is 'true', the value specified in [locality_aware_routing_percent] is ignored. Default value: 'false'.
name -> (string)
  Name of the backend.
port -> (int)
  Port used by all targets to receive traffic.
tls -> (struct)
  Settings for TLS connections between load balancer nodes and backend targets. If specified, the load balancer establishes TLS-encrypted TCP connections with targets and compares received certificates with the one specified in [BackendTls.validation_context]. If not specified, the load balancer establishes unencrypted TCP connections with targets.
  sni -> (string)
    Server Name Indication (SNI) string for TLS connections.
  validation-context -> (struct)
    Validation context for TLS connections.
    trusted-ca -> (oneof<trusted-ca-bytes|trusted-ca-id>)
      Oneof trusted-ca field
      trusted-ca-id -> (string)
      trusted-ca-bytes -> (string)
        X.509 certificate contents in PEM format.
backend-type -> (oneof<target-groups>)
  Oneof backend-type field
  target-groups -> (struct)
    Target groups that belong to the backend. For details about target groups, see documentation.
    target-group-ids -> ([]string)
      List of ID's of target groups that belong to the backend. To get the ID's of all available target groups, make a [TargetGroupService.List] request.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#