The following restrictions apply to HTTP headers when using the [EdgeCDN provider](../../cdn/concepts/providers.md):
* The HTTP header name may contain Latin letters (`A-Z` and `a-z`), numbers (`0-9`), underscores (`_`), and hyphens (`-`).
* The HTTP header value:
    * Must start with a Latin letter (`A-Z` or `a-z`), number (`0-9`), asterisk (`*`), or opening curly bracket (`{`) and may only contain characters with 32 to 126 ASCII codes, except for the backslash (`\`), dollar sign (`$`), and single quotation mark (`'`).
    * May not begin or end with a space.
    * May contain Latin letters (`A-Z` and `a-z`), numbers (`0-9`), underscores (`_`), dots (`.`), slashes (`/`), colons (`:`), hyphens (`-`), equal signs (`=`),and spaces (` `).
    * May contain only single spaces between any two characters.
    * May not contain the `websocket` or `upgrade` values.
    * May not contain more than 512 characters.
