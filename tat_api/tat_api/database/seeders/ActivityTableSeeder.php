<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Activity;

class ActivityTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        Activity::truncate();
        Activity::create(['code' => '1', 'name' => 'Send to ceramic tank']);
        Activity::create(['code' => '2', 'name' => 'Receive at ceramic tank']);
        Activity::create(['code' => '3', 'name' => 'Complete moisture process']);
        Activity::create(['code' => '4', 'name' => 'Send to retail shop']);
        Activity::create(['code' => '5', 'name' => 'Receive at retail shop']);
        Activity::create(['code' => '6', 'name' => 'Sold to customer']);
    }
}
