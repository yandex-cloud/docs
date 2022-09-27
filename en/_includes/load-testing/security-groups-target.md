1. [Create](../../vpc/operations/security-group-create.md) a security group named `load-target-sg` for the test target.

1. [Add a rule](../../vpc/operations/security-group-add-rule.md) for incoming traffic during load generation to the test target:
    * Port range: `{{ port-any }}`.
    * Protocol: `Any`.
    * Source type: `Security group`.
    * Destination: `From list`. Specify the security group where the test agent is located.

    This rule will allow agents to load this target or connect additional monitoring tools.

