<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Location;

class LocationTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Location::truncate();
        Location::create(['code' => 'CER', 'name' => '', 'type' => 'Ceramic Tank']);
        Location::create(['code' => 'SHP', 'name' => '', 'type' => 'Retail Shop']);
        Location::create(['code' => 'END', 'name' => '', 'type' => 'End User']);
    }
}
