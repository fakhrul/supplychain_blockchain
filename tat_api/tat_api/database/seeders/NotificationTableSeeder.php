<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Notification;

class NotificationTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Notification::truncate();
        Notification::create(['title' => 'Product arrive at ceramic tank', 'information' => 'Product id = 1']);
        Notification::create(['title' => 'Product arrive at ceramic tank', 'information' => 'Product id = 2']);
        Notification::create(['title' => 'Product arrive at ceramic tank', 'information' => 'Product id = 3']);
    }
}
