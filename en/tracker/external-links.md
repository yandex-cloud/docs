# Setting up links to external applications

In {{ tracker-name }} issues, you can add links to objects in external applications, for example, version control systems or third-party issue trackers.

Minimum functionality of links to external applications lets you add and remove links on the {{ tracker-name }} side (using the API or interface), display app icons, object keys (IDs), and link objects in issues.

You can also use advanced link functionality, which requires [external application support](ext-app-setup.md): displaying detailed information about related objects, creating and removing links to external applications upon request from {{ tracker-name }}{% if audience == "internal" %}, displaying suggestions (hints) when adding links through the {{ tracker-name }}{% endif %} user interface.

To enable creating links:

1. [Set up your application for integration with {{ tracker-name }}](ext-app-setup.md):

- Provide network access and authentication.

- If necessary, add support for advanced external link functionality.

1. [Send the {{ tracker-name }} team the data required to register your application](ext-app-info.md). The team will add your application to the list of available ones. After that, you can create links to your application in any {{ tracker-name }} queue.

1. Use the {{ tracker-name }} API to create links to your external application:
- [{#T}](concepts/issues/get-applications.md).
- [{#T}](concepts/issues/get-external-links.md).
- [{#T}](concepts/issues/add-external-link.md).
- [{#T}](concepts/issues/delete-external-link.md).

You can also create links via the user interface if your application's settings allow that.

