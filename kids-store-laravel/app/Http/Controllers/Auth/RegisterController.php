<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Providers\RouteServiceProvider;
use App\Models\User;
use Illuminate\Foundation\Auth\RegistersUsers;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class RegisterController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Register Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles the registration of new users as well as their
    | validation and creation. By default this controller uses a trait to
    | provide this functionality without requiring any additional code.
    |
    */

    use RegistersUsers;

    /**
     * Where to redirect users after registration.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest');
    }

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        $rules=[
            'name' => ['required', 'string', 'max:10'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
            'address'=>['required', 'string', 'min:8','max:255']
        
        ];
        $messages=[
            'name.required'=>"يجب ادخال الاسم",
            'name.string'=>"يجب ادخال الاسم كحروف فقط",
            'name.max'=>"يجب ألا يزيد الاسم عن 10 حرف",
            'email.required'=>"يجب ادخال البريد الالكتروني",
            'email.string'=>"يجب ادخال البريد الالكتروني كحروف فقط",
            'email.email'=>" يجب ادخال بريد الكتروني صحيح",
            'email.max'=>"يجب ألا يزيد البريد عن 255 حرف",
            'email.unique'=>"هذا البريد مستخدم من قبل",

            'password.required'=>"يجب ادخال كلمة المرور",
            'password.string'=>"يجب ادخال كلمة المرور كنص",
            'password.min'=>"يجب ألاتقل كلمة المرور عن 8 حرف",
            'password.confirmed'=>"لايوجد تطابق بين كلمات المرور المدخلة",
            'address.required'=>"يجب ادخال العنوان",
            'address.string'=>"يجب ادخال العنوان كحروف فقط",
            'address.min'=>"يجب ألايقل العنوان عن 8 حرف",
            'address.max'=>"يجب ألا يزيد الاسم عن 255 حرف",
        ];
        return Validator::make($data,$rules,$messages );
    }

    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array  $data
     * @return \App\Models\User
     */
    protected function create(array $data)
    {
        return User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'address'=>$data['address'],
            'password' => Hash::make($data['password']),
        ]);
    }
}
