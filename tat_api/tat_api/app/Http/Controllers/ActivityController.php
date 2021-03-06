<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Activity;

class ActivityController extends Controller
{
    public function index()
    {
        $data = Activity::all();

        return [
            'recordsTotal' => count($data),
            'recordsFiltered' => count($data),
            'data' => $data,
        ];

    }

    public function show($id)
    {
        return Activity::find($id);
    }

    public function store(Request $request)
    {
        $product = Activity::create($request->all());

        return response()->json($product, 201);
    }

    public function update(Request $request, $id)
    {
        $product = Activity::findOrFail($id);
        $product->update($request->all());

        return response()->json($product, 200);
    }

    public function delete(Request $request, $id)
    {
        $product = Activity::findOrFail($id);
        $product->delete();
        return response()->json(null, 204);
    }
}
