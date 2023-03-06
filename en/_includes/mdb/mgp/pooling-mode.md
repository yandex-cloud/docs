{% if audience != "internal" %}

* **Mode**: `SESSION` (default) or `TRANSACTION`.
* **Size**: Maximum number of client connections.
* **Client Idle Timeout**: Client idle time (in ms), after which the connection will be terminated.

{% else %}

* **Mode**: `SESSION` or `TRANSACTION` (default).
* **Size**: Maximum number of client connections.
* **Client Idle Timeout**: Client idle time (in ms), after which the connection will be terminated.

{% endif %}
