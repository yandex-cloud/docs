---
title: "Просмотр журнала выполнения в {{ sf-full-name }}"
description: "Вы можете посмотреть график мониторинга в {{ sf-full-name }} с помощью консоли управления. Для этого выберите сервис {{ sf-name }}, нажмите на функцию, журнал выполнения которой вы хотите посмотреть. В открывшемся окне перейдите в раздел Логи и укажите период. По умолчанию задан период за 1 час. Логи выполнения функции хранятся 3 дня. Время в журнале указано по UTC."
---

# Посмотреть логи функции

Логи выполнения функции хранятся 3 дня. Время в журнале указано по [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Нажмите на функцию, журнал выполнения которой хотите посмотреть.
    1. В открывшемся окне перейдите в раздел **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** и укажите период, за который хотите посмотреть логи. По умолчанию задан период 1 час.
    
- CLI {#cli}
    
    {% include [timeslot](../../../_includes/functions/timeslot.md) %}
    
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %} 
   
    {% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

    Посмотрите журнал выполнения функции:

    ```
    yc serverless function logs <имя_функции>
    ```
    Результат:
    ```
    2019-07-04 09:27:43     START RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Version: b09i2s85a0c1********
    2019-07-04 09:27:43     END RequestID: 34dc9533-ed6e-4468-b9f2-2aa0********
    2019-07-04 09:27:43     REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
    2019-07-04 09:29:25     START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Version: b09i2s85a0c1********
    2019-07-04 09:29:26     END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f********
    2019-07-04 09:29:26     REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
    ...
    ```

    {% note info %}
    
    Если вы вызывали функцию с определенным тегом, при просмотре журнала выполнения также необходимо указать этот тег: `yc serverless function logs my-python-function --tag test`.
    
    {% endnote %}


- {{ yandex-cloud }} Toolkit

    Посмотреть журнал выполнения функции можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).


{% endlist %}

Подробнее о работе с логами в [документации {{ cloud-logging-full-name }}](../../../logging/).
