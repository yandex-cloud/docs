[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > iOS > CloudVideoPlayer > Structs > PlayerStatus

# PlayerStatus

```swift
public enum PlayerStatus
```

Состояние плеера.

## Contents
- [Cases](#cases)

## Discussion

Подписаться на изменения состояния можно через `YaPlayer/playerStatusDidChange(queue:)`.

## Cases

| Case | Description |
|------|-------------|
| `idle` | Плеер простаивает — источник не установлен. |
| `fatal` | Воспроизведение невозможно из-за фатальной ошибки. |
| `preparing` | Контент еще не готов к воспроизведению. |
| `cancelled` | Трансляция или премьера отменена. |
| `finished` | Трансляция завершена и недоступна для просмотра. |
| `play` | Идет воспроизведение. |
| `pause` | Воспроизведение на паузе. |
| `buffering` | Буферизация — плеер ожидает данные для продолжения воспроизведения. |
| `end` | Воспроизведение завершено — достигнут конец контента. |

---