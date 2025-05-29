# Index policies

A _policy_ is a set of rules that describes how to manage an index. You can work with policies using the [{{ OS }} Index State Management (ISM)]({{ os.docs }}/im-plugin/ism/index/) plugin.

In a policy, you define:

* _States_ the index can be in. You can name states according to your preference. Each policy must have at least one state.
* _Actions_ to perform when the index enters a particular state. Actions are performed in the order they are listed.
* Conditions for the index to switch to a different state (_transitions_). Transitions are checked in the order they are listed.

For example, you can set up a policy that will make the index `read_only` in 30 days and delete it in 90 days. You can also configure a policy that notifies you when the index is deleted.

Each policy must have at least one state. Actions and transitions are optional. If no transition conditions are specified, the index will switch states unconditionally the moment the check takes place.

Once a [policy is created and linked to the index](../tutorials/opensearch-index-policy.md), the ISM plugin creates a job that checks the index transition conditions and performs the policy actions. By default, the job is performed every 5 minutes.

For more information about policies, see the [{{ OS }} documentation]({{ os.docs }}/im-plugin/ism/policies/).

## Use cases {#examples}

* [{#T}](../tutorials/opensearch-index-policy.md)
