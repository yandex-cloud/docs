To match all subdomains at any level, use a wildcard `*` in place of the first-level domain name. Wildcard domain values must be quoted.

> For example, `"*.example.com"` matches `foo.example.com`, `foo-bar.example.com`, `foo.bar.example.com`, and `foo.bar.baz.example.com`, but not `example.com`.

Wildcards must replace complete domain levels; for example, `*foo.example.com` is invalid.