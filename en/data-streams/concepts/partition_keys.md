# Detailed information about partitions and partition keys

It's easiest to describe the concepts of `partitions` and `partition keys` using a simple real-world example.

Imagine that you're developing a financial app that calculates user account balance. Each time a user tops up their account, debits funds, or makes a purchase, a message with the user ID and the amount of money is generated. The app should decide: allow a purchase if the account balance is positive, otherwise, reject it until the account balance becomes positive.

To meet this challenge, we'll use the "job queue" component. Any messages about changes to the account balance will be written to this queue and our app will handle events from it.

As we're developing a financial app, the order of processing individual messages is critical to us. It's not appropriate if the purchase event arrives before the top-up event, as in this case, the app may reject the purchase due to insufficient funds. There are guaranteed message processing order mechanisms, but they can't ensure a message order within a single queue on an arbitrary amount of data.

{{ yds-full-name }} uses the following approach here: instead of guaranteeing a message order within a queue of any size, {{ yds-full-name }} creates a queue made up of a large number of small independent `partitions`, where the message order is guaranteed. There can be an infinite number of such partitions within a stream. This approach ensures a strict order of reading events under unlimited scaling.

By increasing the number of `partitions`, we can add more data streaming capacity in an arbitrary way. However, at some point, the capacity of a single instance of our app will be insufficient to process data of all customers. To solve this issue, we'll add another instance of the app that will also read data from the queue.

Since two app instances are now reading data from the queue, it may turn out that the top-up event arrives at the first instance, while the debiting event at the second instance, which distorts the user account balance info in each of the instances. As a result, we have no single space where each user's account balance would be known.

To fix this issue, we can save data to a database, enable information exchange between the app instances, or build a distributed cache. There is a more simple method: make sure that all information about operations with the same user's account is always sent to the same app instance. In this case, each app will know the current amount in the account of each customer at any given time and there will be no need to sync data between the app instances.

Information that identifies the source of a message in user terms is called a `partition key` (`PartitionKey`). In our case, the ID of the account whose balance is changing can be used as a `partition key`. When this event is written to {{ yds-full-name }}, {{ yds-full-name }} will, on its own, determine the partition ID (using the hashing function) and write incoming data there. This ensures that any events with the same account will always arrive at the same partition and the only app instance linked to this partition will be handling them in a strict order.