# {{ cloud-logging-name }} overview

{{ cloud-logging-full-name }} is a distributed and highly available system for storing, searching, visualizing, and analyzing logs. The system is part of {{ monium-name }}, which leverages its basic components such as the project model, access management, data model, and unified interface.

{{ cloud-logging-name }} benefits:

* Fast log search that allows you to diagnose errors in real time ([ad-hoc scenarios](https://en.wikipedia.org/wiki/Ad_hoc_testing)).
* Fault tolerance: data is replicated between two data centers. If one of them fails, no data will be lost. If some of the data is fully unavailable for reading, the system can return logs from those currently available.

Get started with {{ cloud-logging-name }}:

* Configure log transfer to {{ cloud-logging-name }} using [{{ unified-agent-short-name }}](quickstart.md).
* Configure log transfer to {{ cloud-logging-name }} using [Fluent Bit](write/fluent-bit.md).