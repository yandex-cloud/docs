# Как начать работать с {{ captcha-full-name }}

Чтобы начать работу с сервисом:

1. [Создайте капчу](#creat-captcha).
1. [Получите ключи](#get-keys).
1. [Добавьте виджет на страницу](#add-widget).
1. [Проверьте ответ пользователя](#check-answer).


## Перед началом работы {#before-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}). Войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md).


## Создайте капчу {#creat-captcha}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ captcha-full-name }}**.
    1. Нажмите кнопку **Создать капчу**.
    1. Введите имя капчи.
    1. Выберите сложность `Medium`.
    1. Укажите список сайтов, на которых будет размещаться капча.
    1. **Типа конфигурации** оставьте стандартным.
    1. Нажмите кнопку **Создать**.

{% endlist %}


## Получите ключи капчи {#get-keys}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ captcha-full-name }}**.
    1. Нажмите на имя капчи или [создайте](#creat-captcha) новую капчу.
    1. На вкладке **Обзор** скопируйте `ключ_клиента` и `ключ_сервера`.

{% endlist %}

С помощью ключа клиента вы можете [добавить виджет](#add-widget) {{ captcha-name }} на свою страницу. Ключ сервера потребуется для [проверки ответа](#check-answer) пользователя.


## Добавьте виджет на страницу {#add-widget}

Добавьте виджет автоматическим методом:

1. Подключите JS-скрипт к странице пользователя. Для этого разместите в любом месте страницы (например, внутри тега `<head>`) код:

    ```html
    <script src="https://captcha-api.yandex.ru/captcha.js" defer></script>
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

Для проверки токена нужно отправить GET-запрос на адрес `https://captcha-api.yandex.ru/validate` со следующими параметрами:

* `secret` — ключ для серверной части;
* `token` — токен, полученный после прохождения проверки;
* `ip` — IP-адрес пользователя, от которого пришел запрос на проверку токена.

Пример функции проверки токена:

{% list tabs %}

- Node.js

    ```js
    const https = require('https'),
        querystring = require('querystring');

    const SMARTCAPTCHA_SERVER_KEY = "<ключ_сервера>";


    function check_captcha(token, callback) {
        const options = {
            hostname: 'captcha-api.yandex.ru',
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
                    callback(true);
                    return;
                }
                callback(JSON.parse(content).status === 'ok');
            });
        });
        req.on('error', (error) => {
            console.error(error);
            callback(true);
        });
        req.end();
    }


    let token = "<token>";
    check_captcha(token, (passed) => {
        if (passed) {
            console.log("Passed");
        } else {
            console.log("Robot");
        }
    });
    ```

- PHP

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
        curl_setopt($ch, CURLOPT_URL, "https://captcha-api.yandex.ru/validate?$args");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 1);

        $server_output = curl_exec($ch);
        $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($httpcode !== 200) {
            echo "Allow access due to an error: code=$httpcode; message=$server_output\n";
            return true;
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

- Python

    ```py
    import requests
    import sys
    import json


    SMARTCAPTCHA_SERVER_KEY = "<ключ_сервера>"


    def check_captcha(token):
        resp = requests.get(
            "https://captcha-api.yandex.ru/validate",
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
            return True
        return json.loads(server_output)["status"] == "ok"
    token = "<token>"  # Например, request.form["smart-token"]
    if check_captcha(token):
        print("Passed")
    else:
        print("Robot")
    ```

{% endlist %}


## Что дальше {#whats-next}

* Узнайте больше [о методах подключения](./concepts/widget-methods.md) виджета {{ captcha-name }}.