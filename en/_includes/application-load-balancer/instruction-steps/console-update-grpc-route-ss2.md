In the **{{ ui-key.yacloud.alb.label_fqmn }}** field, select one of the options:

* `{{ ui-key.yacloud.alb.label_match-exact }}`: To route requests whose FQMN matches the FQMN specified in the text box on the right.
* `{{ ui-key.yacloud.alb.label_match-prefix }}`: To route requests whose FQMN begins with the prefix specified in the text box on the right. For example, you can specify the first word of the service name: `/helloworld`.
* `{{ ui-key.yacloud.alb.label_match-regex }}`: To route requests whose FQMN matches the [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression) specified in the text box on the right.

{% include [fqmn-slash-warning](./fqmn-slash-warning.md) %}