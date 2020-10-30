# Policies for automatically deleting Docker images

A [Docker image](docker-image.md) lifecycle policy lets you set rules for automatically deleting Docker images.

You can only set a lifecycle policy for each individual [repository](repository.md). This policy only applies to Docker images with names exactly matching the repository name. There is no support for prefix matching (nested repositories). You can't set a policy for a repository group, registry, folder, or cloud.

## Lifecycle policy statuses {#status}

{% note info %}

The default policy is created with the `DISABLED` status.

{% endnote %}

A lifecycle policy can have the following statuses:

* `ACTIVE`: The policy is active and regularly deletes Docker images according to the rules you set.
* `DISABLED`: The policy is disabled and doesn't delete Docker images from a repository. You can use policies in this status to create and test rules.

A repository can only have one active policy and several disabled ones. You can disable the active policy at any time.

For both active and disabled policies, you can perform [dry runs](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) to check which Docker images will be deleted according to the rules.

## Lifecycle policy rules {#lifecycle-rules}

Before deleting Docker images, they're filtered by tag and then checked for compliance.

{% note warning %}

Specify at least one tag-based filter and set at least one delete condition.

{% endnote %}

To configure the lifecycle policy, set the following parameters:

1. Filtering Docker images by tag:
    * `tag_regexp`: Flag for specifying a filter as a regular expression.

        A `.*` regular expression for `tag_regexp` means <q>all images with tags</q>. To make the rule apply to images without tags, explicitly set the `untagged` flag.

    * `untagged`: Flag indicating that the rule applies to Docker images without tags.
2. Conditions for deleting Docker images:
    * `expire_period`: The period of time that must pass after creating a Docker image for it to suit the automatic deletion criteria. It must be a multiple of 24 hours.
    * `retained_top`: The number of Docker images (meeting the specified tag-based filter conditions) to be retained even if the `expire_period` already expired.

## Resolving rule conflicts {#resolve}

* If a Docker image filtered by tag only falls under a single delete rule, it's deleted according to the settings of this rule.
* If a Docker image filtered by tag falls under several conflicting rules, it's deleted only if all the rules require it. If there is at least one rule saying that a Docker image shouldn't be deleted, it's retained.