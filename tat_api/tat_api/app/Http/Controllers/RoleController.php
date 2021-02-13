<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Role;

class RoleController extends Controller
{
    public function index()
    {
        $data= Role::all();
        return [
            'recordsTotal' => count($data),
            'recordsFiltered' => count($data),
            'data' => $data,
        ];

    }

    public function show($id)
    {
        return Role::find($id);
    }

    public function store(Request $request)
    {
        $obj = Role::create($request->all());

        return response()->json($obj, 201);
    }

    public function update(Request $request, $id)
    {
        $obj = Role::findOrFail($id);
        $obj->update($request->all());

        return response()->json($obj, 200);
    }

    public function delete(Request $request, $id)
    {
        $obj = Role::findOrFail($id);
        $obj->delete();
        return response()->json(null, 204);
    }
}
