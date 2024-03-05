# Integrating {{ tracker-name }} with other platforms

Developers have to use various platforms to build, test, and deploy their apps, among other things. You can use {{ tracker-name }} to find links to related resources or to issues hosted on other platforms, making cross-platform development more convenient. Use the {{ tracker-name }} API to send information from other platforms to {{ tracker-name }}. For more information about the {{ tracker-name }} API features, see the [API reference](about-api.md).

You can transmit data from {{ tracker-name }} to another platform by sending HTTP requests via [triggers](user/trigger.md).

Let's look at some examples of how you can link {{ tracker-name }} to other platforms.

### Tracking the review code status

Suppose that a team uses a Bitbucket repo. When a developer creates a pull request in the repo, their colleagues review the code and accept or reject the pull request. If the pull request is accepted, the developer changes the issue status to {{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.ready.for.test }}; otherwise, to *Needs improvement*.

You can use the {{ tracker-name }} API to update issue statuses automatically based on the review results. However, this requires creating an intermediate service that would receive event information from Bitbucket, process it, and send requests to the {{ tracker-name }} API. Sample algorithm:

1. The developer makes a pool request and specifies the [issue key](user/create-ticket.md#key) in a comment. This way they identify the issue whose status needs to be updated.

1. In Bitbucket, you need to set up a web hook: when the reviewer accepts or rejects the pull request, Bitbucket sends an HTTP request to the intermediate service.

1. The intermediate service receives the HTTP request, determines the event type (whether the pool request was accepted or rejected), and retrieves the issue key from the comment left for the pool request.

1. The intermediate service then sends an issue status change request to the {{ tracker-name }} API. The request URL must include the issue key and the status key. You can find the status key in the {{ tracker-name }} settings on the [**Issue statuses**]({{ link-tracker-statuses }}) tab.

   The request format is described in the [API reference](concepts/issues/new-transition.md).

### Linking a test bench to an issue

Test benches are usually used to test new product features. If you are developing multiple features in parallel, it makes sense to create an independent test bench for each issue. To make it easy to find such a test bench, add a link to it to the issue. This can be done automatically using the {{ tracker-name }} API.

Let's assume your team has a script that automates test bench creation; this script uploads the application code from a specific issue branch, bundles it into a Docker image, and then uses this image to deploy a container on the server and starts it.

You can use the same script to include a link to the deployed test bench in the issue. To do this:


1. [Create a new issue field](user/create-param.md#section_pxn_fp4_xgb) named _Bench link_ in {{ tracker-name }}.


1. When developing a new product feature, create a separate branch in the repository that must have the [issue key](user/create-ticket.md#key) specified in its name. This issue key is needed to send requests to the {{ tracker-name }} API.

1. Once the script has deployed the test bench, it sends a request to the {{ tracker-name }} API adding the bench address to the **Bench link** issue field. The request URL must include the issue key and the request body must include the key and the new field value. You can find the field key in the {{ tracker-name }} settings on the [**Fields**]({{ link-admin-fields }}) tab.

   The request format is described in the [API reference](concepts/issues/patch-issue.md).

### Sending notifications to a messenger

By using messengers, you can quickly notify your employees about important events. If a messenger has an API, you can use {{ tracker-name }} to set up a trigger that sends HTTP requests to the messenger API when certain events occur. For example, this might be handy when a severe error occurs in your queue.

To view examples for setting up triggers that send notifications to Slack and Telegram, see [{#T}](messenger.md).
