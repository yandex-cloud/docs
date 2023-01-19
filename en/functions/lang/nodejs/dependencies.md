# Managing Node.js function dependencies

{% note warning %}

This section describes functionality that is unavailable in the `nodejs10` runtime environment.

{% endnote %}

{{ sf-name }} can automatically install dependencies required for a Node.js function to run when creating a new [function version](../../operations/function/version-manage.md#func-version-create).

To install dependencies, use the `npm ci --production` command that runs in the project root (function directory). This installs only the primary dependencies. It will not install the development dependencies from the `devDependencies` section.

You can list the required libraries in the following ways:
* Specify the required libraries and their versions in the `package.json` file:

   ```json
   {
     "name": "my-app",
     "version": "1.0.0",
     "dependencies": {
       "lodash": "^4.17.15"
     }
   }
   ```
* Run the `npm install <library>` command in the project root.
   * If the `package.json` file exists, the library is added to it.
   * If the `package.json` file is missing, a file named `package-lock.json` is created listing the registered versions of all the libraries in use.

The dependency installation process has some technical restrictions. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.
