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
            'code' => 'fakhrulazran@gmail.com',
            'name' => 'Fakhrul Azran',
            'email' => 'fakhrulazran@gmail.com',
            'password' => 'abc123',
            'role_code' => 'ADM',
            'organization_code' => '1',
        ]);
        Profile::create([
            'code' => 'ainnur@gmail.com',
            'name' => 'Ainnur',
            'email' => 'ainnur@gmail.com',
            'password' => 'abc123',
            'role_code' => 'UPD',
            'organization_code' => '1',
        ]);
        Profile::create([
            'code' => 'ain@gmail.com',
            'name' => 'Ain',
            'email' => 'ain@gmail.com',
            'password' => 'abc123',
            'role_code' => 'UPD',
            'organization_code' => '1',
        ]);
    }
}
