<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\OrderProduct;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class OrderApiController extends Controller
{
 
    public function create(Request $request)
    {
 
     $userId = Auth::id();

     // Add the user ID to the order data
     $validatedData['user_id'] = $userId;

     $orderId = mt_rand(1000, 9999);
     $foundUnique = false;

     while (!$foundUnique) {
         $order = Order::where('order_id', $orderId)->first();
     
         if ($order) {
             // Duplicate order_id found, generate a new one
             $orderId = mt_rand(1000, 9999);
         } else {
             // Unique order_id found, exit the loop
             $foundUnique = true;
         }
     }
     $validatedData["order_id"]=$orderId;
   
     $order=Order::create($validatedData);
     
     $productData=[];
        foreach ($request["products"] as  $product) {
            $productObj=Product::find($product["product_id"]);
            $productData[$product["product_id"]]=['quantity' => $product["quantity"], 'total' => $productObj->price*$product["quantity"]];
        }
        
        $order->products()->attach($productData);

    return response()->json([
        'success' => true,
        'message' => 'تم الطلب بنجاح',
        'data' => $order,
    ], 201);
    }

    public function invoice(Request $request)
    {
        //
        $order=Order::find($request["order_id"]);
        if($order){
            $products=[];
          foreach ( $order->products as $product) {
            $orderProduct=OrderProduct::where('product_id', '=', $product->id)->where("order_id","=",$order->id)
            ->get()->first();
            
            $products[]=[
                "name"=>$product->name,
                "price"=>$product->price,
             
            "quantity"=>$orderProduct->quantity,
            "total"=>$orderProduct->total,

        ];
          }
        return response()->json([
            'success' => true,
        //   "order"=>$order,
            'order_id' => $order->order_id,
            'products' => $products,

        ], 200);
    }else{
        return response()->json([
            'success' => false,
            "message"=>"لايوجد طلب ",
        ], 200);

    }
    }

}
