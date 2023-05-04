### Отсутствие общих зон доступности {#common-network}

Текст ошибки:

```text
Warn(Activate): YC: unable to resolve instance group:
unable to resolve net topology: neither source nor target subnet found:
No common availability zone found for the source and target endpoints:
source zones: [<имя зоны источника>], target zones: [<имя зоны приемника>]
```

Ошибка возникает, если хосты источника и приемника находятся внутри {{ yandex-cloud }}, но не имеют общих [зон доступности](../../../../overview/concepts/geo-scope.md).

**Решение:**

* Добавьте хост в один из кластеров таким образом, чтобы у хостов появилась общая зона доступности.
* Измените тип одного из эндпоинтов на `Пользовательская инсталляция`.
