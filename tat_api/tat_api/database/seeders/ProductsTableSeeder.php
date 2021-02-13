<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Product;

class ProductsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        Product::truncate();

        $faker = \Faker\Factory::create();
        for ($i = 0; $i < 50; $i++){
            Product::create([
                'code' => $faker->userName,
                'name' => $faker->name,
                'species_code' => '1'
            ]);
        }
        Product::create([
            'code' => 'AAA',
            'name' => $faker->name,
            'species_code' => '1'
        ]);
        Product::create([
            'code' => 'AAB',
            'name' => $faker->name,
            'species_code' => '1'
        ]);


    }
}
