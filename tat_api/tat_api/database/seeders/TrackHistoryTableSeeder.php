<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\TrackHistory;

class TrackHistoryTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        TrackHistory::truncate();
        TrackHistory::create([
            'info' => 'info',
            'remarks' => 'info',
            'product_code' => 'AAA',
            'activity_code' => '1',
            'profile_code' => 'ain@gmail.com',
            'location_code' => 'SHP',
            'gps' => '123,123'
        ]);
        TrackHistory::create([
            'info' => 'info',
            'remarks' => 'info',
            'product_code' => 'AAA',
            'activity_code' => '1',
            'profile_code' => 'fakhrulazran@gmail.com',
            'location_code' => 'END',
            'gps' => '123,123'
        ]);
    }    
}
