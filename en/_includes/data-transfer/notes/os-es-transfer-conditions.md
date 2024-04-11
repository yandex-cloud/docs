{% note warning %}

Data delivery to {{ mos-short-name }} target adheres to the `at least once` mode: if the tables being transferred do not have a primary key, duplicate entries can be created in the audit logs.

{% endnote %}