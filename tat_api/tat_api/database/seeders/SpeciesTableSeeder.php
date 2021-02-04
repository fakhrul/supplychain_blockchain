<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Species;

class SpeciesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Species::truncate();
        Species::create([
            'code' => '1',
            'name' => 'Species A',
            'description' => 'Species A Description'
        ]);
        Species::create([
            'code' => '2',
            'name' => 'Species B',
            'description' => 'Species B Description'
        ]);

    }
}
