[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > iOS > CloudVideoPlayer > Structs > ContentIdEndpoint

# ContentIdEndpoint

```swift
public struct ContentIdEndpoint: Equatable
```

Эндпоинт для получения метаданных контента по URL.

## Contents
- [Initializers](#initializers)

## Discussion

Рекомендуемый способ указания источника воспроизведения.

## Inheritance

- `Equatable`

## Initializers

```swift
public init?(url: URL)
```

Создает эндпоинт контента из URL.

**Parameters:**

- `url`: URL страницы или API плеера

Инициализатор возвращает `nil`, если URL нельзя разобрать.

## Examples

```swift
guard let endpoint = ContentIdEndpoint(url: URL(string: "https://runtime.video.cloud.yandex.net/player/video/abc123")!) else {
  return
}
player.set(source: endpoint)
```

---