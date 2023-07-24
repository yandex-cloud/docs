The auto replacement rules are as follows:

* Empty keys or keys that consist of spaces and periods are replaced with underscores: `""`, `" "`, `"."` → `"_"`.
* Periods at the beginning and end of a key are removed: `"somekey."`, `".somekey"` → `"somekey"`.
* If there are two periods in a row or there is a space between them, the entire fragment is replaced with a period: `" some . . key"` → `" some . key"`.

E.g., `". s o m e  ..incorrect....key.    . . "` → `" s o m e  .incorrect.key"`.
