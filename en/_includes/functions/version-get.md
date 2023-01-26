{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/functions/functions.svg) **Functions**.
   1. Select the function to get a list of versions for.
   1. Under **Version history**, you can find the list of function versions and their details.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To find out the name or unique ID of a function version, get a [list of function versions](./version-list.md) in the folder.

   To get detailed information about a function version by:

   * `ID`, run the command:
      ```
      yc serverless function version get <version_ID>
      ```
      Result:
      ```
      id: b09u830mb1n3********
      function_id: b097d9ous3ge********
      created_at: "2019-06-13T09:23:23.383Z"
      runtime: python37
      entrypoint: test.handler
      resources:
        memory: "134217728"
      execution_timeout: 5s
      image_size: "4096"
      status: ACTIVE
      tags:
      - $latest
      log_group_id: eolv6578frac********
      ```

   * `TAGS`, run the command:
      ```
      yc serverless function version get-by-tag --function-name <function_name> --tag <tag>
      ```
      Result:
      ```
      id: b09ch6pmpohf********
      function_id: b097d9ous3ge********
      created_at: "2019-06-13T09:12:38.464Z"
      runtime: python37
      entrypoint: test.handler
      resources:
        memory: "134217728"
      execution_timeout: 5s
      image_size: "4096"
      status: ACTIVE
      tags:
      - beta
      log_group_id: eolv6578frac********
      ```

- API

   You can get details of the function version using the [getVersion](../../functions/functions/api-ref/Function/getVersion.md) API method.

- Yandex Cloud Toolkit

   You can get details about a function version using the [Yandex Cloud Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the IDE family on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}
