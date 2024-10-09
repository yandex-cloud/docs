# JS SDK Reference

Video player

### Enumerations {#enumerations}

- [PlayerSdkEvents](enums/PlayerSdkEvents.md)
- [PlayerSdkStatus](enums/PlayerSdkStatus.md)

### Interfaces {#interfaces}

- [PlayerSdkApi](interfaces/PlayerSdkApi.md)
- [PlayerSdkEventHandlers](interfaces/PlayerSdkEventHandlers.md)
- [PlayerSdkInitConfig](interfaces/PlayerSdkInitConfig.md)
- [PlayerSdkSourceParams](interfaces/PlayerSdkSourceParams.md)
- [PlayerSdkState](interfaces/PlayerSdkState.md)

### Type Aliases {#type-aliases}

* Ƭ **PlayerSdkGlobalObject**: typeof `window` & { `Ya`: { `playerSdk`: { `init`: (`config`: [`PlayerSdkInitConfig`](interfaces/PlayerSdkInitConfig.md)) => [`PlayerSdkApi`](interfaces/PlayerSdkApi.md)  }  }  }

* Ƭ **PlayerSdkSourceConfig**: `string` \| `PlayerSdkSourceObjectConfig`

    Video source updating parameters