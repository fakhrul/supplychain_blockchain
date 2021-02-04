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
            'product_id' => '1',
            'activity_id' => '1',
            'user_id' => '1',
            'location_id' => '1',
            'gps' => '123,123'
        ]);
        TrackHistory::create([
            'info' => 'info',
            'remarks' => 'info',
            'product_id' => '1',
            'activity_id' => '1',
            'user_id' => '1',
            'location_id' => '1',
            'gps' => '123,123'
        ]);
    }    
}
