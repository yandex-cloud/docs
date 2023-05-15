{% note warning %}

Data delivery to {{ mes-short-name }} and {{ mos-short-name }} targets adheres to the `at least once` mode: if the tables being transferred do not have a primary key, duplicate entries can be created in the audit logs.

{% endnote %}