---
title: 'QuasiEndpoint: {{ video-full-name }} player SDK for iOS'
description: Configuring HTTP endpoints for sending telemetry to the {{ video-name }} player SDK for iOS.
---

# QuasiEndpoint

```swift
public struct QuasiEndpoint
```

HTTP endpoint for sending telemetry and performance data (perf events).

## Contents {#contents}

This page displays:

- [Initializers](#initializers)

## Description {#discussion}

Used in the `set(telemetryEndpoint:)` and `set(perfEndpoint:)` methods of the [Environment](./Environment.md#methods) structure for replacing standard endpoints with custom ones.

## Initializers {#initializers}

```swift
public init(
  url: URL,
  httpMethod: String = "POST",
  httpHeaders: [String: String] = ["Content-Type": "application/json"]
)
```

It creates an HTTP endpoint.

## Examples {#examples}

```swift
let endpoint = QuasiEndpoint(url: URL(string: "https://my-telemetry.example.com/log")!)
Environment.set(telemetryEndpoint: endpoint)

let perfEndpoint = QuasiEndpoint(url: URL(string: "https://my-telemetry.example.com/perf")!)
Environment.set(perfEndpoint: perfEndpoint)
```

---
