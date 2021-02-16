<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Organization;

class OrganizationTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Organization::truncate();
        Organization::create(['code' => '1', 'name' => 'Persatuan Penternak Kelulut Selangor', 'address' => 'Selangor, Malaysia']);
        Organization::create(['code' => '2', 'name' => 'Persatuan Penternak Kelulut Negeri Sembilan', 'address' => 'Negeri Sembilan, Malaysia']);
        Organization::create(['code' => '3', 'name' => 'Persatuan Penternak Kelulut Terengganu', 'address' => 'Terengganu, Malaysia']);
    }
}
