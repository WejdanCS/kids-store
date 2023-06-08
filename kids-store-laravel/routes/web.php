<?php

use App\Http\Controllers\CategoryController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\ImageController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\ProductController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

// Admin routes
Route::group(['middleware'=>['auth','isAdmin'],'prefix'=>'admin'],function(){
    // dashboard for admin
    Route::get('/home', [HomeController::class, 'index'])->name('admin.home');
    // create product
    Route::get("product.create",[ProductController::class,"create"])->name("product.create");
    Route::post("product.create",[ProductController::class,"store"])->name("product.create");

// Read products
Route::get("showProducts",[ProductController::class,"index"])->name("showProducts");
// Read product by id
Route::get("/product/{product}/details",[ProductController::class,"show"])->name("product.details");

// edit product
Route::get("/product/{product}/edit",[ProductController::class,"edit"])->name("product.edit");
Route::patch("/product/{product}/edit",[ProductController::class,"update"])->name("product.update");

// delete product
Route::delete("/product/{product}/delete",[ProductController::class,"destroy"])->name("product.delete");

// image.delete
Route::delete("/image/{image}/delete",[ImageController::class,"destroy"])->name("image.delete");

// category.create
Route::get("/category/create",[CategoryController::class,"create"])->name("category.create");
Route::post("/category/create",[CategoryController::class,"store"])->name("category.create");

// get all categories
Route::get("categories",[CategoryController::class,"index"])->name("categories.index");

// category.edit
Route::get("/category/{category}/edit",[CategoryController::class,"edit"])->name("category.edit");
Route::patch("/category/{category}/edit",[CategoryController::class,"update"])->name("category.update");

// category.delete
Route::delete("/category/{category}/delete",[CategoryController::class,"destroy"])->name("category.delete");
// display all orders
Route::get("orders",[OrderController::class,"index"])->name("orders.index");
});

Auth::routes();

