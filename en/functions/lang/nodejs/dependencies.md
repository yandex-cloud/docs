# Managing Node.js function dependencies

{{ sf-name }} can automatically install dependencies required for a Node.js function when creating a new [function version](../../operations/function/version-manage.md).

To install dependencies, use the `npm ci --production` command that runs in the project root (function directory). This installs only the primary dependencies. It will not install the development dependencies from the `devDependencies` section.

You can list the required libraries in the following ways:

* Upload `package.json` and `package-lock.json` with the function code so {{ sf-name }} can automatically install dependencies.

  If you do not upload `package-lock.json`, the `npm ci --production` command will run instead of `npm i --production`, and the function will take longer to initialize.

* Bundle all required dependencies into a single file using a code bundler, such as `webpack`, or upload `node_modules` together with the function code.

The dependency installation process has some technical limitations. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log via the link displayed in the list of operations.
