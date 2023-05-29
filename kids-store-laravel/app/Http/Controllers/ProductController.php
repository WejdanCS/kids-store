<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Image;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $products=Product::all();
        // dd($products);
        return view("showProducts",compact("products"));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        $categories=Category::all();
        return view("addProduct",compact("categories"));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // dd($request);
        $product=Product::create([
            "name"=>$request["name"],
            "description"=>$request["description"],
            "price"=>$request["price"],
            "quantity"=>$request["quantity"],
        ]);
        if($request["categories"]!=null){
        $product->categories()->attach($request["categories"]);

        }
        if ($request->hasFile('files')) {
            $files = $request->file('files');
            $i=0;
            foreach ($files as $file) {
                // file name
                $fileName = time()."-$i".".".$file->extension();
                
                // Store the file in the storage/app/public directory
                $file->storeAs('public', $fileName);
                Image::create([
                   "product_id"=>$product->id,
                   "path"=>$fileName
                ]);
                $i++;
            }
        }

        return redirect()->back()->with('success', 'تمت اضافة المنتج بنجاح');
    }

    /**
     * Display the specified resource.
     */
    public function show(Product $product)
    {
        return view("productDetails",compact('product'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Product $product)
    {
        // dd($product->images);
        $categories=Category::all();
        return view("editProduct",compact("product","categories"));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Product $product)
    {
        
        $product->update($request->all());
        $product->categories()->sync($request["categories"]);
        if ($request->hasFile('files')) {
            $files = $request->file('files');
            $i=0;
            foreach ($files as $file) {
                // file name
                $fileName = time()."-$i".".".$file->extension();
                
                // Store the file in the storage/app/public directory
                $file->storeAs('public', $fileName);
                Image::create([
                   "product_id"=>$product->id,
                   "path"=>$fileName
                ]);
                $i++;
            }
        }
        // dd($request);
        return redirect()->back()->with('success', 'تم تحديث المنتج بنجاح');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product)
    {
        
        foreach ($product->images as $image) {
            $path = 'public/' . $image->path;
    
            if (Storage::exists($path)) {
                Storage::delete($path);
                $image->delete();
            }
        }
    
        $product->delete();
        return redirect("showProducts")->with('success', 'تم حذف المنتج بنجاح');
    }
}
