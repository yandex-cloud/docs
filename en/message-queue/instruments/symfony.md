# {{ message-queue-full-name }} use case in Symfony

The [Symfony](https://symfony.com/) PHP framework contains the [Messenger](https://symfony.com/doc/current/messenger.html) component allowing to work with queues. As a message broker, you can use {{ message-queue-name }}.

## Installation {#install}

You will need the following tools:
* [Git](https://git-scm.com)
* [PHP](https://php.net) 8.2 or higher
* [Composer](https://getcomposer.org) package manager

Install Symfony using the [guide](https://symfony.com/doc/current/setup.html) on the framework's official website.

## Getting started {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md) %}

Create a queue in {{ message-queue-name }} and copy the URL.

## Guide {#sample}

In this example, you will create:
* Demo message that stores the source numbers.
* Message handler that sums up two numbers from the message.
* Command that adds a task to the {{ message-queue-name }} queue.

To use {{ message-queue-name }} with Symfony Messenger, follow these steps:

1. Create a test project named `mq_example`:

   ```bash
   symfony new --webapp mq_example
   ```

1. Install dependencies to work with Amazon SQS. {{ message-queue-name }} uses the SQS-compatible format:

   ```bash
   composer require symfony/amazon-sqs-messenger async-aws/sqs ^1.9
   ```

   Make sure to use the `async-aws/sqs` library version `^1.9` or earlier, because it uses XML. Version 2.0 uses JSON, which is currently incompatible with {{ message-queue-name }}.

1. Create a message and a handler:

   ```bash
   php bin/console make:message Sum
   ```

   When running a command, you will get: `Which transport do you want to route your message to? [[no transport]]`.
   Enter a digit with the `async` option.

1. Create a command for delivering messages to a queue:

   ```bash
   php bin/console make:command app:create
   ```

1. Open the `src/Command/SumCommand.php` file and change it as follows:

   ```php
   <?php

   namespace App\Command;

   use App\Message\Sum;
   use Symfony\Component\Console\Attribute\AsCommand;
   use Symfony\Component\Console\Command\Command;
   use Symfony\Component\Console\Input\InputInterface;
   use Symfony\Component\Console\Output\OutputInterface;
   use Symfony\Component\Messenger\MessageBusInterface;

   #[AsCommand(
       name: 'app:create',
       description: 'Add a short description for your command',
   )]
   class CreateCommand extends Command
   {
       public function __construct(private readonly MessageBusInterface $messageBus)
       {
           parent::__construct();
       }

       protected function execute(InputInterface $input, OutputInterface $output): int
       {
           $this->messageBus->dispatch(new Sum(4,2));

           return Command::SUCCESS;
       }
   }
   ```

1. Open the `src\Message\Sum.php` file and change it as follows:

   ```php
   <?php

   namespace App\Message;

   final class Sum
   {
       public function __construct(private readonly int $a, private readonly int $b)
       {
       }

       public function getA(): int
       {
           return $this->a;
       }

       public function getB(): int
       {
           return $this->b;
       }
   }
   ```

1. Open the `src\MessageHandler\SumHandler.php` file and change it as follows:

   ```php
   <?php

   namespace App\MessageHandler;

   use App\Message\Sum;
   use Symfony\Component\Messenger\Attribute\AsMessageHandler;

   #[AsMessageHandler]
   final class SumHandler
   {
       public function __invoke(Sum $message): void
       {
           printf('Sum of %d and %d is %d',
               $message->getA(),
               $message->getB(),
               $message->getA() + $message->getB()
           );
       }
   }

   ```

1. Open the `.env` file and find the `MESSENGER_TRANSPORT_DSN=doctrine://default?auto_setup=0` string in it. Edit it as follows:

   ```text
   MESSENGER_TRANSPORT_DSN=sqs://message-queue.{{ api-host }}/b1gvlrnlei4l********/dj6000000000********/symfony-test?access_key=KEY&secret_key=SECRET&region={{ region-id }}
   ```

   You need to replace `b1gvlrnlei4l********/dj6000000000********/symfony-test` with the path copied in the {{ yandex-cloud }} console.

   In the `access_key=KEY` and `secret_key=SECRET` parameters, replace the `KEY` and `SECRET` values with the value of the {{ message-queue-name }} static access key.

1. Open the `config/packages/messenger.yaml` file and change it as follows:

   ```yaml
   framework:
       messenger:
           failure_transport: failed

           transports:
               # https://symfony.com/doc/current/messenger.html#transport-configuration
               async:
                   dsn: '%env(MESSENGER_TRANSPORT_DSN)%'
                   retry_strategy:
                       max_retries: 3
                       multiplier: 2
               failed: 'doctrine://default?queue_name=failed'
               # sync: 'sync://'

           routing:
               Symfony\Component\Mailer\Messenger\SendEmailMessage: async
               Symfony\Component\Notifier\Message\ChatMessage: async
               Symfony\Component\Notifier\Message\SmsMessage: async
               App\Message\Sum: async

               # Route your messages to the transports
               # 'App\Message\YourMessage': async
   ```

1. Run the command for delivering messages to the queue:

   ```bash
   php bin/console  app:create
   ```

1. Run the command for processing the queue:

   ```bash
   php bin/console messenger:consume async
   ```
