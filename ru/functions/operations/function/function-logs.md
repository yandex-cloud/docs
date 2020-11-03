# Просмотр журнала выполнения

Логи выполнения функции хранятся 14 дней. Время в журнале указано по [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ sf-name }}**.
    1. Нажмите на функцию, журнал выполнения которой вы хотите посмотреть.
    1. В открывшемся окне перейдите в раздел **Логи** и укажите период. По умолчанию задан период за 1 час.
    
- CLI
    
    {% include [timeslot](../../../_includes/functions/timeslot.md) %}
    
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %} 
   
    {% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

    Посмотрите журнал выполнения функции:

    ```
    $ yc serverless function logs <имя функции>
    ```
    Результат:
    ```
    2019-07-04 09:27:43     START RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad Version: b09i2s85a0c1fisjboft
    2019-07-04 09:27:43     END RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad
    2019-07-04 09:27:43     REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
    2019-07-04 09:29:25     START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef Version: b09i2s85a0c1fisjboft
    2019-07-04 09:29:26     END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef
    2019-07-04 09:29:26     REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
    ...
    ```

    {% note info %}
    
    Если вы вызывали функцию с определенном тегом, при просмотре журнала выполнения также необходимо указать этот тег: `yc serverless function logs my-python-function --tag test`.
    
    {% endnote %}

{% endlist %}

