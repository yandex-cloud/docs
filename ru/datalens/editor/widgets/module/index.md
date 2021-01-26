# Модуль

* [Общая информация](#about)
* [JavaScript](#javascript)
* [Документирование](#docs)
* [Использование](#usage)
* [Версионирование](#versioning)
* [Примеры](#examples)

## Общая информация {#about}

Модуль - это фрагмент кода, который экпортирует определенные объекты/функции/переменные/константы, которые затем можно использовать в скриптах.

{% include [include](../../../../_includes/datalens/internal/editor/widgets/module/javascript.md) %}

{% include [include](../../../../_includes/datalens/internal/editor/widgets/module/docs.md) %}

{% include [include](../../../../_includes/datalens/internal/editor/widgets/module/usage.md) %}

## Версионирование {#versioning}

Подробнее можно узнать в [соответствующем разделе](../../versioning.md).

Сохраненную версию модуля можно подключить следующим образом:

```js
const myUnreleasedModule = require('my/module@saved');
```

{% include [include](../../../../_includes/datalens/internal/editor/widgets/module/examples.md) %}
