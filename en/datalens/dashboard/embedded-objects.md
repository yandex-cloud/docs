# Embedding objects

You can embed [published](../concepts/datalens-public.md) dashboards and charts into a website or app using an `iframe`.


You can configure the features and appearance of the objects being embedded through these parameters:

* `_autoupdate`: Sets [auto-update](./settings.md#auto-update) time for dashboards and charts in seconds. By default these are not updated automatically. Works only in the active browser tab. If the auto-update time has been reached for an inactive tab, it will take place when the tab becomes active again. Minimum value:

   * 30 seconds for dashboards.
   * 15 seconds for charts.

* `_embedded`: Hides the navigation panel. To enable the parameter, set to `1`.
* `_no_controls`: Hides the ![image](../../_assets/console-icons/ellipsis.svg) menu for charts. To enable the parameter, set to `1`.
* `_theme`: Specifies the object's appearance. The possible values include:

   * `light`: Use the light theme.
   * `dark`: Use the dark theme.

* `_no_scroll`: Disables vertical scrolling on dashboard. To enable the parameter, set to `1`.
* `_lang`: For charts, defines the language value for the menu that opens when you click ![image](../../_assets/console-icons/ellipsis.svg). Possible values: `ru` or `en`.

The parameter is added to the object address after the question mark `?`. To send multiple parameters, list them separated by `&`, e.g.:


```html
<iframe frameborder="0" src="https://datalens.yandex/bdzix********?_embedded=1&_no_controls=1&_lang=ru&_theme=dark"></iframe>
```



## Embedding private charts {#private-embedding}

{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}

You can securely embed private charts into a website or app using special links with a [JWT token](https://en.wikipedia.org/wiki/JSON_Web_Token).

Embedding private charts only works in the new {{ datalens-short-name }} object model at the [workbook](../workbooks-collections/index.md) level and is only available to the workbook [administrator](../security/roles.md#workbooks-admin).

### How to embed a private chart {#how-to-private-embed}

1. Create a key for embedding:

   {% note info %}

   You can use one key to embed multiple objects.

   {% endnote %}

   1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
   1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.
   1. Open the workbook where the chart to embed is located.
   1. At the top of the screen, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![key](../../_assets/console-icons/key.svg) **Keys for embedding**.
   1. In the window that opens:

      1. Click ![plus](../../_assets/console-icons/plus.svg) **Create key**.
      1. Enter the key name and click **Create**.
      1. At the bottom, click **Download key file** or copy the key value.

         {% note warning %}

         After closing the window, all data from it will be lost.

         {% endnote %}

         The new key for embedding will appear in the list.

1. Configure the embedding for a private chart:

   {% note info %}

   You can configure multiple embeddings for each chart.

   {% endnote %}

   1. In the row with the required chart, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **Embed settings**.
   1. In the window that opens, click ![plus](../../_assets/console-icons/plus.svg) **New embedding**.
   1. In the settings window, specify:

      * **Name**: Enter a name for the embedding.
      * **Key**: Select a previously created key for embedding.
      * **Unsigned parameters**: Specify [unsigned parameters](#unsigned-parameters) that can be provided in the link for embedding.

   1. Click **Create**. In the **ID** column, copy the ID of the object to embed, and then click **Close**.

1. Create a token:

   1. Prepare a payload for the token; a payload contains information about the object to embed. The payload contains the following fields:

      * `embedId`: ID of the object to embed.
      * `iat`: Time of issuing a JWT token in [Unix Timestamp](https://en.wikipedia.org/wiki/Unix_time) format.
      * `exp`: Token expiration time in Unix Timestamp format.
      * `dlEmbedService`: Service ID string constant, `YC_DATALENS_EMBEDDING_SERVICE_MARK`.
      * `params`: Optional property that defines signed chart parameters transferred as part of the token. They cannot be changed without regenerating the token.

         Example:

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

   1. To create a JWT token, sign the prepared payload with the private key you got earlier when creating the key for embedding.

      {% note info %}

      Use the `PS256` algorithm when creating the JWT.

      {% endnote %}

      To create a JWT token, use these code samples:

      {% list tabs group=programming_language %}

      - Python {#python}

         Install the `cryptography` module to use the `PS256` algorithm:

         ```bash
         pip3 install cryptography
         ```

         Run the following code:

         ```python
         import time
         import jwt
         import json
         ​
         private_key = b"""<private_key>"""
         ​
         now = int(time.time())
         payload = {
            'embedId': "<ID_of_object_to_embed>",
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

         Install the [jsonwebtoken](https://github.com/auth0/node-jsonwebtoken) package using [npm](https://www.npmjs.com/):

         ```bash
         npm install jsonwebtoken
         ```

         Run the following code:

         ```js
         const privateKey = `<private_key>`;

         const now = Math.floor(Date.now() / 1000);
         const payload = {
         embedId: '<ID_of_object_to_embed>',
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

         Install the [jwt-go](https://github.com/golang-jwt/jwt) package:

         ```bash
         go install github.com/golang-jwt/jwt/v5@latest
         ```

         Run the following code:

         ```golang

         package main

         import (
           "fmt"
           "time"

           "github.com/golang-jwt/jwt/v5"
         )

         func main() {
           privateKey, err := jwt.ParseRSAPrivateKeyFromPEM([]byte(`<private_key>`))

           now := time.Now().Unix()
           payload := jwt.MapClaims{
               "embedId":        "<ID_of_object_to_embed>",
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

   1. Generate a link for embedding:

      ```
      {{ link-datalens-main }}/embeds/chart#dl_embed_token=<token>
      ```

      Where `<token>` is the JWT token.

1. Add an embedding link to your website or app, for example:

   ```html
   <iframe src="{{ link-datalens-main }}/embeds/chart#dl_embed_token=<token>" width="600" height="400" frameborder="0"></iframe>
   ```

   Where:

   * `src`: Embedding URL
   * `<token>`: JWT token
   * `width`: Chart width
   * `height`: Chart height
   * `frameborder`: Chart boarder (yes or no)

### Unsigned parameters {#unsigned-parameters}

When creating an object to embed, you can specify one or more unsigned parameters. These parameters are not added to the token. You can provide them directly in the URL before the token hash. This allows you to change some widget parameters on the client side without recreating the token.

For example, if the chart uses the `from` and `to` parameters to filter by time, add the same unsigned parameters when creating the object. You can provide these parameters in the embedding link before the token hash:

```html
<iframe src="{{ link-datalens-main }}/embeds/chart?from=2022-01-01&to=2023-02-05#dl_embed_token=<token>" width="600" height="400" frameborder="0"></iframe>
```

Where:

* `src`: Embedding URL.
* `<token>`: JWT token.
* `from=2022-01-01&to=2023-02-05`: Unsigned parameters specified during the embedding setup.

