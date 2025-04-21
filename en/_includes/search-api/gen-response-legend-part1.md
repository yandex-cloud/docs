* `messages`: Single search query or a search query with context in the form of chat with the model. It is specified as an array of objects, each one containing two elements:
    * `content`: Text of a user message or model's response (depending on the `role` value).
    * `role`: Message sender's role. The possible values are:
        * `ROLE_USER`: Means the message is sent by the user, and the `content` field contains the user's query.
        * `ROLE_ASSISTANT`: Means the message is sent by the model, and the `content` field contains the model's response.

    For more information about the {{ yagpt-name }} chat mode, see [{#T}](../../foundation-models/operations/yandexgpt/create-chat.md).
* Use the `site`, `host`, and `url` fields to set the search scope. This is a required parameter in a query. Note that the `site`, `host`, and `url` fields are mutually exclusive; you can only set one of them.

    * `site`: Restricts the search to a specific array of websites.

        For example, for the `yandex.cloud` website, the search will target all `*.yandex.cloud/*` documents, i.e., the results will include pages with the following URLs:
        * `yandex.cloud/`
        * `subdomain.yandex.cloud/`
        * `yandex.cloud/path/`
        * `subdomain.yandex.cloud/path/`

        You can use the `site` field to specify the exact path to the search area, e.g., `{{ link-docs }}`.
    * `host`: Restricts the search to a specific array of hosts.

        For example, for the `yandex.cloud/` host, the search will target all `yandex.cloud/*` documents, i.e., the results will include pages with the following URLs:
        * `yandex.cloud/`
        * `yandex.cloud/path/`

        Unlike `site`-based restrictions, `host`-based restrictions do not apply to subdomains. You also cannot provide a specific path to the search area in the `host` field.
    * `url`: Restricts the search to a specific array of pages, e.g., `{{ link-docs }}/serverless-containers/concepts/container` and `{{ link-docs }}/container-registry/concepts/docker-image`.