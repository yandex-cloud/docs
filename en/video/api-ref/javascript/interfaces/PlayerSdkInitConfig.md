# Interface: PlayerSdkInitConfig

PlayerSdk [initialization parameters](../../../sdk/javascript/initialization.md)

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

Indicates whether to start video playback [automatically](../../../sdk/javascript/initialization.md#autoplay).

*Inherited from*

[PlayerSdkSourceParams](PlayerSdkSourceParams.md).[autoplay](PlayerSdkSourceParams.md#autoplay)

### element {#element}

• **element**: `string` \| `HTMLElement`

String containing the ID of the [element](../../../sdk/javascript/initialization.md#element) or the element itself to embed the player in.

### muted {#muted}

• `Optional` **muted**: `boolean`

[`muted` status](../../../sdk/javascript/initialization.md#muted) of a video.

### source {#source}

• `Optional` **source**: `string`

Video [source](../../../sdk/javascript/initialization.md#source).

### startPosition {#startposition}

• `Optional` **startPosition**: `Seconds`

[Start position](../../../sdk/javascript/initialization.md#startposition) of content playback (in seconds).

*Inherited from*

[PlayerSdkSourceParams](PlayerSdkSourceParams.md).[startPosition](PlayerSdkSourceParams.md#startposition)

### volume {#volume}

• `Optional` **volume**: `number`

[Sound volume level](../../../sdk/javascript/initialization.md#volume) of a video.