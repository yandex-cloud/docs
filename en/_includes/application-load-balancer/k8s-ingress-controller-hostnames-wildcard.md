To refer to every possible subdomain at any level, replace the first-level domain name with an asterisk (`*`). The value here must be wrapped in quotes.

> The value `"*.example.com"`, for instance, matches `foo.example.com`, `foo-bar.example.com`, `foo.bar.example.com`, `foo.bar.baz.example.com`, and so on (but not `example.com`).

You cannot replace only a part of a first-level domain name with an asterisk. `*foo.example.com`, for instance, is illegal.