# Example of using {{ message-queue-full-name }} on Laravel

To work with queues, the [Laravel](https://laravel.com/) PHP framework provides the [Queue](https://laravel.com/docs/6.x/queues) primitive. As a message broker, you can use {{ message-queue-name }}.

## Installing {#install}

Install the Laravel software using the [instructions](https://laravel.com/docs/6.x/installation) on the framework's official website.

## Getting started {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md)%}

Set the environment variables:

```
export AWS_ACCESS_KEY_ID="<access key ID>"
export AWS_SECRET_ACCESS_KEY="<secret key>"
```

Create a queue in {{ message-queue-name }} and copy the URL.

## Instructions {#sample}

In this example, we create a demo job that sums up two numbers and a command that adds the job to a queue in {{ message-queue-name }}.

To use {{ message-queue-name }} with Laravel, follow this guide.

1. Create a test project named `mq_example`:

   ```
   composer create-project --prefer-dist laravel/laravel mq_example
   ```

1. Create an `Add` job:

   ```
   php artisan make:job Add
   ```

1. Open the file `/app/Jobs/Add.php` and reformat it as follows:

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

1. Create a new `ScheduleAdd` command:

   ```
   php artisan make:command ScheduleAdd
   ```

1. Open the file `app/Console/Commands/ScheduleAdd.php` and reformat it as follows:

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

1. Open the file `config/queue.php` and change the string `'default' = > env ('QUEUE_CONNECTION', 'sync'),` to `'default' => 'sqs',`.

1. Fill in the parameters in the `sqs` section.

   To get values for the `prefix` and `queue` parameters, split the URL of your queue into two parts: the prefix is `https://message-queue.{{ api-host }}/`, while the queue parameter is `b1gvlrnlei4l5idm9cbj/dj6000000000g53305qi` without the leading `/`.

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

1. Add the `aws/aws-sdk-php` package to the project dependencies:

   ```
   composer require aws/aws-sdk-php
   ```

1. Update the Composer configuration:

   ```
   composer update
   ```

1. Run this command:

   ```
   php artisan sample:schedule-add
   ```

1. Run this command:

   ```
   php artisan queue:work
   ```
