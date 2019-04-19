# Relationship between service resources

The main entity used by the [!KEYREF ig-name] component of [!KEYREF compute-full-name] is an _instance group_.

Each group consists of one or more instances of the same type. Group instances may reside in different availability zones and regions. [Learn more about the Cloud geography](../../overview/concepts/geo-scope.md).

When creating a group, describe the following:

- [[!TITLE]](instance-template.md): specify the required number of vCPUs and amount of RAM.
- [[!TITLE]](policies.md): specify the type of the new group, availability zones, and deployment parameters.

The template will be used to deploy all instances in the group. For a list of available group types, see [[!TITLE]](scale.md).

The instance group created in the folder can be accessed by all instances connected to the same cloud network. [Learn more about networking](../../vpc/).

