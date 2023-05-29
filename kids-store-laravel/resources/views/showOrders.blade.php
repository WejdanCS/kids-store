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
                    <th scope="col">اسم المشتري</th>
                    <th scope="col">رقم الفاتورة</th>
                   
                </tr>
            </thead>
            <tbody>
                @foreach ($ordersObj as $order)
                    <tr>
                        <th scope="row"> {{ $order["id"] }}</th>
                        <td> {{ $order["name"] }}</td>
                        <td> {{ $order["order_id"] }}</td>
                    

                    </tr>
                @endforeach


            </tbody>
        </table>
    </div>
@endsection
