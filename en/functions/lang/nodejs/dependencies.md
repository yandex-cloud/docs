---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Managing dependencies

{% note info %}

This section describes the functionality that is only available in the `nodejs12` and `nodejs14` runtime environment.

{% endnote %}

{{ sf-name }} can automatically install dependencies necessary for a function to run when creating a new [function version](../../operations/function/version-manage.md#func-version-create).

Dependencies are installed by the `npm ci` command that is run in the project root (directory with the function). You can list the required libraries in the following ways:

* Specify the libraries and their versions in the `package.json` file:

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
    * If the `package.json` file is missing, a file named `package-lock.json` is created. It contains a list of the registered versions of all the libraries in use.

The dependency installation process has some technical restrictions. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.

