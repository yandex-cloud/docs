# Enumeration: PlayerSdkStatus

[Статус воспроизведения](../../../sdk/javascript/player-state.md#status-desc).

## Enumeration Members {#Enumeration-Members}

- [broken](#broken)
- [buffering](#buffering)
- [cancelled](#cancelled)
- [destroyed](#destroyed)
- [end](#end)
- [fatal](#fatal)
- [finished](#finished)
- [idle](#idle)
- [init](#init)
- [pause](#pause)
- [play](#play)
- [preparing](#preparing)

### broken {#broken}

• **broken** = `"broken"`

Плеер сломан, воспроизведение видео невозможно, у пользователя отображается экран с ошибкой. Переключение на другой контент невозможно.

### buffering {#buffering}

• **buffering** = `"buffering"`

Плеер находится в состоянии буферизации и не может воспроизводить видео (например, из-за нехватки данных).

### cancelled {#cancelled}

• **cancelled** = `"cancelled"`

Трансляция видео была отменена.

### destroyed {#destroyed}

• **destroyed** = `"destroyed"`

Был вызван метод `destroy`, плеер уничтожен (destroyed) и не может больше воспроизводить видео.

### end {#end}

• **end** = `"end"`

Воспроизведение текущего видео завершилось на правой границе шкалы времени. 

### fatal {#fatal}

• **fatal** = `"fatal"`

Воспроизведение текущего видео невозможно, у пользователя отображается экран с ошибкой. Чтобы запустить видео, пользователь может попробовать переключиться на другой контент.

### finished {#finished}

• **finished** = `"finished"`

Трансляция видео завершена.

### idle {#idle}

• **idle** = `"idle"`

Плеер ожидает задания контента для воспроизведения.

### init {#init}

• **init** = `"init"`

Инициализация плеера при задании первого контента для воспроизведения.

### pause {#pause}

• **pause** = `"pause"`

Плеер находится на паузе.

### play {#play}

• **play** = `"play"`

В текущий момент плеер воспроизводит видео.

### preparing {#preparing}

• **preparing** = `"preparing"`

Через некоторое время должна начаться трансляция видео.