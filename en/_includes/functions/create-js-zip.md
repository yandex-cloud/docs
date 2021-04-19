1. Save the following code to a file named `index.js`:

    ```
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

1. Add `index.js` to the `hello-js.zip` archive.

