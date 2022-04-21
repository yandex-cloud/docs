To refer to every possible subdomain at any level, replace the first-level domain name with an asterisk (`*`). The value here must be wrapped in quotes.

> The value `"*.yandexcloud.example"`, for instance, matches `foo.yandexcloud.example`, `foo-bar.yandexcloud.example`, `foo.bar.yandexcloud.example`, `foo.bar.baz.yandexcloud.example`, and so on (but not `yandexcloud.example`).

You cannot replace only a part of a first-level domain name with an asterisk. `*foo.yandexcloud.example`, for instance, is illegal.