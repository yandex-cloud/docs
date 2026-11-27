---
title: Tracking data lineage in {{ datalens-platform-full-name }}
description: Follow this guide to analyze the full path of data from connection to visualization and reports in {{ datalens-platform-full-name }}.
alternate:
  - href: en/datalens/datalens-platform/operations/data-catalog/metadata-linage.md
    type: text/markdown
    title: Markdown version
---

# Analyzing data lineage

{{ datalens-platform-full-name }} implements the ability to track links between metadata (data lineage). It allows you to document and visualize the full path of data from connection to destination (dashboard, chart, or report), including all transformations, migrations, and processing operations. Key advantages of data lineage:

* Transparency and data authenticity guarantee.
* Compliance with regulatory requirements for tracking origin of data, its transformation, and access to it.
* Improvement of data quality by detecting non-compliance with business rules.
* Efficient reuse of data and ability to reproduce experiments.


To view links between metadata:

1. Go to the ![image](../../../../_assets/console-icons/folder-magnifier.svg) **Metadata** section, **Resource catalog** tab.
1. In the **RESOURCES** list, select the dataset you need.
1. In the dataset view panel, go to the **Links** tab.
1. Specify link display depth. Optionally, enable display of additional links and personal data.
1. To view links between database columns, expand the list of columns in the object of interest.

Use the navigation and zoom controls to move around the graph.

You can export the links between objects to a file. Click **Download** above the graph and select the format: **CSV** or **JSON**.

To view overall graph of links, open the [Links and processes](work-with-data-catalog.md#view-metadata-processes) section.
