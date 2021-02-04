<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Farm;

class FarmTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Farm::truncate();
        Farm::create(['code' => '1', 'name' => 'Persatuan Penternak Kelulut Selangor', 'address' => 'Selangor, Malaysia']);
        Farm::create(['code' => '2', 'name' => 'Persatuan Penternak Kelulut Negeri Sembilan', 'address' => 'Negeri Sembilan, Malaysia']);
        Farm::create(['code' => '3', 'name' => 'Persatuan Penternak Kelulut Terengganu', 'address' => 'Terengganu, Malaysia']);
    }
}
