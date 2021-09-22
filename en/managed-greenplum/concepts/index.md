# Relationship between service resources

The main entity used in {{ mgp-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. [More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

When creating a cluster, specify:

* _Host class_: A VM template for deploying the cluster hosts. {% if audience == "draft" %}For a list of available host classes and their characteristics, see [{#T}](instance-types.md).{% endif %}

* _Environment_: The environment where the cluster will be deployed:
    * `PRODUCTION`: For stable versions of your apps.
    * `PRESTABLE`: For testing, including the {{ mgp-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

{% if audience != "internal" %} 
A database cluster created in a folder can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).
{% endif %}

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

