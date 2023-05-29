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
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card-body">
                    <form action="{{ route('product.update', $product) }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        @method('patch')

                        <div class="row mb-3">
                            <label for="name" class="col-md-4 col-form-label text-md-end">{{ __('اسم المنتج') }}</label>

                            <div class="col-md-6">
                                <input id="name" type="text"
                                    class="form-control @error('name') is-invalid @enderror" name="name"
                                    value="{{ $product->name }}" required autocomplete="name" autofocus>

                                @error('name')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="description"
                                class="col-md-4 col-form-label text-md-end">{{ __('وصف المنتج') }}</label>

                            <div class="col-md-6">
                                <textarea name="description" id="" cols="1" rows="4" id="description" type="text"
                                    class="form-control @error('description') is-invalid @enderror" name="description" required
                                    autocomplete="description"> {{ $product->description }}</textarea>


                                @error('description')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="price" class="col-md-4 col-form-label text-md-end">{{ __('السعر') }}</label>

                            <div class="col-md-6">
                                <input id="price" type="number"
                                    class="form-control @error('price') is-invalid @enderror" name="price"
                                    value={{ $product->price }} required autocomplete="price" autofocus>

                                @error('price')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="quantity" class="col-md-4 col-form-label text-md-end">{{ __('الكمية') }}</label>

                            <div class="col-md-6">
                                <input id="quantity" type="number"
                                    class="form-control @error('quantity') is-invalid @enderror" name="quantity"
                                    value={{ $product->quantity }} required autocomplete="quantity" autofocus>

                                @error('quantity')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-3">

                            <label for="categories"
                                class="col-md-4 col-form-label text-md-end">{{ __('المجموعة') }}</label>
                            <div class="col-md-6">
                                <select name="categories[]" id="categories" multiple>
                                    @foreach ($categories as $category)
                                        @if ($product->categories->contains('id', $category->id))
                                            <option value="{{ $category->id }}" selected>{{ $category->name }}</option>
                                            @else
                                            <option value="{{ $category->id }}">{{ $category->name }}</option>

                                            @endif
                                      

                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <div class="row my-3">
                            <label for="images" class="col-md-4 col-form-label text-md-end ">اضافة صور للمنتج</label>

                            <br class="m-2">
                            <div class="col-md-6">
                                <input class="form-control" name="files[]" type="file" id="images" multiple />
                                @error('images')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>





                        <div class="row mb-0">
                            <div class="col-md-6 offset-md-4">
                                <button type="submit" class="btn btn-primary">
                                    {{ __('تعديل المنتج') }}
                                </button>
                            </div>
                        </div>
                    </form>

                    @if ($product->images)
                        <h1>صور المنتج</h1>
                        <div class="row">


                            @foreach ($product->images as $image)
                                <div class="col-sm-12 col-md-4 mt-2">
                                    <div class="card">

                                        <!-- Card image -->
                                        <img class="card-img-top" src="{{ url("storage/$image->path") }}" alt="">



                                        <form class="delete-image-form" method="POST"
                                            action="{{ route('image.delete', $image) }}">
                                            @csrf
                                            @method('delete')
                                            <button class="btn btn-danger actions-btn btn-delete-image">حذف</button>

                                        </form>


                                    </div>
                                </div>


                                <!-- Card -->
                            @endforeach
                        </div>
                    @endif
                </div>
            </div>
        </div>

    </div>
@endsection
