# State

A state describes the configuration of infrastructure that was created or modified using {{ TF }}. Stored in a `.tfstate` file, a state contains information about resources, their attributes, and dependencies between them.

States are used to track changes in infrastructure and ensure consistency between {{ TF }} code and the actual infrastructure. They also enable resource management operations such as updates, deletions, and imports.

## Key functions of states

1. Change tracking. States allow you to track infrastructure changes introduced with the help of {{ TF }} code. This ensures alignment between your code and real-world resources and helps prevent conflicts when performing resource management operations.
1. Consistency. States maintain consistency between {{ TF }} code and actual infrastructure, preventing errors and conflicts during operations.
1. Optimization. States can be used to optimize resource management operations, e.g., by defining dependencies between resources and determining the order in which to create or update them.
1. Security. States contribute to infrastructure security by providing information as to what resources were created or modified using {{ TF }} code and by allowing to control access to this information.

It should be emphasized that states are an important component of using {{ TF }} and as such must be protected from unauthorized access. We recommend you to store your state file in a secure location with proper authentication and authorization mechanisms in place.