# Index policies

A _policy_ is a set of rules that describes how to manage an index. To work with polocies, you can use the [{{ OS }} Index State Management (ISM)]({{ os.docs }}/im-plugin/ism/index/) plugin.

In a policy, you define:

* _States_ an index can be in. You can specify any names for states. Every policy must have at least one state.
* _Actions_ to perform when an index gets into a certain state. Actions are performed in their given order.
* Conditions to move an index to a different state (_transitions_). Transitions are checked in their given order.

For example, you can define a policy that changes your index state to `read_only` after 30 days and deletes it after 90 days. You can also configure a policy that sends notifications when an index is deleted.

Every policy must have at least one state. Actions and transitions are optional. If you do not specify conditions for a transition, an index is moved to another state by default at the time of verification.

Once a [policy is created and attached to an index](../tutorials/opensearch-index-policy.md), the ISM plugin creates a job that checks the conditions for index transitions and performs the policy actions. By default, a job runs every 5 minutes.

For more information about policies, see the [{{ OS }} documentation]({{ os.docs }}/im-plugin/ism/policies/).
