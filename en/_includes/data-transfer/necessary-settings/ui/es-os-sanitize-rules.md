The autocorrect rules are as follows:

* Empty keys or keys consisting of spaces and periods will be replaced with underscores: `""`, `" "`, `"."` → `"_"`.
* Leading and trailing periods will be removed: `"somekey."`, `".somekey"` → `"somekey"`.
* If there are two periods in a row or there is nothing but spaces between them, the entire fragment will be replaced with a period: `" some . . key"` → `" some . key"`.

Here is an example of how the autocorrect works: `". s o m e  ..incorrect....key.    . . "` → `" s o m e  .incorrect.key"`.
