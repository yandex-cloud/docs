# Interface: PlayerSdkEventHandlers

[PlayerSdk event](../../../sdk/javascript/player-events.md) handlers

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

[Changing position](../../../sdk/javascript/player-events.md#currenttimechange) on the timeline (in seconds).

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

[Changing video duration](../../../sdk/javascript/player-events.md#durationchange) (in seconds).

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

Called when the [current error changes](../../../sdk/javascript/player-events.md#errorchange).

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

[Changing the `muted` status](../../../sdk/javascript/player-events.md#mutedchange) of a video.

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

[Changing the content source](../../../sdk/javascript/player-events.md#sourcechange).

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

[Changing the playback status](../../../sdk/javascript/player-events.md#StatusChange).

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

[Changing UTC video start time](../../../sdk/javascript/player-events.md#utcstarttimechange) (in seconds).

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

[Changing the video type](../../../sdk/javascript/player-events.md#videotypechange).

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

[Changing the sound volume level](../../../sdk/javascript/player-events.md#volumechange) in a video.

*Parameters*

| Name | Type |
| :------ | :------ |
| `arg` | `Object` |
| `arg.volume` | `number` |

*Returns*

`unknown`