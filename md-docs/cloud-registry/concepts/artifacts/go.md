[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Концепции](../index.md) > [Артефакты](index.md) > Go-артефакт

# Go-артефакт

_Go-артефакт_ — это [ZIP-архив](https://go.dev/ref/mod#zip-files), содержащий исходный код [модуля](https://go.dev/ref/mod) на языке программирования [Go](https://ru.wikipedia.org/wiki/Go) с фиксированной версией. [Артефакты](index.md) используются для распространения библиотек и других компонентов, которые можно включить в проекты на Go.

## Go Modules {#go-modules-inf}

[Go Modules](https://go.dev/ref/mod) — стандартная система управления зависимостями в языке Go, входящая в стандартную поставку и доступная через команду `go`. Модуль описывается файлом `go.mod` в корне проекта.

Подробнее о Go-модулях читайте в [официальной документации](https://go.dev/ref/mod).

#### Полезные ссылки {#see-also}

* [Поддерживаемые типы артефактов](index.md#artifacts)
* [Скачать Go-модуль из реестра Cloud Registry](../../operations/go/pull.md)
* [Загрузить Go-модуль в реестр](../../operations/go/push.md)
* [Реестр в Yandex Cloud Registry](../registry.md)