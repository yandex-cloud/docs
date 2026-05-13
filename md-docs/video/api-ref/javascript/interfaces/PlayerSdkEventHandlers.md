# Interface: PlayerSdkEventHandlers

Обработчики [событий PlayerSdk](../../../sdk/javascript/player-events.md).

## Properties {#Properties}

- [CurrentTimeChange](#currenttimechange)
- [DurationChange](#durationchange)
- [ErrorChange](#errorchange)
- [MutedChange](#mutedchange)
- [SourceChange](#sourcechange)
- [StatusChange](#statuschange)
- [UtcStartTimeChange](#utcstarttimechange)
- [VideoTypeChange](#videotypechange)
- [VolumeChange](#volumechange)

### CurrentTimeChange {#currenttimechange}

• **CurrentTimeChange**: (`arg`: { `currentTime`: ``null`` \| `Seconds`  }) => `unknown`

*Type declaration*

▸ (`arg`): `unknown`

[Изменение позиции](../../../sdk/javascript/player-events.md#currenttimechange) на шкале времени (в секундах).

*Parameters*

| Name | Type |
| :------ | :------ |
| `arg` | `Object` |
| `arg.currentTime` | ``null`` \| `Seconds` |

*Returns*

`unknown`

### DurationChange {#durationchange}

• **DurationChange**: (`arg`: { `duration`: ``null`` \| `Seconds`  }) => `unknown`

*Type declaration*

▸ (`arg`): `unknown`

[Изменение длительности](../../../sdk/javascript/player-events.md#durationchange) видео (в секундах).

*Parameters*

| Name | Type |
| :------ | :------ |
| `arg` | `Object` |
| `arg.duration` | ``null`` \| `Seconds` |

*Returns*

`unknown`

### ErrorChange {#errorchange}

• **ErrorChange**: (`arg`: { `error`: ``null`` \| `PublicIFrameApiErrorInterface`  }) => `unknown`

*Type declaration*

▸ (`arg`): `unknown`

Вызывается при [изменении текущей ошибки](../../../sdk/javascript/player-events.md#errorchange).

*Parameters*

| Name | Type |
| :------ | :------ |
| `arg` | `Object` |
| `arg.error` | ``null`` \| `PublicIFrameApiErrorInterface` |

*Returns*

`unknown`

### MutedChange {#mutedchange}

• **MutedChange**: (`arg`: { `muted`: `boolean`  }) => `unknown`

*Type declaration*

▸ (`arg`): `unknown`

[Изменение статуса](../../../sdk/javascript/player-events.md#mutedchange) `muted` (выключенного звука) видео.

*Parameters*

| Name | Type |
| :------ | :------ |
| `arg` | `Object` |
| `arg.muted` | `boolean` |

*Returns*

`unknown`

### SourceChange {#sourcechange}

• **SourceChange**: (`arg`: { `source`: ``null`` \| `string`  }) => `unknown`

*Type declaration*

▸ (`arg`): `unknown`

[Изменение источника](../../../sdk/javascript/player-events.md#sourcechange) контента.

*Parameters*

| Name | Type |
| :------ | :------ |
| `arg` | `Object` |
| `arg.source` | ``null`` \| `string` |

*Returns*

`unknown`

### StatusChange {#statuschange}

• **StatusChange**: (`arg`: { `status`: [`PlayerSdkStatus`](../enums/PlayerSdkStatus.md)  }) => `unknown`

*Type declaration*

▸ (`arg`): `unknown`

[Изменение статуса воспроизведения](../../../sdk/javascript/player-events.md#StatusChange).

*Parameters*

| Name | Type |
| :------ | :------ |
| `arg` | `Object` |
| `arg.status` | [`PlayerSdkStatus`](../enums/PlayerSdkStatus.md) |

*Returns*

`unknown`

### UtcStartTimeChange {#utcstarttimechange}

• **UtcStartTimeChange**: (`arg`: { `utcStartTime`: ``null`` \| `number`  }) => `unknown`

*Type declaration*

▸ (`arg`): `unknown`

[Изменение UTC-времени начала видео](../../../sdk/javascript/player-events.md#utcstarttimechange) (в секундах).

*Parameters*

| Name | Type |
| :------ | :------ |
| `arg` | `Object` |
| `arg.utcStartTime` | ``null`` \| `number` |

*Returns*

`unknown`

### VideoTypeChange {#videotypechange}

• **VideoTypeChange**: (`arg`: { `videoType`: ``null`` \| `VideoType`  }) => `unknown`

*Type declaration*

▸ (`arg`): `unknown`

[Изменение типа](../../../sdk/javascript/player-events.md#videotypechange) видео.

*Parameters*

| Name | Type |
| :------ | :------ |
| `arg` | `Object` |
| `arg.videoType` | ``null`` \| `VideoType` |

*Returns*

`unknown`

### VolumeChange {#volumechange}

• **VolumeChange**: (`arg`: { `volume`: `number`  }) => `unknown`

*Type declaration*

▸ (`arg`): `unknown`

[Изменение уровня громкости](../../../sdk/javascript/player-events.md#volumechange) звука в видео.

*Parameters*

| Name | Type |
| :------ | :------ |
| `arg` | `Object` |
| `arg.volume` | `number` |

*Returns*

`unknown`