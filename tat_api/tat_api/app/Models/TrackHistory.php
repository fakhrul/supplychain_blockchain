<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrackHistory extends Model
{
    use HasFactory;
    protected $fillable = ['info', 'remarks', 'product_code','activity_code','profile_code','location_code','gps'];
}
