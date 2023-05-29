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
                    <form method="POST" action="{{ route('product.create') }}" enctype="multipart/form-data">
                        @csrf

                        <div class="row mb-3">
                            <label for="name" class="col-md-4 col-form-label text-md-end">{{ __('اسم المنتج') }}</label>

                            <div class="col-md-6">
                                <input id="name" type="text"
                                    class="form-control @error('name') is-invalid @enderror" name="name"
                                    value="{{ old('name') }}" required autocomplete="name" autofocus>

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
                                    class="form-control @error('description') is-invalid @enderror" name="description" value="{{ old('description') }}"
                                    required autocomplete="description"></textarea>


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
                                    value="{{ old('price') }}" required autocomplete="price" autofocus>

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
                                    value="{{ old('quantity') }}" required autocomplete="quantity" autofocus>

                                @error('quantity')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-3">
                              
                        <label for="categories" class="col-md-4 col-form-label text-md-end">{{ __('المجموعة') }}</label>
                        <div class="col-md-6">
                                    <select name="categories[]" id="categories" multiple>
                                               @foreach ($categories as $category)
                                               <option value="{{$category->id}}">{{$category->name}}</option>
                                                   
                                               @endforeach
                                            </select>
                                    </div>            
                                </div>
                        <div class="row mb-3">
                            <label for="images" class="col-md-4 col-form-label text-md-end">اختر صور المنتج</label>

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
                                    {{ __('اضافة المنتج') }}
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
@endsection
