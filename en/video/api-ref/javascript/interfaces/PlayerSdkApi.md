# Interface: PlayerSdkApi

[PlayerSdk interface](../../../sdk/javascript/index.md).

## Methods {#Methods}

- [destroy](#destroy)
- [getState](#getstate)
- [off](#off)
- [on](#on)
- [once](#once)
- [pause](#pause)
- [play](#play)
- [seek](#seek)
- [setMuted](#setmuted)
- [setSource](#setsource)
- [setVolume](#setvolume)

### destroy {#destroy}

▸ **destroy**(): `Promise`<`void`\>

[Destroys](../../../sdk/javascript/player-methods.md#destroy) the player and frees up the resources it uses.

*Returns*

`Promise`<`void`\>

Promise that switches to the `fulfilled` state once the player is deleted.

### getState {#getstate}

▸ **getState**(): [`PlayerSdkState`](PlayerSdkState.md)

[Returns the state](../../../sdk/javascript/player-methods.md#getstate) of PlayerSdk.

*Returns*

[`PlayerSdkState`](PlayerSdkState.md)

### off {#off}

▸ **off**<`EventName`\>(`eventName`, `handler`): `void`

[Unsubscribes](../../../sdk/javascript/player-methods.md#off) from a player event.

*Type parameters*

| Name | Type |
| :------ | :------ |
| `EventName` | extends [`PlayerSdkEvents`](../enums/PlayerSdkEvents.md) |

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `eventName` | `EventName` | Event name |
| `handler` | [`PlayerSdkEventHandlers`](PlayerSdkEventHandlers.md)[`EventName`] | Event handler |

*Returns*

`void`

### on {#on}

▸ **on**<`EventName`\>(`eventName`, `handler`): `void`

[Subscribes](../../../sdk/javascript/player-methods.md#subscribe-methods) to a player event.

*Type parameters*

| Name | Type |
| :------ | :------ |
| `EventName` | extends [`PlayerSdkEvents`](../enums/PlayerSdkEvents.md) |

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `eventName` | `EventName` | Event name |
| `handler` | [`PlayerSdkEventHandlers`](PlayerSdkEventHandlers.md)[`EventName`] | Event handler |

*Returns*

`void`

### once {#once}

▸ **once**<`EventName`\>(`eventName`, `handler`): `void`

[Subscribes](../../../sdk/javascript/player-methods.md#subscribe-methods) to a single-time triggering of a player event.

*Type parameters*

| Name | Type |
| :------ | :------ |
| `EventName` | extends [`PlayerSdkEvents`](../enums/PlayerSdkEvents.md) |

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `eventName` | `EventName` | Event name |
| `handler` | [`PlayerSdkEventHandlers`](PlayerSdkEventHandlers.md)[`EventName`] | Event handler |

*Returns*

`void`

### pause {#pause}

▸ **pause**(): `void`

[Pauses playback](../../../sdk/javascript/player-methods.md#pause).

*Returns*

`void`

### play {#play}

▸ **play**(): `Promise`<`void`\>

[Starts video playback](../../../sdk/javascript/player-methods.md#play).

*Returns*

`Promise`<`void`\>

Promise that switches to the `fulfilled` state once the video playback starts.

### seek {#seek}

▸ **seek**(`time`): `void`

[Rewinds or fast forward](../../../sdk/javascript/player-methods.md#seek) a video to a specific position.

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `time` | `Seconds` | Time in seconds |

*Returns*

`void`

### setMuted {#setmuted}

▸ **setMuted**(`muted`): `void`

[Mutes/unmutes](../../../sdk/javascript/player-methods.md#setmuted) a video.

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `muted` | `boolean` | True to mute, false to unmute |

*Returns*

`void`

### setSource {#setsource}

▸ **setSource**(`sourceConfig`): `Promise`<`void`\>

[Sets the video source](../../../sdk/javascript/player-methods.md#setsource).

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `sourceConfig` | [`PlayerSdkSourceConfig`](../modules.md#playersdksourceconfig) | Video source to switch to and its parameters |

*Returns*

`Promise`<`void`\>

Promise that switches to the `fulfilled` state once the main player resources are freed up.

### setVolume {#setvolume}

▸ **setVolume**(`volume`): `void`

[Sets the sound volume](../../../sdk/javascript/player-methods.md#setvolume) of a video.

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `volume` | `Volume` | Video volume from `0` (muted) to `1` (maximum volume) |

*Returns*

`void`