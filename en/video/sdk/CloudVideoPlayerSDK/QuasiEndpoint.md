# QuasiEndpoint

```swift
public struct QuasiEndpoint
```

HTTP endpoint for overriding the telemetry destination address.

## Contents
- [Initializers](#initializers)

## Discussion

It is used in `Environment/set(telemetryEndpoint:)` to replace the default telemetry endpoint with a custom one.

## Initializers

```swift
public init(
url: URL,
httpMethod: String = "POST",
httpHeaders: [String: String] = ["Content-Type": "application/json"]
)
```

It creates an HTTP endpoint.

## Examples

```swift
let endpoint = QuasiEndpoint(url: URL(string: "https://my-telemetry.example.com/log")!)
Environment.set(telemetryEndpoint: endpoint)
```

---
