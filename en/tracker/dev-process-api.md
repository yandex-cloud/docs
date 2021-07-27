---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Integrate {{ tracker-name }} with other platforms

Developers have to use various different platforms to build, test, and deploy their apps, among other things. You can use {{ tracker-name }} to find links to related resources or to issues hosted on other platforms, making cross-platform development more convenient. To send information from other platforms to {{ tracker-name }}, use the {{ tracker-name }} API. For more information about the {{ tracker-name }} API features, see the [API reference](about.md).

To transmit data from {{ tracker-name }} to another platform, try sending HTTP requests via [triggers](user/trigger.md).

Let's look at some examples of how you can link {{ tracker-name }} to other platforms.

### Track review code status

Let's say our development team uses Bitbucket as their repository. Once a developer sends a pool request to the repository, their colleagues review the code and either accept or reject the initial pool request. If the request pool is accepted, the developer changes the issue status to <q>Ready for testing</q>. If it was rejected, the status is changed to <q>Needs improvement</q> instead.

You can use the {{ tracker-name }} API to update issue statuses automatically based on the review results. However, this requires creating an intermediate service that would receive event information from Bitbucket, process it, and send requests to the {{ tracker-name }} API. Sample algorithm:

1. The developer makes a pool request and specifies the [issue key](user/create-ticket.md#key) in the comments. This will help us determine which issue needs a status update.

1. Bitbucket must have a web hook set up so that it sends an HTTP request to the intermediate service once the reviewer accepts or rejects a pool request.

1. The intermediate service receives the HTTP request, determines the event type (pool requested accepted or rejected), and retrieves the issue key from the comment left for the pool request.

1. The intermediate service then sends a request to the {{ tracker-name }} API, telling it to update the issue status. The request URL must contain the issue key and the status key. You can find the status key in the {{ tracker-name }} settings on the [**Issue statuses**]({{ link-tracker-statuses }}) tab.

    For request format details, see the [API reference](concepts/issues/new-transition.md).

### Link a test bench to an issue

Test benches are usually used to test new product features. If several product features are being developed concurrently, having a dedicated test bench for each issue makes things more streamlined. Make sure your issues include links to test benches to make finding them easier. This can be done automatically using the {{ tracker-name }} API.

Let's say the team automated test bench generation using a script: the script loads the app code from a separate issue branch, converts it into a Docker image, unpacks the container from that image on a server, and finally launches it.

The same script can be used to add a link to the unpacked bench to the issue. To do this:


1. In {{ tracker-name }}, [create a new issue field called](user/create-param.md#section_pxn_fp4_xgb) <q>Bench link</q>.

1. When developing a new product feature, create a separate branch in the repository that must have the [issue key](user/create-ticket.md#key) specified in its name. This issue key is needed to send a request to the {{ tracker-name }} API.

1. Once the script has deployed the test bench, it sends a request to the {{ tracker-name }} API, adding the bench address to the <q>Bench link</q> issue field. The request URL must contain the issue key, and the request body must contain the key and the new field value. You can find the field key in the {{ tracker-name }} settings on the [**Fields**]({{ link-admin-fields }}) tab.

    For request format details, see the [API reference](concepts/issues/patch-issue.md).

### Send notifications to a messenger

Messengers are a great way to quickly notify employees about important events. If a messenger has an API, you can use {{ tracker-name }} to set up a trigger that sends HTTP requests to the messenger's API when certain events occur. For instance, a request can be triggered once an error with the critical priority status is added to the queue.

To view examples for setting up triggers that send notifications to Slack and Telegram, see [{#T}](messenger.md).

