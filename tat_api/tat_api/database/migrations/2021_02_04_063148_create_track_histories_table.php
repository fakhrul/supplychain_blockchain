<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTrackHistoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('track_histories', function (Blueprint $table) {
            $table->id();
            $table->string('info');
            $table->string('remarks');
            $table->string('product_code');
            $table->string('activity_code');
            $table->string('profile_code');
            $table->string('location_code');
            $table->string('gps');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('track_histories');
    }
}
