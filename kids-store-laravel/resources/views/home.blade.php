@extends('layouts.app')
@section('content')
<div class="container">
    <div class="row">
        <div class="col-sm-12 col-md-3 p-3 mb-2 primary-bg-color rounded text-dark mt-2">
            <h1 class="h1 text-white">لوحة التحكم</h1>
            <hr class="text-white">
            <br>
          <div class="d-flex flex-column">
            <a class="text-white text-decoration-none tab" href="{{route("showProducts")}}">عرض المنتجات</a>
          
            <a class="text-white text-decoration-none tab" href="{{route("product.create")}}">اضافة منتج جديد</a>
            <a class="text-white text-decoration-none tab" href="{{route("category.create")}}">اضافة مجموعة جديدة</a>
            <a class="text-white text-decoration-none tab" href="{{route("categories.index")}}"> عرض المجموعات</a>
            
            <a class="text-white text-decoration-none tab" href="{{route("orders.index")}}"> عرض الطلبات</a>

        </div>
        </div>
        <br>
        <div class="col-sm-12 col-md-8 p-3 mb-2 grey-bg-color rounded text-dark mt-2">
          
                  @yield("home-content")
           
      
         </div>
    </div>
  
</div>
@endsection
