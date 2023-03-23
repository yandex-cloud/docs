To refer to every possible subdomain at any level, replace the first-level domain name with an asterisk (`*`). In this case, the value must be wrapped in quotes.

> For instance, the `"*.example.com"` value matches `foo.example.com`, `foo-bar.example.com`, `foo.bar.example.com`, `foo.bar.baz.example.com`, etc., but does not match `example.com`.

You cannot replace only a part of a first-level domain name with an asterisk, as in `*foo.example.com`.