<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Profile;

class ProfileTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        Profile::truncate();
        Profile::create([
            'name' => 'Fakhrul Azran',
            'email' => 'fakhrulazran@gmail.com',
            'password' => 'abc123',
            'role_id' => '1'
        ]);
        Profile::create([
            'name' => 'Ainnur',
            'email' => 'ainnur@gmail.com',
            'password' => 'abc123',
            'role_id' => '2'
        ]);
        Profile::create([
            'name' => 'Ain',
            'email' => 'ain@gmail.com',
            'password' => 'abc123',
            'role_id' => '3'
        ]);
    }
}
