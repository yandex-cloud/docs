
* `name`: Username. It may contain Latin letters, numbers, hyphens, and underscores, and must start with a letter or underscore.
* `password`: User password. The password must be from 8 to 128 characters long.
* `permissions`: List of topics the user should have access to.

  The list appears as an array of elements. one per topic. Each element has the following structure:

  * `topic_name`: Topic name or name pattern:
    * `*`: To allow access to all topics.
    * Full topic name: To allow access to a specific topic.
    * `<prefix>*`: To grant access to topics whose names start with the specified prefix. Let’s assume you have topics named `topic_a1`, `topic_a2`, and `a3`. If you specify `topic*`, access will be granted to `topic_a1` and `topic_a2`. To cover all cluster's topics, use `*`.
  * `role`: User’s role, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, or `ACCESS_ROLE_ADMIN`. The `ACCESS_ROLE_ADMIN` role is only available if all topics are selected (`topicName: "*"`).
  * `allow_hosts` (optional): List of IP addresses the user is allowed to access the topic from, as an array of elements.