<?php

use App\Http\Controllers\ProductController;
use App\Http\Controllers\SpeciesController;
use App\Http\Controllers\LocationController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\TrackHistoryController;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
 */

/*
200: OK. The standard success code and default option.
201: Object created. Useful for the store actions.
204: No content. When an action was executed successfully, but there is no content to return.
206: Partial content. Useful when you have to return a paginated list of resources.
400: Bad request. The standard option for requests that fail to pass validation.
401: Unauthorized. The user needs to be authenticated.
403: Forbidden. The user is authenticated, but does not have the permissions to perform an action.
404: Not found. This will be returned automatically by Laravel when the resource is not found.
500: Internal server error. Ideally you're not going to be explicitly returning this, but if something unexpected breaks, this is what your user is going to receive.
503: Service unavailable. Pretty self explanatory, but also another code that is not going to be returned explicitly by the application.
 */
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

// Products API
// Route::group(['middleware' => 'auth:api'], function() {
Route::get('/product', [ProductController::class, 'index']);
Route::get('/product/{id}', [ProductController::class, 'show']);
Route::post('/product', [ProductController::class, 'store']);
Route::put('/product/{id}', [ProductController::class, 'update']);
Route::delete('/product/{id}', [ProductController::class, 'delete']);

Route::get('/species', [SpeciesController::class, 'index']);
Route::get('/species/{id}', [SpeciesController::class, 'show']);
Route::post('/species', [SpeciesController::class, 'store']);
Route::put('/species/{id}', [SpeciesController::class, 'update']);
Route::delete('/species/{id}', [SpeciesController::class, 'delete']);

Route::get('/location', [LocationController::class, 'index']);
Route::get('/location/{id}', [LocationController::class, 'show']);
Route::post('/location', [LocationController::class, 'store']);
Route::put('/location/{id}', [LocationController::class, 'update']);
Route::delete('/location/{id}', [LocationController::class, 'delete']);

Route::get('/profile', [ProfileController::class, 'index']);
Route::get('/profile/{id}', [ProfileController::class, 'show']);
Route::post('/profile', [ProfileController::class, 'store']);
Route::put('/profile/{id}', [ProfileController::class, 'update']);
Route::delete('/profile/{id}', [ProfileController::class, 'delete']);

Route::get('/role', [RoleController::class, 'index']);
Route::get('/role/{id}', [RoleController::class, 'show']);
Route::post('/role', [RoleController::class, 'store']);
Route::put('/role/{id}', [RoleController::class, 'update']);
Route::delete('/role/{id}', [RoleController::class, 'delete']);

Route::get('/trackhistory', [TrackHistoryController::class, 'index']);
Route::get('/trackhistory/{id}', [TrackHistoryController::class, 'show']);
Route::post('/trackhistory', [TrackHistoryController::class, 'store']);
Route::put('/trackhistory/{id}', [TrackHistoryController::class, 'update']);
Route::delete('/trackhistory/{id}', [TrackHistoryController::class, 'delete']);


// });
