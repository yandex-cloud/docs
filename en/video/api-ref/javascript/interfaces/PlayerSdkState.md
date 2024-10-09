# Interface: PlayerSdkState

[PlayerSdk state](../../../sdk/javascript/player-state.md).

## Properties

- [currentTime](#currenttime)
- [duration](#duration)
- [error](#error)
- [muted](#muted)
- [source](#source)
- [status](#status)
- [utcStartTime](#utcstarttime)
- [videoType](#videotype)
- [volume](#volume)

### currentTime {#currenttime}

• **currentTime**: ``null`` \| `Seconds`

[Current time](../../../sdk/javascript/player-state.md#state-currentTime) on the video timeline.

### duration {#duration}

• **duration**: ``null`` \| `Seconds`

Video [duration](../../../sdk/javascript/player-state.md#state-duration).

### error {#error}

• **error**: ``null`` \| `PublicIFrameApiErrorInterface`

Current [error](../../../sdk/javascript/player-state.md#state-error).

### muted {#muted}

• **muted**: `boolean`

Video `muted` [status](../../../sdk/javascript/player-state.md#state-muted).

### source {#source}

• **source**: ``null`` \| `string`

Video [source](../../../sdk/javascript/player-state.md#state-source).

### status {#status}

• **status**: [`PlayerSdkStatus`](../enums/PlayerSdkStatus.md)

[Playback status](../../../sdk/javascript/player-state.md#state-status).

### utcStartTime {#utcstarttime}

• **utcStartTime**: ``null`` \| `number`

[Video start time in UTC](../../../sdk/javascript/player-state.md#state-utcStartTime).

### videoType {#videotype}

• **videoType**: ``null`` \| `VideoType`

[Video type](../../../sdk/javascript/player-state.md#state-videoType).

### volume {#volume}

• **volume**: `number`

[Sound volume level](../../../sdk/javascript/player-state.md#state-volume) of a video.