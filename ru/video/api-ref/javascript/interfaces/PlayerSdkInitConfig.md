# Interface: PlayerSdkInitConfig

[Параметры инициализации](../../../sdk/javascript/initialization.md) PlayerSdk.

## Hierarchy {#Hierarchy}

- [`PlayerSdkSourceParams`](PlayerSdkSourceParams.md)

  ↳ **`PlayerSdkInitConfig`**

## Properties {#Properties}

- [autoplay](#autoplay)
- [element](#element)
- [muted](#muted)
- [source](#source)
- [startPosition](#startposition)
- [volume](#volume)

### autoplay {#autoplay}

• `Optional` **autoplay**: `boolean`

Определяет, нужно ли запускать воспроизведение видео [автоматически](../../../sdk/javascript/initialization.md#autoplay).

*Inherited from*

[PlayerSdkSourceParams](PlayerSdkSourceParams.md).[autoplay](PlayerSdkSourceParams.md#autoplay)

### element {#element}

• **element**: `string` \| `HTMLElement`

Строка, содержащая id [элемента](../../../sdk/javascript/initialization.md#element), либо сам элемент, в который будет вставлен плеер.

### muted {#muted}

• `Optional` **muted**: `boolean`

[Статус](../../../sdk/javascript/initialization.md#muted) `muted` (выключенного звука) видео.

### source {#source}

• `Optional` **source**: `string`

[Источник](../../../sdk/javascript/initialization.md#source) видео.

### startPosition {#startposition}

• `Optional` **startPosition**: `Seconds`

[Стартовая позиция](../../../sdk/javascript/initialization.md#startposition) воспроизведения контента (в секундах).

*Inherited from*

[PlayerSdkSourceParams](PlayerSdkSourceParams.md).[startPosition](PlayerSdkSourceParams.md#startposition)

### volume {#volume}

• `Optional` **volume**: `number`

[Уровень громкости](../../../sdk/javascript/initialization.md#volume) звука в видео.