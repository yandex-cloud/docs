# Изменение API-шлюза

{% list tabs %}

- Консоль управления

    Чтобы обновить спецификацию API-шлюза:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо изменить API-шлюз.
    1. В списке сервисов выберите **{{ api-gw-name }}**.
    1. В открывшемся окне выберите API-шлюз и нажмите кнопку ![image](../../_assets/options.svg).
    1. В открывшемся меню нажмите кнопку **Редактировать**.
    1. Отредактируйте имя, описание или спецификацию API-шлюза.
    1. Нажмите кнопку **Сохранить**.
    
- CLI

    Чтобы изменить спецификацию API-шлюза:
    1. Внесите необходимые изменения в файл со спецификацией `hello-world.yaml`
    1. Выполните команду со следующими параметрами: 
    
        - `id` — идентификатор API-шлюза.
        - `spec` — файл с обновленной спецификацией.
        
        ```
        yc serverless api-gateway update --id d5dug9gkmu187iojcrtr --spec=hello_world.yaml
    
        done (6s)
        id: d5dug9gkmu187iojcrtr
        folder_id: b1g55tflru0ek7omtfu0
        created_at: "2020-06-17T09:20:22.929Z"
        name: hello-world
        description: hello world
        status: ACTIVE
        domain: d5dug9gkmu187iojcpvp.apigw.yandexcloud.net
        log_group_id: ckghq1hm19q7ek5sjnh5
        ```

- API

  Изменить имя, описание или спецификацию API-шлюза можно с помощью метода API [update](../apigateway/api-ref/ApiGateway/update.md).

- Yandex.Cloud Toolkit

  Изменить имя, описание или спецификацию API-шлюза можно с помощью [плагина Yandex.Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе Intellij]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
