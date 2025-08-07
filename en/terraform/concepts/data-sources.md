# Data sources in {{ TF }}

In {{ TF }}, data sources represent a mechanism for retrieving information about resources, infrastructure, and other objects from various sources. They enable access to data you can then use to create, modify, or delete resources in your infrastructure.

Data sources yield information about existing resources, such as virtual machines, networks, databases, and other infrastructure components. This allows {{ TF }} to automatically adapt its configuration to changes in the actual environment.

Each data source has its own syntax and usage patterns. For example, for local files, you provide the file paths; for HTTP, you provide the URL and query parameters.

With data sources, you can automate your infrastructure management workflow to make sure that your real needs are met. This is of special value in large, complex environments where manual configuration is impractical or impossible.