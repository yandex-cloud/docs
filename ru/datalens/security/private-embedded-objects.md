# Встраивание непубличных чартов

{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}

Вы можете безопасно встроить непубличные чарты на сайт или в приложение с помощью специальных ссылок с [JWT-токеном](https://ru.wikipedia.org/wiki/JSON_Web_Token).

Встраивание непубличных чартов работает только в новой объектной модели {{ datalens-short-name }} на уровне [воркбуков](../workbooks-collections/index.md) и доступно только [администратору](../security/roles.md#workbooks-admin) воркбука.

## Как встроить непубличный чарт {#how-to-private-embed}

1. Создайте ключ для встраивания:

   {% note info %}

   Один ключ можно использовать для встраивания нескольких объектов.

   {% endnote %}

   1. Перейдите на [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
   1. На панели слева выберите ![collections](../../_assets/console-icons/rectangles-4.svg) **Коллекции и воркбуки**.
   1. Откройте воркбук, в котором расположен чарт для встраивания.
   1. В верхней части интерфейса нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![key](../../_assets/console-icons/key.svg) **Ключи для встраивания**.
   1. В открывшемся окне:

      1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Создать ключ**.
      1. Введите название ключа и нажмите кнопку **Создать**.
      1. Внизу нажмите кнопку **Скачать файл с ключом** или скопируйте значение ключа.

         {% note warning %}

         После закрытия окна все данные из него будут потеряны.

         {% endnote %}

         Новый ключ для встраивания появится в списке.

1. Настройте встраивание для непубличного чарта:

   {% note info %}

   Для каждого чарта можно настроить несколько встраиваний.

   {% endnote %}

   1. В строке с нужным чартом нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Настройки встраивания**.
   1. В открывшемся окне нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Новое встраивание**.
   1. В окне настроек укажите:

      * **Название** — введите название встраивания.
      * **Ключ** — выберите созданный ранее ключ для встраивания.
      * **Неподписанные параметры** — укажите [неподписанные параметры](#unsigned-parameters), которые можно передавать в ссылке для встраивания.

   1. Нажмите кнопку **Создать**. В колонке **ID** скопируйте идентификатор объекта встраивания, а затем нажмите **Закрыть**.

1. Создайте токен:

   1. Подготовьте payload для токена — полезную нагрузку, которая содержит информацию об объекте встраивания. Полезная нагрузка содержит следующие поля:

      * `embedId` — идентификатор объекта встраивания.
      * `iat` — время выписки токена JWT в формате [Unix Timestamp](https://ru.wikipedia.org/wiki/Unix_time).
      * `exp` — время окончания действия токена в формате Unix Timestamp.
      
        {% note warning %}

        Токены, в которых разница между `exp` и `iat` превышает 10 часов, считаются невалидными.

        {% endnote %}

      * `dlEmbedService` — строковая константа идентификатора сервиса: `YC_DATALENS_EMBEDDING_SERVICE_MARK`.
      * (опционально) `params` — подписанные параметры чарта, которые передаются в составе токена. Их нельзя изменить без повторной генерации токена.

        Пример:

        ```json
        {
          "embedId": "ieez7********",
          "iat": 1516239022,
          "exp": 1516240822,
          "dlEmbedService": "YC_DATALENS_EMBEDDING_SERVICE_MARK",
          "params": {
            "param1": "value1",
            "param2": "value2"
          }
        }
        ```

   1. Чтобы создать JWT-токен, подпишите подготовленный payload закрытым ключом, который был получен ранее при создании ключа для встраивания.

      {% note info %}

      Используйте при создании JWT алгоритм `PS256`.

      {% endnote %}

      Для создания JWT-токена используйте примеры кода:

      {% list tabs group=programming_language %}

      - Python {#python}

        Установите модуль `cryptography` для работы с алгоритмом `PS256`:

        ```bash
        pip3 install cryptography
        ```

        Выполните код:

        ```python
        import time
        import jwt
        import json
        ​
        private_key = b"""<закрытый_ключ>"""
        ​
        now = int(time.time())
        payload = {
           'embedId': "<идентификатор_объекта_встраивания>",
           'dlEmbedService': "YC_DATALENS_EMBEDDING_SERVICE_MARK",
           'iat': now,
           'exp': now + 360,
           "params": {  }}
           ​
        # JWT generation.
        encoded_token = jwt.encode(
           payload,
           private_key,
           algorithm='PS256',
           )

        print(encoded_token)
        ```

      - Node.js {#node}

        Установите пакет [jsonwebtoken](https://github.com/auth0/node-jsonwebtoken) с помощью [npm](https://www.npmjs.com/):

        ```bash
        npm install jsonwebtoken
        ```

        Выполните код:

        ```js
        const privateKey = `<закрытый_ключ>`;

        const now = Math.floor(Date.now() / 1000);
        const payload = {
        embedId: '<идентификатор_объекта_встраивания>',
        dlEmbedService: 'YC_DATALENS_EMBEDDING_SERVICE_MARK',
        iat: now,
        exp: now + 360,
        params: {},
        };

        const jwt = require('jsonwebtoken');

        const encodedToken = jwt.sign(payload, privateKey, {
        algorithm: 'PS256',
        });

        console.log(encodedToken);
        ```

      - Go {#go}

        Установите пакет [jwt-go](https://github.com/golang-jwt/jwt):

        ```bash
        go install github.com/golang-jwt/jwt/v5@latest
        ```

        Выполните код:

        ```golang
        
        package main

        import (
          "fmt"
          "time"

          "github.com/golang-jwt/jwt/v5"
        )

        func main() {
          privateKey, err := jwt.ParseRSAPrivateKeyFromPEM([]byte(`<закрытый_ключ>`))

          now := time.Now().Unix()
          payload := jwt.MapClaims{
              "embedId":        "<идентификатор_объекта_встраивания>",
              "dlEmbedService": "YC_DATALENS_EMBEDDING_SERVICE_MARK",
              "iat":            now,
              "exp":            now + 360,
              "params":         map[string]interface{}{},
          }

          token := jwt.NewWithClaims(jwt.SigningMethodPS256, payload)
          signedToken, err := token.SignedString(privateKey)
          if err != nil {
              fmt.Println("Error generating token:", err)
              return
          }

          fmt.Println(signedToken)
        }
        ```

      {% endlist %}

   1. Сформируйте ссылку для встраивания:

      ```
      {{ link-datalens-main }}/embeds/chart#dl_embed_token=<токен>
      ```

      Где `<токен>` — JWT-токен.

1. Добавьте ссылку для встраивания на свой сайт или в приложение. Например:

   ```html
   <iframe src="{{ link-datalens-main }}/embeds/chart#dl_embed_token=<токен>" width="600" height="400" frameborder="0"></iframe>
   ```

   Где:

   * `src` — URL встраивания.
   * `<токен>` — JWT-токен.
   * `width` — ширина чарта.
   * `height` — высота чарта.
   * `frameborder` — наличие рамки для чарта.

## Неподписанные параметры {#unsigned-parameters}

При создании объекта встраивания можно указать один или несколько неподписанных параметров. Эти параметры не добавляются в токен. Их можно передать непосредственно в URL перед хешем с токеном. Это позволяет изменять некоторые параметры виджета на стороне клиента без повторного создания токена.

Например, если в чарте используются параметры `from` и `to` для фильтрации по времени, добавьте такие же неподписанные параметры при создании объекта встраивания. Эти параметры можно передавать в ссылке для встраивания перед хешем с токеном:

```html
<iframe src="{{ link-datalens-main }}/embeds/chart?from=2022-01-01&to=2023-02-05#dl_embed_token=<токен>" width="600" height="400" frameborder="0"></iframe>
```

Где:

* `src` — URL встраивания.
* `<токен>` — JWT-токен.
* `from=2022-01-01&to=2023-02-05` — неподписанные параметры, указанные при настройке встраивания.
