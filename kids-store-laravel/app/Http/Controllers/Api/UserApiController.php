<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class UserApiController extends Controller
{

    
    public function register(Request $request)
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
        $data=[
            "name"=>$request["name"],
            "email"=>$request["email"],
            "address"=>$request["address"],
            "password"=>$request["password"],
            "password_confirmation"=>$request["password_confirmation"]
        ];
        $validator =Validator::make($data,$rules,$messages );
        if ($validator->fails()) {
            $errors = $validator->errors();
                    return response()->json([
                'success' => false,
                'message' => 'خطأ بعملية التحقق',
                'errors' => $errors,
            ], 422);
        }
         User::create([
            'name' => $request['name'],
            'email' => $request['email'],
            'address'=>$request['address'],
            'password' => Hash::make($request['password']),
        ]);
        return response()->json([
            "status"=>true,
            "message"=>"تم انشاء المستخدم بنجاح"
        ],201);
    }

    public function login(Request $request)
    {
        $rules=[
            'email' => ['required', 'string', 'email', 'max:255'],
            'password' => ['required', 'string', 'min:8'],
        ];
        $messages=[
            'email.required'=>"يجب ادخال البريد الالكتروني",
            'email.string'=>"يجب ادخال البريد الالكتروني كحروف فقط",
            'email.email'=>" يجب ادخال بريد الكتروني صحيح",
            'email.max'=>"يجب ألا يزيد البريد عن 255 حرف",
            'password.required'=>"يجب ادخال كلمة المرور",
            'password.string'=>"يجب ادخال كلمة المرور كنص",
            'password.min'=>"يجب ألاتقل كلمة المرور عن 8 حرف",
        ];
        $data=[
            "email"=>$request["email"],
            "password"=>$request["password"],
        ];
        $validator =Validator::make($data,$rules,$messages );
        if ($validator->fails()) {
            $errors = $validator->errors();
                    return response()->json([
                'success' => false,
                'message' => 'خطأ بعملية التحقق',
                'errors' => $errors,
            ], 422);
        }else{
            if (Auth::attempt($data)) {
                $user = Auth::user();
                $token = $user->createToken('API Token')->plainTextToken;
    
                return response()->json([
                    'success' => true,
                    'message' => 'تم تسجيل الدخول بنجاح',
                    'token' => $token,
                    'user' => $user,
                ], 200);
            }else{
             return   response()->json([
                    'success' => false,
                    'message' => 'فشل تسجيل الدخول',
                    
                ], 401);
            }
    
        }
        
    }
    
}
