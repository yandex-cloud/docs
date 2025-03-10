1. Save the following code to a file named `index.js`:

    ```js
    exports.handler = async function (event, context) {
        let name = 'World';
        if (event.queryStringParameters && event.queryStringParameters.name) {
            name = event.queryStringParameters.name
        }
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/plain'
            },
            'isBase64Encoded': false,
            'body': `Hello, ${name}!`
        }
    };
    ```

1. Add the `index.js` file into the `hello-js.zip` ZIP archive.

    {% include [macos-zip-error](macos-zip-error.md) %}
