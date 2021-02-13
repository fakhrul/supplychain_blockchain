<?php

namespace App\Http\Controllers;

use App\Models\TrackHistory;
use Illuminate\Http\Request;

class TrackHistoryController extends Controller
{
    public function index()
    {
        $data = TrackHistory::all();

        $data = TrackHistory::join('products', 'track_histories.product_code', '=', 'products.code')
            ->get(['track_histories.*', 'products.name as products_name']);

        return [
            'recordsTotal' => count($data),
            'recordsFiltered' => count($data),
            'data' => $data,
        ];

    }

    public function show($id)
    {
        $data = TrackHistory::join('products', 'track_histories.product_code', '=', 'products.code')
            ->join('activities', 'track_histories.activity_code', '=', 'activities.code')
            ->join('profiles', 'track_histories.profile_code', '=', 'profiles.code')
            ->join('locations', 'track_histories.location_code', '=', 'locations.code')
            ->get(['track_histories.*',
                'products.name as products_name', 
                'activities.name as activity_name',
                'profiles.name as profile_name',
                'locations.name as location_name'])
            ->where('id', $id);

        return $data;

        return TrackHistory::find($id);
    }

    public function store(Request $request)
    {
        $product = Product::create($request->all());

        return response()->json($product, 201);
    }

    public function update(Request $request, $id)
    {
        $product = Product::findOrFail($id);
        $product->update($request->all());

        return response()->json($product, 200);
    }

    public function delete(Request $request, $id)
    {
        $product = Product::findOrFail($id);
        $product->delete();
        return response()->json(null, 204);
    }
}
