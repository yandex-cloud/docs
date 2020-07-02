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

    Чтобы обновить спецификацию API-шлюза:
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
      
{% endlist %}
