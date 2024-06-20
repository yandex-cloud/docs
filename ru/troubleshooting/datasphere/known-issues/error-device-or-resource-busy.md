# Устранение ошибки `Device or resource busy`


## Описание проблемы {#issue-description}

При попытке установить библиотеку возникает сообщение об ошибке:

```
ERROR: Could not install packages due to an OSError: [Errno 16] Device or resource busy: '.nfs0000000000009d3a00000018'
```

## Решение {#issue-resolution}

Сообщение `ERROR: Could not install packages due to an OSError: [Errno 16] Device or resource busy: '.nfs0000000000009d3a00000018'` – это служебное сообщение, связанное с работой ресурсов. 

Попробуйте выполнить команды:
* `Kernel` ⟶ `Restart Kernel`;
* `File` ⟶ `Stop IDE executions` в {{ jlab }}Lab или нажмите **Остановить исполнения в IDE** в виджете **Запущенные операции** на странице проекта.

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).
При создании запроса укажите следующую информацию:

1. Ссылку на проект.
1. Точное время возникновения ошибки.