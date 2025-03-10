---
title: Using functions to get an IAM token for a service account
description: Follow this guide to get an IAM token for a service account using functions.
---

# Using functions to get an IAM token for a service account

If the function version was created with a service account, you can get an IAM token for it from: 

* The handler [context](../concepts/function.md#model-desc). You can find the IAM token in the `access_token` field of the `context` parameter.
* The metadata service in [Google Compute Engine](../../compute/operations/vm-info/get-info.md#inside-instance) via the API.

To get an IAM token:

1. [Create a function](../operations/function/function-create.md).

1. Select the programming language and create a version of the function:

     {% list tabs group=programming_language %}

     - Node.js {#node}
        1. Prepare a ZIP archive with the function code:
            1. Save the following code to a file named `index.js` to get the IAM token:
                * From the handler context.
                    ```js
                    exports.main = async function (event, context) {
                        return {
                            'statusCode': 200,
                            'headers': {
                                'Content-Type': 'text/plain'
                            },
                            'isBase64Encoded': false,
                            'body': context.token
                        }
                    };
                    ```
                * Using the API.
                    ```js
                    const fetch = require("node-fetch");
                    let url = 'http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token';
                    let headers = {'Metadata-Flavor': 'Google'};

                    exports.main = async function (event) {
                        const resp = await fetch(url, {
                            headers: headers,
                        });
                        return {
                            code: resp.status,
                            body: await resp.text()
                        };
                    };
                    ```
            1. If you want to get your IAM token using the API, save the following code to a file named `package.json`:
                ```
                {
                    "name": "my-app",
                    "dependencies": {
                        "node-fetch": "2.x"
                    }
                }
                ```
            1. Add the `index.js` file and, if using the API to get the IAM token, the `package.json` file into the `index-js.zip` archive.
        1. [Create](../operations/function/version-manage.md) a function version. Specify the following:
            * Runtime environment: `nodejs16`.
            * Code upload method: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
            * File: `index-js.zip`.
            * Entry point: `index.main`.
            * Service account to get the IAM token for.

    - Python {#python}
        1. Prepare a ZIP archive with the function code:
            1. Save the following code to a file named `index.py` to get the IAM token:
                * From the handler context.
                    ```py
                    def main(event, context):

                        return {
                            'statusCode': 200,
                            'headers': {
                                'Content-Type': 'text/plain'
                            },
                            'isBase64Encoded': False,
                            'body': context.token
                        }
                    ```
                * Using the API.
                    ```py
                    import requests

                    url = 'http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token'
                    headers = {'Metadata-Flavor': 'Google'}


                    def main(event, context):

                        resp = requests.get(url, headers=headers)

                        return {
                            'statusCode': 200,
                            'headers': {
                                'Content-Type': 'text/plain'
                            },
                            'isBase64Encoded': False,
                            'body': resp.content.decode('UTF-8')
                        }
                    ```
            1. Add the `index.py` file into the `index-py.zip` archive.
        1. [Create](../operations/function/version-manage.md) a function version. Specify the following:
            * Runtime environment: `python311`.
            * Code upload method: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
            * File: `index-py.zip`.
            * Entry point: `index.main`.
            * Service account to get the IAM token for.

    {% endlist %}

1. [Run](../operations/function/function-invoke.md) the function.

    The function response looks like this:

    ```json
    {
        "access_token": "CggVAgAAABoBMRKABHGgpZ......",
        "expires_in": 42299,
        "token_type": "Bearer"
    }
    ```