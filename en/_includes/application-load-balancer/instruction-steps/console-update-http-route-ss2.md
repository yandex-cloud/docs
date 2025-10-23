In the **{{ ui-key.yacloud.alb.label_path }}** field, select one of the options:

* `{{ ui-key.yacloud.alb.label_match-exact }}`: To route requests with the same path as the one specified in the text box on the right. For example, to route all requests, specify the `/` path.
* `{{ ui-key.yacloud.alb.label_match-prefix }}`: To route requests whose path begins with the prefix specified in the text box on the right.
* `{{ ui-key.yacloud.alb.label_match-regex }}`: To route requests whose path matches the [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression) specified in the text box on the right, e.g., `[a-z]{10}[0-9]{3}`.