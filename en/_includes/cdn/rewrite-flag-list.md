* `break`: Terminates the processing of the current set of directives.
* `last`: Terminates the processing of the current set of directives and starts searching for a new CDN server that matches the new URI.
* `redirect`: Returns a temporary `redirect` with the `302` status code to the user. This flag is used if the replacement string does not start with `http://`, `https://`, or `$scheme`.
* `permanent`: Returns a permanent `redirect` with the `301` status code to the user.