# Escalations

{% include [escalations-preview](../../../_includes/monitoring/escalations-preview.md) %}


{% include [escalations-definition](../../../_includes/monitoring/escalation-definition.md) %}

An escalation policy can be used as a [notification method](notification-channel.md#channel-parameters) for an alert. You can add one escalation policy to any number of alerts.

There are differences between an escalation and other notification methods:

* You can start an escalation only for alerts with the **Alarm** status.
* The system will iterate over the notification sequence until you stop it.

## Concepts {#intro}

* **Escalation policy**: Sequence of notification steps, delay between them, and other settings.

* **Escalation**: Escalation policy instance initiated by the triggered alert.

* **Escalation plan**: Scheduled (future) notifications within an active escalation. You should define the escalation plan before running the next iteration. If you are editing an ongoing escalation, your changes will take effect starting from the next iteration.

* **Escalation step**: Next notification to send to the recipients.

* **Escalation iteration**: One-time completion of the escalation steps from the first to the last one. A single escalation has a maximum of 10 iterations after which the escalation stops automatically.

* **Escalation history**: List of notifications already sent during this escalation. It includes information about notifications from all iterations and all steps within each iteration.

## Configuring an escalation {#escalation-config}

### Escalation steps {#steps}

The escalation step settings allow you to configure the notification method (transport) and a list of recipients or parameters for integration with an external service, as well as the latency period before the next step if the notification is successful. The number of steps in an escalation is unlimited.

An escalation step is successful if the transport API returns a response within a specified period. For example, a phone call will be successful if the user answers the call and presses `5` in tone dialing mode.

{% note info %}

Pressing a button is required to confirm the call and make sure it is not answered by mistake, e.g., by voicemail, due to an operator error, or accidentally while the phone is in the pocket.

If a step involves multiple recipients, it is considered successful if at least one of them receives the notification.

{% endnote %}

The service makes no more than two attempts to deliver the notification at each step. The response waiting time is five minutes for a phone call and two minutes for other types of notifications. If both attempts fail, the step is marked as failed and the escalation proceeds to the next step.

Failed notification delivery means there was an error during the attempt to send it (transport error). In the case of a phone call, the recipient either did not respond or did not confirm the notification, i.e., did not press `5` in tone dialing mode.

### Delays when sending notifications {#sending-notifications-delay}

* **Initial delay**: First iteration delay when an escalation starts.

  The notification scheduling behavior accounts for all the active escalations and their recipients. The system tries to group notifications by delivery method and send them to the recipient only once. For example, if the same recipient is to get a phone call under multiple concurrent escalations, they will get only one phone call to notify them of all the active escalations.
 
  The initial delay allows you to track and group parallel escalation runs.

* **Delay**: Delay before the next escalation step if a notification is successful.

    {% note warning %}

    For phone calls, the minimum delay is always one minute. The escalation step and initial delay settings are ignored. This enables grouping calls in parallel escalations.
    
    {% endnote %}

    If a step is marked as failed, there will be no delay before the next step. If the current step is the last one in the iteration, the delay before proceeding to the next iteration will take place whether the step is successful or not.


### Stopping an escalation {#escalation-stop}

An escalation may be stopped for the following reasons:

* Recipient answered the call and **pressed 4 in tone dialing mode**.
* Alert that started the escalation no longer has the **Alarm** status.
* User stopped the escalation via the console.

### Notification methods {#notification-methods}

{% include [escalation-channels](../../../_includes/monitoring/escalation-channels.md) %}

## My escalations {#my-escalations-popup}

When you start an escalation in which the current user is the notification recipient, you will see an information window for the active escalation in the {{ monitoring-name }} interface. This window is displayed on all {{ monitoring-name }} pages. If you close the window, it will reopen when you start a new escalation.

{% note info %}

The window only reopens when you start a new escalation. It does not reopen with a new iteration of an active escalation.

{% endnote %}

In the window with escalations, you can do the following:

* Go to the page of the alert that started the escalation.
* Open the notification feed page.
* Stop a running escalation or all running escalations at once.
