# ContentIdEndpoint

```swift
public struct ContentIdEndpoint: Equatable
```

Endpoint for getting content metadata by URL.

## Contents

- [Initializers](#initializers)

## Discussion

Recommended method to specify the playback source.

## Inheritance

- `Equatable`

## Initializers

```swift
public init?(url: URL)
```

It creates a content endpoint from a URL.

**Parameters**:

- `url`: Page URL or player API

The initializer returns `nil` if the URL cannot be parsed.

## Examples

```swift
guard let endpoint = ContentIdEndpoint(url: URL(string: "https://runtime.video.cloud.yandex.net/player/video/abc123")!) else {
  return
}
player.set(source: endpoint)
```

---
