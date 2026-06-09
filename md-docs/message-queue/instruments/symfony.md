# Пример использования Yandex Message Queue на Symfony

PHP-фреймворк [Symfony](https://symfony.com/) содержит компонент [Messenger](https://symfony.com/doc/current/messenger.html) для работы с очередями. В качестве брокера сообщений можно использовать Message Queue.

## Установка {#install}

Потребуются следующие инструменты:
* [Git](https://git-scm.com);
* [PHP](https://php.net) версии 8.2 или выше;
* Менеджер пакетов [Composer](https://getcomposer.org).

Установите Symfony по [инструкции](https://symfony.com/doc/current/setup.html) на официальном сайте фреймворка.

## Подготовка к работе {#prepare}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте роль editor сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md).
1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

Создайте очередь в сервисе Message Queue и скопируйте ее URL.

## Инструкции {#sample}

В этом примере создаются:
* демонстрационное сообщение (Message), в котором хранятся исходные числа;
* обработчик сообщения (MessageHandler), который суммирует два числа из сообщения;
* команда (Command), которая ставит задачу в очередь Message Queue.

Чтобы использовать Message Queue с Symfony Messenger, выполните следующие инструкции:

1. Создайте тестовый проект `mq_example`:

   ```bash
   symfony new --webapp mq_example
   ```

1. Установите зависимости для работы с Amazon SQS. Message Queue использует формат совместимый с SQS:

   ```bash
   composer require symfony/amazon-sqs-messenger async-aws/sqs ^1.9
   ```

1. Создайте сообщение (Message) и обработчик (Handler):

    ```bash
    php bin/console make:message Sum
    ```

    При выполнении команда спросит `Which transport do you want to route your message to? [[no transport]]`.
    Впишите цифру с вариантом `async`.

1. Создайте команду (Command) для отправки сообщений в очередь:

    ```bash
    php bin/console make:command app:create
    ```

1. Откройте созданный файл по пути `src/Command/SumCommand.php` и приведите его к виду:

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

1. Откройте файл по пути `src\Message\Sum.php` и приведите его к виду:

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

1. Откройте файл по пути `src\MessageHandler\SumHandler.php` и приведите его к виду:

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

1. Откройте файл `.env` и найдите в нем строку `MESSENGER_TRANSPORT_DSN=doctrine://default?auto_setup=0`. Приведите ее к следующему виду:
    
    ```text
    MESSENGER_TRANSPORT_DSN=sqs://message-queue.api.cloud.yandex.net/b1gvlrnlei4l********/dj6000000000********/symfony-test?access_key=KEY&secret_key=SECRET&region=ru-central1
    ```

    Часть `b1gvlrnlei4l********/dj6000000000********/symfony-test` нужно заменить на путь, скопированный в консоли Yandex Cloud.

    В параметрах `access_key=KEY` и `secret_key=SECRET` значения `KEY` и `SECRET` нужно заменить на значение статического ключа доступа к Message Queue.

1. Откройте файл `config/packages/messenger.yaml` и приведите его к следующему виду:

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

1. Выполните команду для отправки сообщения в очередь:

    ```bash
    php bin/console  app:create
    ```

1. Выполните команду для обработки очереди:

    ```bash
    php bin/console messenger:consume async
    ```