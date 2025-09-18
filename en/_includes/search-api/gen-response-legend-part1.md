* `messages`: Single search query or a search query with context in the form of chat with the model. It is specified as an array of objects, each one containing two elements:
    * `content`: Text of a user message or model's response (depending on the `role` value).
    * `role`: Message sender's role. The possible values are:
        * `ROLE_USER`: Means the message is sent by the user, and the `content` field contains the user's query.
        * `ROLE_ASSISTANT`: Means the message is sent by the model, and the `content` field contains the model's response.

    For more information about the {{ yagpt-name }} chat mode, see [{#T}](../../foundation-models/operations/generation/create-chat.md).
* Set the search scope in the `site`, `host`, and `url` fields. Note that the `site`, `host`, and `url` fields are mutually exclusive; you can only set one of them. If neither of these fields is set, the search will be performed across the entire Yandex search index.

    * `site`: Restricts the search to a specific array of websites. Not more than 5 websites per search.

        For example, for the `yandex.cloud` website, the search will target all `*.yandex.cloud/*` documents, i.e., the results will include pages with the following URLs:
        * `yandex.cloud/`
        * `subdomain.yandex.cloud/`
        * `yandex.cloud/path/`
        * `subdomain.yandex.cloud/path/`

        You can use the `site` field to specify the exact path to the search area, e.g., `{{ link-docs }}`.
    * `host`: Restricts the search to a specific array of hosts. Not more than 5 hosts per search.

        For example, for the `yandex.cloud/` host, the search will target all `yandex.cloud/*` documents, i.e., the results will include pages with the following URLs:
        * `yandex.cloud/`
        * `yandex.cloud/path/`

        Unlike `site`-based restrictions, `host`-based restrictions do not apply to subdomains. You also cannot provide a specific path to the search area in the `host` field.
    * `url`: Restricts the search to a specific array of pages, e.g., `{{ link-docs }}/serverless-containers/concepts/container` and `{{ link-docs }}/container-registry/concepts/docker-image`. Not more than 10 pages per search.