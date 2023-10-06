# Version control systems


## {{ GL }} {#gitlab}

In [{{ tracker-name }} issues](../about-tracker.md#zadacha), you can automatically add links to [Merge Requests]({{ gl.docs }}/ee/user/project/merge_requests/) from {{ GL }}. To do this, specify the appropriate issue's [key](../glossary.md#key)in the name or description of a new Merge Request. The links will be placed in [{{ ui-key.startrek.ui_components_issue-links_ExternalLinksCollapse.external-relations}}](../external-links.md).

You can also enable automatic creation of issue comments with information about Merge Requests. Auto comments are only available for [{{ mgl-name }}](../../managed-gitlab/).

{% include [create hook](../../_includes/managed-gitlab/create-hook.md) %}

{% include [test hook](../../_includes/managed-gitlab/test-hook.md) %}

### See also {#see-also}

* [Manual for integrating {{ GL }} with {{ tracker-full-name }}](../../managed-gitlab/tutorials/tracker-integration.md)

