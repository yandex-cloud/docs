# Environment

```swift
public struct Environment
```

An SDK environment is an entry point for creating players and managing the global configuration.

## Contents

- [Properties](#properties)
- [Methods](#methods)
- [Initializers](#initializers)

## Discussion

Create a single `Environment` instance when running the application. Use it to get `YaPlayer` instances.

## Updating a configuration

You can update a configuration at any time without recreating the environment.

## Network headers

Add global headers for all network request of the player.

## Properties

| Name | Type | Description |
|------|------|-------------|
| `from` | `From` | Application ID from the current configuration. |

## Initializers

```swift
@available(*, deprecated, renamed: "init(configuration:)", message: "Use API with Configuration instead")
public init(from: From)
```

Creates an SDK environment.

**Parameters:**

- `from`: Application ID.

---

```swift
public init(configuration: Configuration)
```

Creates an SDK environment with a specified configuration.

**Parameters:**

- `configuration`: SDK configuration with the applicationID and an optional user information provider.

## Methods

```swift
public mutating func update(configuration: Configuration)
```

Updates the SDK configuration without recreating the environment.

**Parameters:**

- `configuration`: This is a new configuration.

---

```swift
public func setGlobalNetworkHeaders(_ headers: [String: String])
```

Sets HTTP headers added to all network requests of the player.

**Parameters:**

- `headers`: Header dictionary in `[name: value]` format.

---

```swift
public func setNetworkHeaders(for contentId: ContentId, headers: [String: String])
```

Sets HTTP headers for specific content requests.

## Examples

```swift
let configuration = Configuration(from: From(raw: "my-ios-app"))
let environment = Environment(configuration: configuration)

// ViewController.swift
let player = environment.player()
```

```swift
var newConfig = Configuration(from: From(raw: "my-ios-app"), clientInfoProvider: provider)
environment.update(configuration: newConfig)
```

```swift
environment.setGlobalNetworkHeaders(["Authorization": "Bearer \(token)"])
```

---
