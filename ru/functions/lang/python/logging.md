# Журналирование выполнения функции на Python

Сервис {{ sf-name }} автоматически захватывает потоки стандартного вывода приложения на Python и отправляет их в централизованную [систему журналирования](../../operations/function/function-logs.md), доступную в {{ yandex-cloud }}. Помимо журналов выполнения приложения записываются системные записи о событиях выполнения запроса.

Для записи дополнительных сообщений используются стандартные языковые конструкции:
1. `print` — выводит сообщение в стандартный поток вывода `stdout`.
1. `logging` — выводит сообщение в установленном формате в выбранный поток вывода.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

{% include [router-logging](../../../_includes/functions/router-logging.md) %}

## Пользовательские сообщения {#user-logging}

Перед запуском функции {{ sf-name }} настраивает для [корневого логгера](https://docs.python.org/3/howto/logging.html#advanced-logging-tutorial):
* обработчик для записи логов в `stdout`;
* форматтер, который добавляет к сообщению время его создания, идентификатор запроса и уровень логирования.

{% note warning %}

Изменить настройки корневого логгера с помощью функции `logging.basicConfig()` нельзя.

{% endnote %}

По умолчанию уровень корневого логгера — `Warning`, все логи с уровнем ниже игнорируются. Изменить уровень логирования можно с помощью метода `setLevel` для:

* всего приложения.
  ```python
  logging.getLogger().setLevel(logging.DEBUG)
  ```
* любого логгера, кроме корневого.
  ```python
  logging.getLogger('requests.packages.urllib3').setLevel(logging.DEBUG)
  logging.getLogger('myapp').setLevel(logging.DEBUG)
  ```

Изменить формат логов можно так:

```python
root_handler = logging.getLogger().handlers[0]
root_handler.setFormatter(logging.Formatter(
	'[%(levelname)s]\t%(name)s\t%(request_id)s\t%(message)s\n'
))
```

В примере вместо времени создания сообщения выводится имя логгера.

Подробнее о настройках логирования читайте в [документации Python](https://docs.python.org/3/howto/logging.html#configuring-logging).
