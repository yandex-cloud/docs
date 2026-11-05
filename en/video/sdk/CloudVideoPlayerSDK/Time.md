---
title: 'Time: {{ video-full-name }} player SDK for iOS'
description: Working with time and playback position in the {{ video-name }} player SDK for iOS.
---

# Time

```swift
public struct Time
```

Timestamp within a media stream.

## Contents {#contents}

This page displays:

- [Properties](#properties)
- [Initializers](#initializers)
- [Methods](#methods)

## Description {#discussion}

Used to set playback position, duration representation, and buffering ranges. Supports arithmetic operations and comparisons.

## Protocol match {#inheritance}

The structure matches the `AdditiveArithmetic` and `Comparable` protocols.

## Properties {#properties}

#|
|| **Name** | **Type** | **Description** ||
|| `timeInterval` | `TimeInterval` | Value in seconds in `TimeInterval` format. ||
|| `zero` | `Time` | Zero time position. ||
|#

## Initializers {#initializers}

```swift
public init(sec time: TimeInterval)
```

Creates a timestamp from a value in seconds.

Parameters:

- `time`: Time in seconds.

---

```swift
public init(ms time: Int64)
```

Creates a timestamp from a value in milliseconds.

Parameters:

- `time`: Time in milliseconds.

## Methods {#methods}

```swift
public static func - (lhs: Time, rhs: Time) -> Time
```

Deducts one time value from another.

---

```swift
public static func + (lhs: Time, rhs: Time) -> Time
```

Sums two time values.

## Examples {#examples}

```swift
let startTime = Time(sec: 30)
let offset = Time(ms: 500)
let result = startTime + offset

await player.seek(to: startTime)
```

---
