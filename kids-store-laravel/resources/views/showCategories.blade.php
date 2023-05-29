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
                    <th scope="col">اسم المجموعة</th>
                    <th scope="col">تحكم</th>

                    
                </tr>
            </thead>
            <tbody>
                @foreach ($categories as $category)
                    <tr>
                        <th scope="row"> {{ $category->id }}</th>
                        <td> {{ $category->name }}</td>
                        

                        
                        <td>
                            <div class="row">
                                <div class="col">
                                    {{-- <a class="btn btn-info actions-btn mt-2"
                                        href="{{ route('category.details', $category) }}">تفاصيل </a> --}}

                                </div>
                                <div class="col">
                                  
                                    <a class="btn btn-secondary actions-btn mt-2"
                                        href="{{ route('category.edit', $category) }}">تعديل</a>



                                </div>
                                <div class="col">
                                    <form  class="delete-product-form" method="POST"  action="{{route("category.delete",$category)}}">
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
