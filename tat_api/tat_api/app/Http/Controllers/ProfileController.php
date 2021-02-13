<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Profile;

class ProfileController extends Controller
{
    public function index()
    {
        $data= Profile::all();
        return [
            'recordsTotal' => count($data),
            'recordsFiltered' => count($data),
            'data' => $data,
        ];

    }

    public function show($id)
    {
        return Profile::find($id);
    }

    public function store(Request $request)
    {
        $obj = Profile::create($request->all());

        return response()->json($obj, 201);
    }

    public function update(Request $request, $id)
    {
        $obj = Profile::findOrFail($id);
        $obj->update($request->all());

        return response()->json($obj, 200);
    }

    public function delete(Request $request, $id)
    {
        $obj = Profile::findOrFail($id);
        $obj->delete();
        return response()->json(null, 204);
    }
}