<?php

use App\Http\Controllers\Api\CategoryApiController;
use App\Http\Controllers\Api\OrderApiController;
use App\Http\Controllers\Api\ProductApiController;
use App\Http\Controllers\Api\UserApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
// products route
Route::middleware('auth:sanctum')->get("products/",[ProductApiController::class,"index"])->name("products");
Route::middleware('auth:sanctum')->get("products/{product}",[ProductApiController::class,"show"])->name("product");
//get All categories
Route::middleware('auth:sanctum')->get("categories/",[CategoryApiController::class,"index"])->name("categories");

// user route
Route::post("register/",[UserApiController::class,"register"])->name("register");
Route::post("login/",[UserApiController::class,"login"])->name("login");

// order
Route::middleware('auth:sanctum')->post("orders/create",[OrderApiController::class,"create"])->name("orders.create")->middleware("auth:sanctum");
Route::middleware('auth:sanctum')->get("orders/invoice",[OrderApiController::class,"invoice"])->name("orders.invoice")->middleware("auth:sanctum");

// 



