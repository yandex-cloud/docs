1. [Create](../../vpc/operations/security-group-create.md) a security group named `agent-sg`.
1. [Add rules](../../vpc/operations/security-group-add-rule.md):
    1. A rule for outgoing HTTPS traffic to the public {{ load-testing-full-name }} API:
        * Port range: `443`.
        * Protocol: `TCP`.
        * Source type: `CIDR`.
        * Destination: `0.0.0.0/0`.

        This will enable you to connect the agent to {{ load-testing-name }} to manage tests from the interface and get test results.

    1. A rule for incoming SSH traffic:
        * Port range: `22`.
        * Protocol: `TCP`.
        * Source type: `CIDR`.
        * Destination: `0.0.0.0/0`.

        This will let you connect to the agent via SSH and manage tests from the console or collect debugging information.

    1. A rule for outgoing traffic during load generation to the test target:
        * Port range: `{{ port-any }}`.
        * Protocol: `Any`.
        * Source type: `Security group`.
        * Destination: `From list`. Specify the security group where the test target is located.

        Create this rule for each test target with a unique security group.

