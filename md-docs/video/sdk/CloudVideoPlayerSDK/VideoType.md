[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > iOS > CloudVideoPlayer > Structs > VideoType

# VideoType

```swift
public enum VideoType: String
```

Тип видеоконтента.

## Contents
- [Cases](#cases)

## Discussion

Определяет режим воспроизведения и доступные возможности плеера. Актуальное значение доступно через `YaPlayer/videoType`.

## Inheritance

- `String`

## Cases

| Case | Description |
|------|-------------|
| `vod` | Видео по запросу |
| `live` | Прямая трансляция |
| `event` | Событийная трансляция |
| `unknown` | Тип контента не определен |

---