# Time

```swift
public struct Time
```

Timestamp within a media stream.

## Contents

- [Initializers](#initializers)

## Discussion

Used to set playback position, duration representation, and buffering ranges. Supports arithmetic operations and comparisons.

## Initializers

```swift
public init(sec time: TimeInterval)
```

Creates a timestamp from a value in seconds.

**Parameters:**

- `time`: Time in seconds

---

```swift
public init(ms time: Int64)
```

Creates a timestamp from a value in milliseconds.

**Parameters:**

- `time`: Time in milliseconds

## Examples

```swift
let startTime = Time(sec: 30)
let offset = Time(ms: 500)
let result = startTime + offset

await player.seek(to: startTime)
```

---
