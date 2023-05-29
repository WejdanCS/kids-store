@extends('home')
@if (Session::has('success'))
    <div id="add-product" class="alert alert-success">
       <p>{{ Session::get('success') }}</p> 
    </div>
@endif
@if (Session::has('fail'))
    <div id="add-product" class="alert alert-danger">
       <p>{{ Session::get('fail') }}</p> 
    </div>
@endif


@section('home-content')
    <div class="container">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">اسم المنتج</th>
                    <th scope="col">السعر</th>
                    <th scope="col">الكمية</th>
                    <th scope="col">تحكم</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($products as $product)
                    <tr>
                        <th scope="row"> {{ $product->id }}</th>
                        <td> {{ $product->name }}</td>
                        <td> {{ $product->price }}</td>
                        <td> {{ $product->quantity }}</td>
                        <td>
                            <div class="row">
                                  <div class="col">
                                    <a class="btn btn-info actions-btn mt-2" href="{{route("product.details",$product)}}">تفاصيل </a>

                                  </div>
                                  <div class="col">
                                    {{-- <form action= method="POST">
                                    @csrf --}}
                                    <a class="btn btn-secondary actions-btn mt-2" 
                                    href="{{route("product.edit",$product)}}" >تعديل</a>

                                   

                                  </div>
                                  <div class="col">
                                  
                                    <form  class="delete-product-form" method="POST"  action="{{route("product.delete",$product)}}">
                                                @csrf
                                                @method("delete")
                                                <button class="btn btn-danger actions-btn mt-2 btn-delete-product" >حذف</button>

                                    </form>

                                  </div>

                                  
                              

                                 
                                  

                                  

                                


                            </div>
                        </td>

                    </tr>
                @endforeach


            </tbody>
        </table>
    </div>
@endsection
