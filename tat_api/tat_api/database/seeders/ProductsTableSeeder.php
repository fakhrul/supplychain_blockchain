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
                'code' => $faker->sentence,
                'name' => $faker->sentence,
                'species_id' => '1'
            ]);
        }
    }
}
