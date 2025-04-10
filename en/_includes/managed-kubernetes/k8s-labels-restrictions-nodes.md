{{ k8s }} label keys of nodes may consist of two parts separated by `/`: prefix and name.

A prefix is an optional part of a key. The prefix requirements are as follows:
* It must be a DNS subdomain, i.e., a series of DNS tags separated by `.`.
* It may be up to 253 characters long.
* The last character must be followed by `/`.

A name is a required part of a key. Follow these naming requirements:
* May be up to 63 characters long.
* It may contain lowercase Latin letters, numbers, and `-_.` symbols.
* Use a letter or number for the first and last characters.

The same rules apply to the value as to the name.

Label example: `app.kubernetes.io/name: mysql`, where `app.kubernetes.io/` is the prefix, `name` is the name, and `mysql`, the value.