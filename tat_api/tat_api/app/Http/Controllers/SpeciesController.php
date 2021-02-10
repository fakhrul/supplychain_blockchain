<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Species;

class SpeciesController extends Controller
{
    public function index()
    {
        return Species::all();
    }

    public function show($id)
    {
        return Species::find($id);
    }

    public function store(Request $request)
    {
        $obj = Species::create($request->all());

        return response()->json($obj, 201);
    }

    public function update(Request $request, $id)
    {
        $obj = Species::findOrFail($id);
        $obj->update($request->all());

        return response()->json($obj, 200);
    }

    public function delete(Request $request, $id)
    {
        $obj = Species::findOrFail($id);
        $obj->delete();
        return response()->json(null, 204);
    }
}
