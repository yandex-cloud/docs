# Пример использования {{ message-queue-full-name }} на Laravel

Для работы с очередями PHP-фреймворк [Laravel](https://laravel.com/) предоставляет примитив [Queue](https://laravel.com/docs/6.x/queues). В качестве брокера сообщений можно использовать {{ message-queue-name }}. 

## Установка {#install}

Установите Laravel по [инструкции](https://laravel.com/docs/6.x/installation) на официальном сайте фреймворка.

## Подготовка к работе {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md)%}

Задайте переменные окружения:

```
export AWS_ACCESS_KEY_ID="<идентификатор ключа доступа>"
export AWS_SECRET_ACCESS_KEY="<секретный ключ>"
```

Создайте очередь в сервисе {{ message-queue-name }} и скопируйте ее URL.

## Инструкции {#sample}

В этом примере создается демонстрационная задача (Job), которая суммирует два числа, и команда (Command), которая ставит задачу в очередь.

Чтобы использовать {{ message-queue-name }} с Laravel, выполните следующие инструкции.

1. Создайте тестовый проект `mq_example`:

   ```
   composer create-project --prefer-dist laravel/laravel mq_example
   ```

1. Создайте задачу `Add`:

   ```
   php artisan make:job Add
   ```

1. Откройте файл `/app/Jobs/Add.php` и приведите его к виду:

   ```php
   <?php

   namespace App\Jobs;

   use Illuminate\Bus\Queueable;
   use Illuminate\Queue\SerializesModels;
   use Illuminate\Queue\InteractsWithQueue;
   use Illuminate\Contracts\Queue\ShouldQueue;
   use Illuminate\Foundation\Bus\Dispatchable;

   class Add implements ShouldQueue
   {
       use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

       private $addend1 = null;
       private $addend2 = null;

       /**
        * Create a new job instance.
        *
        * @return void
        */
       public function __construct($addend1, $addend2)
       {
           $this->addend1 = $addend1;
           $this->addend2 = $addend2;
       }

       /**
        * Execute the job.
        */
       public function handle()
       {
           $result = $this->addend1 + $this->addend2;
           print("{$this->addend1} + {$this->addend2} = $result\n");
       }
   }
   ```

1. Создайте новую команду `ScheduleAdd`:

   ```
   php artisan make:command ScheduleAdd
   ```

1. Откройте файл `app/Console/Commands/ScheduleAdd.php` и приведите его к следующему виду:

   ```php
   <?php

   namespace App\Console\Commands;

   use App\Jobs\Add;

   use Illuminate\Console\Command;

   class ScheduleAdd extends Command
   {
       /**
        * The name and signature of the console command.
        *
        * @var string
        */
       protected $signature = 'sample:schedule-add';

       /**
        * The console command description.
        *
        * @var string
        */
       protected $description = 'Command description';

       /**
        * Create a new command instance.
        *
        * @return void
        */
       public function __construct()
       {
           parent::__construct();
       }

       /**
        * Execute the console command.
        *
        * @return mixed
        */
       public function handle()
       {
           Add::dispatch(2, 3);
       }
   }
   ```

1. Откройте файл `config/queue.php` и приведите строку `'default' => env('QUEUE_CONNECTION', 'sync'),` к виду `'default' => 'sqs',`.

1. Заполните параметры в блоке `sqs`.
   
   Чтобы получить значения для параметров `prefix` и `queue`, разделите URL вашей очереди на две части: префиксом будет служить `https://message-queue.{{ api-host }}/`, а параметром очереди `b1gvlrnlei4l5idm9cbj/dj6000000000g53305qi` без `/` в начале.

   ```
   'sqs' => [
       'driver' => 'sqs',
       'key' => env('AWS_ACCESS_KEY_ID'),
       'secret' => env('AWS_SECRET_ACCESS_KEY'),
       'prefix' => env('SQS_PREFIX', 'https://message-queue.{{ api-host }}/'),
       'queue' => env('SQS_QUEUE', 'b1gvlrnlei4l5idm9cbj/dj6000000000g53305qi/laravel-test'),
       'region' => env('AWS_DEFAULT_REGION', '{{ region-id }}'),
   ],
   ```

1. Добавьте в зависимости проекта пакет `aws/aws-sdk-php`:
   
   ```
   composer require aws/aws-sdk-php
   ```

1. Обновите конфигурацию Composer:

   ```
   composer update
   ```

1. Выполните команду:

   ```
   php artisan sample:schedule-add
   ```

1. Выполните команду:

   ```
   php artisan queue:work
   ```