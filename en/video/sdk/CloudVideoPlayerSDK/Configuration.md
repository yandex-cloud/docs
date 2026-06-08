# Configuration

## Contents

- [ClientInfoProvider](#clientinfoprovider)
- [Configuration](#configuration)

---

## ClientInfoProvider

```swift
public protocol ClientInfoProvider
```

Protocol for transmission of user information to the SDK.

### Discussion

Implement this protocol to provide user ID to the telemetry.

### Methods

```swift
func userId() -> ClientUserId?
```

Returns current user ID or `nil` if user unknown.

### Examples

```swift
struct MyClientInfoProvider: ClientInfoProvider {
  func userId() -> ClientUserId? {
    // Return your app's current user ID
    return ClientUserId(raw: currentUserId)
  }
}
```

---

## Configuration

```swift
public struct Configuration
```

SDK configuration.

### Discussion

Provided when creating `Environment`. Contains the required application ID and an optional user information provider.

### Initializers

```swift
public init(from: From, clientInfoProvider: ClientInfoProvider? = nil)
```

Creates an SDK configuration.

### Examples

```swift
let config = Configuration(
  from: From(raw: "my-ios-app"),
  clientInfoProvider: MyClientInfoProvider()
)
let environment = Environment(configuration: config)
```

---
