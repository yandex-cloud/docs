# Interface: PlayerSdkApi

[Интерфейс PlayerSdk](../../../sdk/javascript/index.md).

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

[Уничтожает](../../../sdk/javascript/player-methods.md#destroy) (destroy) плеер и освобождает занимаемые им ресурсы.

*Returns*

`Promise`<`void`\>

Промис (promise), который переводится в состояние `fulfilled`, когда плеер удален.

### getState {#getstate}

▸ **getState**(): [`PlayerSdkState`](PlayerSdkState.md)

[Возвращает состояние](../../../sdk/javascript/player-methods.md#getstate) PlayerSdk.

*Returns*

[`PlayerSdkState`](PlayerSdkState.md)

### off {#off}

▸ **off**<`EventName`\>(`eventName`, `handler`): `void`

[Отписывает](../../../sdk/javascript/player-methods.md#off) от события плеера.

*Type parameters*

| Name | Type |
| :------ | :------ |
| `EventName` | extends [`PlayerSdkEvents`](../enums/PlayerSdkEvents.md) |

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `eventName` | `EventName` | имя события |
| `handler` | [`PlayerSdkEventHandlers`](PlayerSdkEventHandlers.md)[`EventName`] | обработчик события |

*Returns*

`void`

### on {#on}

▸ **on**<`EventName`\>(`eventName`, `handler`): `void`

[Подписывает](../../../sdk/javascript/player-methods.md#subscribe-methods) на событие плеера.

*Type parameters*

| Name | Type |
| :------ | :------ |
| `EventName` | extends [`PlayerSdkEvents`](../enums/PlayerSdkEvents.md) |

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `eventName` | `EventName` | имя события |
| `handler` | [`PlayerSdkEventHandlers`](PlayerSdkEventHandlers.md)[`EventName`] | обработчик события |

*Returns*

`void`

### once {#once}

▸ **once**<`EventName`\>(`eventName`, `handler`): `void`

[Подписывает](../../../sdk/javascript/player-methods.md#subscribe-methods) на однократное срабатывание события плеера.

*Type parameters*

| Name | Type |
| :------ | :------ |
| `EventName` | extends [`PlayerSdkEvents`](../enums/PlayerSdkEvents.md) |

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `eventName` | `EventName` | имя события |
| `handler` | [`PlayerSdkEventHandlers`](PlayerSdkEventHandlers.md)[`EventName`] | обработчик события |

*Returns*

`void`

### pause {#pause}

▸ **pause**(): `void`

[Ставит воспроизведение на паузу](../../../sdk/javascript/player-methods.md#pause).

*Returns*

`void`

### play {#play}

▸ **play**(): `Promise`<`void`\>

[Запускает воспроизведение](../../../sdk/javascript/player-methods.md#play) видео.

*Returns*

`Promise`<`void`\>

Промис (promise), который переводится в состояние `fulfilled`, когда видео начинает воспроизводиться.

### seek {#seek}

▸ **seek**(`time`): `void`

[Перематывает](../../../sdk/javascript/player-methods.md#seek) видео в заданную позицию.

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `time` | `Seconds` | время в секундах |

*Returns*

`void`

### setMuted {#setmuted}

▸ **setMuted**(`muted`): `void`

[Выключает/включает звук](../../../sdk/javascript/player-methods.md#setmuted) в видео.

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `muted` | `boolean` | true, если нужно выключить звук, и false — если нужно включить звук |

*Returns*

`void`

### setSource {#setsource}

▸ **setSource**(`sourceConfig`): `Promise`<`void`\>

[Задает источник](../../../sdk/javascript/player-methods.md#setsource) видео.

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `sourceConfig` | [`PlayerSdkSourceConfig`](../modules.md#playersdksourceconfig) | источник видео, на который нужно переключиться, и параметры |

*Returns*

`Promise`<`void`\>

Промис (promise), который переводится в состояние `fulfilled`, когда освобождаются основные ресурсы.

### setVolume {#setvolume}

▸ **setVolume**(`volume`): `void`

[Устанавливает уровень громкости](../../../sdk/javascript/player-methods.md#setvolume) звука в видео.

*Parameters*

| Name | Type | Description |
| :------ | :------ | :------ |
| `volume` | `Volume` | громкость видео от `0` (звук не слышен) до `1` (максимальная громкость) |

*Returns*

`void`