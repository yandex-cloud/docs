# Managing Node.js function dependencies

{{ sf-name }} can automatically install dependencies required for a Node.js function to run when creating a new [function version](../../operations/function/version-manage.md).

To install dependencies, use the `npm ci --production` command that runs in the project root (function directory). This installs only the primary dependencies. It will not install the development dependencies from the `devDependencies` section.

You can list the required libraries in the following ways:

* Upload `package.json` and `package-lock.json` with the function code so {{ sf-name }} can automatically install dependencies.

   If you do not upload `package-lock.json`, the `npm i --production` command will be executed instead of `npm ci --production`, and the function will take longer to initialize.

* Add all the required dependencies to a single file yourself using a code bundler, such as `webpack`, or upload `node_modules` with the function code.

The dependency installation process has some technical restrictions. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.
