# Пример использования {{ message-queue-full-name }} на Symfony

Для работы с очередями PHP-фреймворк [Symfony](https://symfony.com/) содержит компонент [Messenger](https://symfony.com/doc/current/messenger.html). В качестве брокера сообщений можно использовать {{ message-queue-name }}.

## Установка {#install}

Установите Symfony по [инструкции](https://symfony.com/doc/current/setup.html) на официальном сайте фреймворка.

## Подготовка к работе {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md)%}

Создайте очередь в сервисе {{ message-queue-name }} и скопируйте ее URL.

## Инструкции {#sample}

В этом примере создается:
  - демонстрационное сообщение (Message), в котором хранятся исходные числа;
  - обработчик сообщения (MessageHandler), который суммирует два числа из сообщения;
  - команда (Command), которая ставит задачу в очередь {{ message-queue-name }}.

Чтобы использовать {{ message-queue-name }} с Symfony Messenger, выполните следующие инструкции.

1. Создайте тестовый проект `mq_example`:

   ```
   symfony new --webapp mq_example
   ```

1. Установите зависимости для работы с Amazon SQS. {{ message-queue-name }} использует формат совместимый с SQS:

   ```
   composer require symfony/amazon-sqs-messenger async-aws/sqs ^1.9
   ```

   Важно использовать версию библиотеки `async-aws/sqs` не выше `^1.9`, так как она использует XML. Версия 2.0 использует JSON, который в данный момент несовместим с {{ message-queue-name }}.

1. Создайте сообщение (Message) и обработчик (Handler):

    ```
    bin/console make:message Sum
    ```
    При выполнении команда спросит `Which transport do you want to route your message to? [[no transport]]`.
    Впишите цифру с вариантом `async`

1. Создайте команду (Command) для отправки сообщений в очередь:

    ``` 
    bin/console make:command app:create
    ```

1. Откройте созданный файл по пути `src/Command/SumCommand.php` и приведите его к виду:

    ```
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

1. Откройте файл по пути `src\Message\Sum.php` и приведите его к виду:

    ```
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

1. Откройте файл по пути `src\MessageHandler\SumHandler.php` и приведите его к виду:

    ```
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

1. Откройте файл `.env` и найдите в нем строку `MESSENGER_TRANSPORT_DSN=doctrine://default?auto_setup=0`. Приведите ее к следующему виду:
    
    ```
    MESSENGER_TRANSPORT_DSN=sqs://message-queue.{{ api-host }}/b1gvlrnlei4l5idm9cbj/dj6000000000g53305qi/symfony-test?access_key=KEY&secret_key=SECRET&region={{ region-id }}
    ```
    
    Часть `b1gvlrnlei4l5idm9cbj/dj6000000000g53305qi/symfony-test` нужно заменить на путь, скопированный в консоли Yandex Cloud.
    В параметрах `access_key=KEY` и `secret_key=SECRET` значения `KEY` и `SECRET` нужно заменить на значение статического ключа доступа к {{ message-queue-name }}.

1. Откройте файл `config/packages/messenger.yaml` и приведите его к следующему виду:

    ```
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

1. Выполните команду для отправки сообщения в очередь:

    ```bin/console  app:create```

1. Выполните команду для обработки очереди:

    ```bin/console messenger:consume async```
