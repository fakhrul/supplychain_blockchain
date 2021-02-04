<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrackHistory extends Model
{
    use HasFactory;
    protected $fillable = ['info', 'remarks', 'product_id','activity_id','user_id','location_id','gps'];
}
