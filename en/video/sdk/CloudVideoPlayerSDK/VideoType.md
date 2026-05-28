# VideoType

```swift
public enum VideoType: String
```

Type of video content.

## Contents

- [Cases](#cases)

## Discussion

Determines the playback mode and available player features. The current value is available via `YaPlayer/videoType`.

## Inheritance

- `String`

## Cases

| Case | Description |
|------|-------------|
| `vod` | On-request video |
| `live` | Live broadcast |
| `event` | Event broadcast |
| `unknown` | Content type not defined |

---
