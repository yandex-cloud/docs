# From

```swift
public struct From
```

ID of an application utilizing the SDK.

## Contents
- [Properties](#properties)
- [Initializers](#initializers)

## Discussion

Provided when `Configuration` is created and used in telemetry to identify the service.

## Properties

| Name | Type | Description |
|------|------|-------------|
| `raw` | `String` | App's string ID. |

## Initializers

```swift
public init(raw: String)
```

Creates the app ID.

**Parameters:**

- `raw`: String ID. We recommend using
  a unique service name, e.g., `"weather-app"`.

## Examples

```swift
let from = From(raw: "my-ios-app")
let config = Configuration(from: from)
```

---
