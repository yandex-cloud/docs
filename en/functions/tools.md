# Tools for operations with functions in {{ sf-name }}

## {{ yandex-cloud }} Toolkit {#yc-toolkit}

[{{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) is a plugin for the [JetBrains](https://www.jetbrains.com/) [IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) IDE family.

## Serverless Framework: {{ yandex-cloud }} {#serverless-plugin}

[Serverless Framework: {{ yandex-cloud }}](https://github.com/yandex-cloud/serverless-plugin) is a plugin for working with the [serverless.com](https://github.com/serverless/serverless) framework.

## The terraform-yc-function module {#tf-yc-function}

The [terraform-yc-function](https://github.com/terraform-yc-modules/terraform-yc-function) module for {{ TF }}. See [{#T}](../tutorials/infrastructure-management/terraform-modules.md) for information on how to connect new modules.

## {{ yandex-cloud }} SDK {#sdk}

* Node.js SDK: [Library source code](https://github.com/yandex-cloud/nodejs-sdk) on GitHub with a [guide](lang/nodejs/sdk.md).
* Python SDK: [Library source code](https://github.com/yandex-cloud/python-sdk) on GitHub with a [guide](lang/python/sdk.md).
* Go SDK: [Library source code](https://github.com/yandex-cloud/go-sdk) on GitHub with a [guide](lang/golang/sdk.md).
* Bash SDK: [Guide](lang/bash/sdk.md).
* Java SDK: [Library source code](https://github.com/yandex-cloud/java-sdk) on GitHub with guides for [Java](lang/java/sdk.md) and [Kotlin](lang/kotlin/sdk.md).
* .NET Core SDK: [Library source code](https://github.com/yandex-cloud/dotnet-sdk) on GitHub with a [guide](lang/csharp/sdk.md).

## GitHub Actions {#github-actions}

* [Yandex Serverless Action](https://github.com/marketplace/actions/yandex-serverless-action): Uploads the function code to [{{ objstorage-name }}](../storage/) and creates a new version of the function in {{ sf-name }}.
* [YC Function deploy](https://github.com/marketplace/actions/yc-function-deploy): Finds or creates a function from {{ sf-name }} in a specified folder and creates a version of that function.

There is community support for GitHub Actions.
