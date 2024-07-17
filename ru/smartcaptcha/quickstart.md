---
title: "Как начать работать с {{ captcha-full-name }}"
description: "Следуя данной инструкции, вы сможете создать и настроить капчу."
---

# Как начать работать с {{ captcha-full-name }}

Чтобы начать работу с сервисом:

1. [Создайте капчу](#creat-captcha).
1. [Получите ключи](#get-keys).
1. [Добавьте виджет на страницу](#add-widget).
1. [Проверьте ответ пользователя](#check-answer).


## Перед началом работы {#before-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}). Войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. На странице [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md).


## Создайте капчу {#creat-captcha}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.smartcaptcha.button_captcha-settings-create }}**.

       ![screen01](../_assets/smartcaptcha/screen01.svg)

    1. Введите имя капчи. Требования к имени:

        {% include [name-format](../_includes/smartcaptcha/name-format.md) %}

    1. Выберите тип [основного задания](./concepts/tasks.md#main-task), которое предлагается решить пользователю.
    1. Выберите тип [дополнительного задания](./concepts/tasks.md#additional-task), которое предлагается решить пользователю.
    1. Выберите [сложность](./concepts/tasks.md#task-difficulty) `{{ ui-key.yacloud.smartcaptcha.value_complexity-medium }}`.

       ![screen02](../_assets/smartcaptcha/screen02.svg)

    1. (Опционально) Отключите [проверку имени домена](./concepts/domain-validation.md).
    1. Укажите список сайтов, на которых будет размещаться капча.
    1. **{{ ui-key.yacloud.smartcaptcha.label_section-style }}** оставьте стандартным.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

       ![screen03](../_assets/smartcaptcha/screen03.svg)

{% endlist %}


## Получите ключи капчи {#get-keys}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
    1. Нажмите на имя капчи или [создайте](#creat-captcha) новую капчу.
    1. На вкладке **{{ ui-key.yacloud.common.overview }}** скопируйте значения полей **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** и **{{ ui-key.yacloud.smartcaptcha.label_server-key }}**.

    ![screen04](../_assets/smartcaptcha/screen04.svg)

{% endlist %}

С помощью ключа клиента вы можете [добавить виджет](#add-widget) {{ captcha-name }} на свою страницу. Ключ сервера потребуется для [проверки ответа](#check-answer) пользователя.


## Добавьте виджет на страницу {#add-widget}

Добавьте виджет автоматическим методом:

1. Подключите JS-скрипт к странице пользователя. Для этого разместите в любом месте страницы (например, внутри тега `<head>`) код:

    ```html
    <script src="https://smartcaptcha.yandexcloud.net/captcha.js" defer></script>
    ```

    Скрипт `captcha.js` автоматически найдет все `div` с классом `smart-captcha` и установит в них виджет.

1. Добавьте на страницу пустой контейнер (элемент `div`), чтобы скрипт `captcha.js` загрузил в него виджет:

    ```html
    <div
        id="captcha-container"
        class="smart-captcha"
        data-sitekey="<ключ_клиента>"
    ></div>
    ```

    {% include [info-container-height](../_includes/smartcaptcha/info-container-height.md) %}

На странице отобразится кнопка **Я не робот**. Сервис проверит запрос пользователя, когда он нажмет кнопку. Если запрос покажется подозрительным, сервис предложит пользователю решить задание.


## Проверьте ответ пользователя {#check-answer}

После проверки пользователю выдается уникальный токен. Токен загружается в элемент `<input type="hidden" name="smart-token" value="<токен>"` внутри контейнера с виджетом. Например, так:

```html
<div id="captcha-container" class="smart-captcha" ...>
    <input type="hidden" name="smart-token" value="<токен>">
    ...
</div>
```

Для проверки токена нужно отправить GET-запрос на адрес `https://smartcaptcha.yandexcloud.net/validate` со следующими параметрами:

{% include [query-parameters](../_includes/smartcaptcha/query-parameters.md) %}

Пример функции проверки токена:

{% list tabs group=programming_language %}

- Node.js {#node}

    ```js
    const https = require('https'),
        querystring = require('querystring');

    const SMARTCAPTCHA_SERVER_KEY = "<ключ_сервера>";


    function check_captcha(token, callback) {
        const options = {
            hostname: 'smartcaptcha.yandexcloud.net',
            port: 443,
            path: '/validate?' + querystring.stringify({
                secret: SMARTCAPTCHA_SERVER_KEY,
                token: token,
                ip: '<IP-адрес_пользователя>', // Способ получения IP-адреса пользователя зависит от вашего фреймворка и прокси.
            }),
            method: 'GET',
        };
        const req = https.request(options, (res) => {
            res.on('data', (content) => {
                if (res.statusCode !== 200) {
                    console.error(`Allow access due to an error: code=${res.statusCode}; message=${content}`);
                    callback(false);
                    return;
                }
                callback(JSON.parse(content).status === 'ok');
            });
        });
        req.on('error', (error) => {
            console.error(error);
            callback(false);
        });
        req.end();
    }


    let token = "<токен>";
    check_captcha(token, (passed) => {
        if (passed) {
            console.log("Passed");
        } else {
            console.log("Robot");
        }
    });
    ```

- PHP {#php}

    ```php
    define('SMARTCAPTCHA_SERVER_KEY', '<ключ_сервера>');

    function check_captcha($token) {
        $ch = curl_init();
        $args = http_build_query([
            "secret" => SMARTCAPTCHA_SERVER_KEY,
            "token" => $token,
            "ip" => $_SERVER['REMOTE_ADDR'], // Нужно передать IP-адрес пользователя.
                                             // Способ получения IP-адреса пользователя зависит от вашего прокси.
        ]);
        curl_setopt($ch, CURLOPT_URL, "https://smartcaptcha.yandexcloud.net/validate?$args");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 1);

        $server_output = curl_exec($ch);
        $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($httpcode !== 200) {
            echo "Allow access due to an error: code=$httpcode; message=$server_output\n";
            return false;
        }
        $resp = json_decode($server_output);
        return $resp->status === "ok";
    }

    $token = $_POST['smart-token'];
    if (check_captcha($token)) {
        echo "Passed\n";
    } else {
        echo "Robot\n";
    }
    ```

- Python {#python}

    ```py
    import requests
    import sys
    import json


    SMARTCAPTCHA_SERVER_KEY = "<ключ_сервера>"


    def check_captcha(token):
        resp = requests.get(
            "https://smartcaptcha.yandexcloud.net/validate",
            {
                "secret": SMARTCAPTCHA_SERVER_KEY,
                "token": token,
                "ip": "<IP-адрес_пользователя>"  # Способ получения IP-адреса зависит от вашего фреймворка и прокси.                                   
                                                 # Например, в Flask это может быть request.remote_addr
            },
            timeout=1
        )
        server_output = resp.content.decode()
        if resp.status_code != 200:
            print(f"Allow access due to an error: code={resp.status_code}; message={server_output}", file=sys.stderr)
            return False
        return json.loads(server_output)["status"] == "ok"
    token = "<токен>"  # Например, request.form["smart-token"]
    if check_captcha(token):
        print("Passed")
    else:
        print("Robot")
    ```

{% endlist %}


## Что дальше {#whats-next}

* Узнайте больше [о методах подключения](./concepts/widget-methods.md) виджета {{ captcha-name }}.