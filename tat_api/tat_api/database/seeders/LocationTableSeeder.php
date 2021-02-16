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
        Location::create(['code' => 'CER', 'name' => 'Ceramik Tank, Terengganu', 'type' => 'Ceramic Tank', 'organization_code' => '1']);
        Location::create(['code' => 'SHP', 'name' => 'Retail Shop, Terengganu', 'type' => 'Retail Shop', 'organization_code' => '1']);
        Location::create(['code' => 'END', 'name' => 'End User Customer', 'type' => 'End User', 'organization_code' => '1']);
    }
}
