---
title: 'Environment: {{ video-full-name }} player SDK for iOS'
description: Creating players and configuring the environment and network requests in the {{ video-name }} player SDK for iOS.
---

# Environment

```swift
public struct Environment
```

An SDK environment is an entry point for creating players and managing the global configuration.

## Contents {#contents}

This page displays:

- [Properties](#properties)
- [Initializers](#initializers)
- [Methods](#methods)

## Description {#discussion}

Create a single `Environment` instance when running the application. Use it to get `YaPlayer` instances.

## Updating a configuration {#configuration-update}

You can update a configuration at any time without recreating the environment.

## Network headers {#network-headers}

Add global headers for all network request of the player.

## Properties {#properties}

#|
|| **Name** | **Type** | **Description** ||
|| `from` | `From` | Application ID from the current configuration. ||
|#

## Initializers {#initializers}

```swift
@available(*, deprecated, renamed: "init(configuration:)", message: "Use API with Configuration instead")
public init(from: From)
```

Creates an SDK environment.

Parameters:

- `from`: App ID.

---

```swift
public init(configuration: Configuration)
```

Creates an SDK environment with a specified configuration.

Parameters:

- `configuration`: SDK configuration with the application ID and an optional user information provider.

## Methods {#methods}

```swift
public mutating func update(configuration: Configuration)
```

Updates the SDK configuration without recreating the environment.

Parameters:

- `configuration`: New configuration.

---

```swift
public func setGlobalNetworkHeaders(_ headers: [String: String])
```

Sets HTTP headers added to all network requests of the player.

Parameters:

- `headers`: Header dictionary in `[name: value]` format.

---

```swift
public func setNetworkHeaders(for endpoint: ContentIdEndpoint, headers: [String: String])
```

Sets HTTP headers for specific content requests.

---

```swift
public static func set(telemetryEndpoint: QuasiEndpoint?)
```

Overrides the endpoint for sending telemetry.

Parameters:

- `telemetryEndpoint`: Custom endpoint or `nil` to restore the default value.

---

```swift
public static func set(perfEndpoint: QuasiEndpoint?)
```

Overrides the endpoint for sending performance data (perf events).

Parameters:

- `perfEndpoint`: Custom endpoint or `nil` to restore the default value.

---

```swift
public func player() -> YaPlayer
```

Creates a new player instance.

The return value is a new `YaPlayer` instance.

## Examples {#examples}

```swift
let configuration = Configuration(from: From(raw: "my-ios-app"))
var environment = Environment(configuration: configuration)

// ViewController.swift
let player = environment.player()
```

```swift
let newConfig = Configuration(from: From(raw: "my-ios-app"), clientInfoProvider: provider)
environment.update(configuration: newConfig)
```

```swift
environment.setGlobalNetworkHeaders(["Authorization": "Bearer \(token)"])
```

---
