<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Organization;

class OrganizationController extends Controller
{
    public function index()
    {
        $data= Organization::all();
        return [
            'recordsTotal' => count($data),
            'recordsFiltered' => count($data),
            'data' => $data,
        ];

    }

    public function show($id)
    {
        return Organization::find($id);
    }

    public function store(Request $request)
    {
        $obj = Organization::create($request->all());

        return response()->json($obj, 201);
    }

    public function update(Request $request, $id)
    {
        $obj = Organization::findOrFail($id);
        $obj->update($request->all());

        return response()->json($obj, 200);
    }

    public function delete(Request $request, $id)
    {
        $obj = Organization::findOrFail($id);
        $obj->delete();
        return response()->json(null, 204);
    }
}
