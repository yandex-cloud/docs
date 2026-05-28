# PlayerStatus

```swift
public enum PlayerStatus
```

Player state.

## Contents
- [Cases](#cases)

## Discussion

You can subscribe to status changes via `YaPlayer/playerStatusDidChange(queue:)`.

## Cases

| Case | Description |
|------|-------------|
| `idle` | The player is idle. The source is not set. |
| `fatal` | Playback is not possible due to a fatal error. |
| `preparing` | Content is not ready for playback yet. |
| `cancelled` | The broadcast or premiere was canceled. |
| `finished` | The broadcast ended and is unavailable for viewing. |
| `play` | Playback is in progress. |
| `pause` | Playback is paused. |
| `buffering` | Buffering: the player is awaiting data to continue playback. |
| `end` | Playback ended: the end of content was reached. |

---
