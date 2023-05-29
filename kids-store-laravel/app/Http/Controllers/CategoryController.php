<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;


class CategoryController extends Controller
{


    protected function validator(array $data)
    {
        $rules=[
            'name' => ['required', 'string', 'max:15'],
           
        
        ];
        $messages=[
            'name.required'=>"يجب ادخال الاسم",
            'name.string'=>"يجب ادخال الاسم كحروف فقط",
            'name.max'=>"يجب ألا يزيد الاسم عن 15 حرف",
            
        ];
        return Validator::make($data,$rules,$messages );
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $categories=Category::all();
        return view("showCategories",compact("categories"));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view("create_category");
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        Category::create([
            "name"=>$request["name"]
        ]);
        return redirect()->back()->with('success', 'تمت اضافة المجموعة بنجاح');

        
    }

    /**
     * Display the specified resource.
     */
    public function show(Category $category)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Category $category)
    {
        return view("editCategory",compact("category"));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Category $category)
    {
        $category->update($request->all());
        return redirect()->back()->with('success', 'تم تحديث المجموعة بنجاح');

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Category $category)
    {
        $category->products()->detach();
        $category->delete();
        return redirect()->back()->with('success', 'تم حذف المجموعة بنجاح');
    }
}
