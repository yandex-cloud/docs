# Interface: PlayerSdkState

[Состояние PlayerSdk](../../../sdk/javascript/player-state.md).

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

[Текущее время](../../../sdk/javascript/player-state.md#state-currentTime) на шкале времени видео.

### duration {#duration}

• **duration**: ``null`` \| `Seconds`

[Длительность](../../../sdk/javascript/player-state.md#state-duration) видео.

### error {#error}

• **error**: ``null`` \| `PublicIFrameApiErrorInterface`

Текущая [ошибка](../../../sdk/javascript/player-state.md#state-error).

### muted {#muted}

• **muted**: `boolean`

[Статус](../../../sdk/javascript/player-state.md#state-muted) `muted` (выключенного звука) видео.

### source {#source}

• **source**: ``null`` \| `string`

[Источник](../../../sdk/javascript/player-state.md#state-source) видео.

### status {#status}

• **status**: [`PlayerSdkStatus`](../enums/PlayerSdkStatus.md)

[Статус воспроизведения](../../../sdk/javascript/player-state.md#state-status).

### utcStartTime {#utcstarttime}

• **utcStartTime**: ``null`` \| `number`

[UTC-время начала видео](../../../sdk/javascript/player-state.md#state-utcStartTime).

### videoType {#videotype}

• **videoType**: ``null`` \| `VideoType`

[Тип видео](../../../sdk/javascript/player-state.md#state-videoType).

### volume {#volume}

• **volume**: `number`

[Уровень громкости](../../../sdk/javascript/player-state.md#state-volume) звука видео.