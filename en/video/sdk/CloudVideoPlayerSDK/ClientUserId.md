# ClientUserId

```swift
public struct ClientUserId
```

User ID specified by the client service. It is used to track the user in telemetry, e.g., to implement a viewer counter.

## Contents

- [Properties](#properties)
- [Initializers](#initializers)

## Discussion

Provided via `ClientInfoProvider/userId()` as part of `Configuration`.

## Properties

| Name | Type | Description |
|------|------|-------------|
| `raw` | `String` | User string ID. |

## Initializers

```swift
public init(raw: String)
```

Creates a user ID.

**Parameters**:

- `raw`: User string ID.

---
