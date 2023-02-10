# Managing PHP function dependencies

{{ sf-name }} can automatically install dependencies required for a PHP function to run when creating a new [function version](../../operations/function/version-manage.md).

Dependencies are installed by the `composer install` command that is run in the project root (directory with the function). You can list the required libraries in the following ways:
* Specify the libraries and their versions in the `composer.json` file:

    ```json
    {
      "require": {
        "guzzlehttp/guzzle": "~6.0",
        "ext-json": "*"
      }
    }
    ```
* Run the `composer require <library>` command in the project root. This adds the library to the `composer.json` file and installs it to the `vendor` directory.

The dependency installation process has some technical restrictions. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.
