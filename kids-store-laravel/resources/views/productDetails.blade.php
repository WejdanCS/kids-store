@extends('home')
@if (Session::has('success'))
    <div id="add-product" class="alert alert-success">
        <p>{{ Session::get('success') }}</p>
    </div>
@endif

@section('home-content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card-body">

                    <div class="row mb-3">
                        <label for="name" class="col-md-4 col-form-label text-md-end">{{ __('اسم المنتج') }}</label>

                        <div class="col-md-6">
                            <p>{{ $product->name }}</p>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="description" class="col-md-4 col-form-label text-md-end">{{ __('وصف المنتج') }}</label>

                        <div class="col-md-6">
                            <p>{{ $product->description }}</p>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="price" class="col-md-4 col-form-label text-md-end">{{ __('السعر') }}</label>

                        <div class="col-md-4">
                            <p>{{ $product->price }}</p>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="quantity" class="col-md-4 col-form-label text-md-end">{{ __('الكمية') }}</label>

                        <div class="col-md-4">
                            <p>{{ $product->quantity }}</p>
                        </div>
                    </div>
                    <div class="row">
                        <label for="category" class="col-md-4 col-form-label text-md-end">{{ __('المجموعة') }}</label>
                        <div class="col-md-4">

                            <div class="d-flex">
                                @foreach ($product->categories as $category)
                                    <span class="badge rounded-pill bg-primary mx-2">{{ $category->name }}</span>
                                @endforeach
                            </div>



                            {{-- </select> --}}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            {{-- <form action= method="POST">
                                    @csrf --}}
                            <a class="btn btn-secondary actions-btn mt-2"
                                href="{{ route('product.edit', $product) }}">تعديل</a>



                        </div>
                        <div class="col">

                            <form class="delete-product-form" method="POST"
                                action="{{ route('product.delete', $product) }}">
                                @csrf
                                @method('delete')
                                <button class="btn btn-danger actions-btn mt-2 btn-delete-product">حذف</button>

                            </form>

                        </div>
                    </div>









                </div>
            </div>
        </div>

    </div>
@endsection
