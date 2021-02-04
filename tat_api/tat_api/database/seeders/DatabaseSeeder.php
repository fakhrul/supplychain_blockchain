<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();
        $this->call(UsersTableSeeder::class);
        $this->call(ActivityTableSeeder::class);
        $this->call(FarmTableSeeder::class);
        $this->call(LocationTableSeeder::class);
        $this->call(NotificationTableSeeder::class);
        $this->call(RoleTableSeeder::class);
        $this->call(ProfileTableSeeder::class);
        $this->call(SpeciesTableSeeder::class);
        $this->call(ProductsTableSeeder::class);
        $this->call(TrackHistoryTableSeeder::class);
    }
}
