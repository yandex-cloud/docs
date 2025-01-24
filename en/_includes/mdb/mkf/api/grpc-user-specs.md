
* `name`: Username. It may contain Latin letters, numbers, hyphens, and underscores, and must start with a letter or underscore.
* `password`: User password. The password must be from 8 to 128 characters long.
* `permissions`: List of topics the user must have access to.

  The list is arranged as an array of elements. Each element is for a separate topic and has the following structure:

  * `topic_name`: Topic name or name template:
    * `*` to allow access to any topics.
    * Full topic name to allow access to a specific topic.
    * `<prefix>*` to grant access to topics whose names start with the prefix. Let's assume you have topics named `topic_a1`, `topic_a2`, and `a3`. If you put `topic*`, access will be granted to `topic_a1` and `topic_a2`. To include all the cluster's topics, use the `*` mask.
  * `role`: User’s role, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, or `ACCESS_ROLE_ADMIN`. The `ACCESS_ROLE_ADMIN` role is only available if all topics are selected (`topicName: "*"`).
  * `allow_hosts`: (Optional) List of IP addresses the user is allowed to access the topic from, as an array of elements.