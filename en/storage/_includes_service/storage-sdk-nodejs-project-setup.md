1. [Install](https://nodejs.org/en/download) Node.js.
1. Create a directory for the code example and navigate to it:

    ```bash
    mkdir app
    cd app
    ```

1. Initialize a project named Node.js and use the command below to install the `aws-sdk/client-s3` library:

    ```bash
    npm init -y && npm i @aws-sdk/client-s3
    ```

1. Add the `"type": "module"` row into the package.json file to use the [ESM (ECMAScript Modules)](https://nodejs.org/api/esm.html) syntax in the project. A file named `package.json` with the project's basic Node.js settings will be created in the directory. 

    The resulting `package.json` file will appear as follows:

    ```json
    {
        "name": "check",
        "version": "1.0.0",
        "main": "index.js",
        "scripts": {
            "test": "echo \"Error: no test specified\" && exit 1"
        },
        "keywords": [],
        "author": "",
        "license": "ISC",
        "description": "",
        "dependencies": {
            "@aws-sdk/client-s3": "^3.726.1"
        },
        "type": "module"
    }
    ```

1. Create a file named `index.js` for the code using the AWS SDK.