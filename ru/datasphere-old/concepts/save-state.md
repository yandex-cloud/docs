# Сохранение состояния

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

Состояние ноутбука — это код ячеек, вывод и значения переменных в определенный момент времени, а также данные хранилища проекта. 

{% include [include](../../_includes/datasphere/saving-variables-warn.md) %}

Состояния сохраняются в виде контрольных точек. Подробнее о работе с ними читайте в разделе [{#T}](../operations/projects/checkpoints.md).

Если объем данных в хранилище проекта не превышает {{ ml-project-size }}, состояние данных также сохраняется в контрольных точках. Такие контрольные точки отмечены значком ![](../../_assets/datasphere/disk.svg). Если данные хранилища проекта превышают {{ ml-project-size }}, они не будут включены в версионирование, однако остальное состояние ноутбука будет сохранено.

Существует два режима сохранения состояния — стандартное и автоматическое. Режимы сохранения распространяются только на обычные ячейки. Ячейки с [фоновыми операциями](async.md) после выполнения создают контрольную точку автоматически или предлагают пользователю ее создать, выполнив `%apply_state`.

## Стандартное сохранение {#default-save}

В стандартном режиме сохранение происходит после выполнения ячейки или группы ячеек, либо после завершения с ошибкой.

Если в группе есть ячейки с [фоновыми операциями](async.md), то состояние будет сохраняться до завершения фоновых операций.

## Автоматическое сохранение {#auto-save}

В автоматическом режиме сохранение состояния происходит в следующих случаях:

* Если вычислений нет некоторое время, {{ ml-platform-short-name }} проверит, изменилось ли состояние ноутбука, и сохранит изменения при необходимости.
* Если произошло переключение на другой тип вычислительных ресурсов.
* Если вы принудительно сохранили состояние.

Чтобы включить режим автоматического сохранения:

  1. Откройте меню **Settings** в вашем ноутбуке.
  1. Выберите опцию **Autosave commit mode**.

### Принудительное сохранение состояния {#forced-save}

Для принудительного сохранения состояния в режиме автоматического сохранения нажмите значок ![plus-sign](../../_assets/plus-sign.svg) в правом верхнем углу вкладки ![checkpoints-panel](../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints**. Также вы можете сохранить состояние, используя сочетания клавиш **Cmd** + **K** или **Ctrl** + **K**.