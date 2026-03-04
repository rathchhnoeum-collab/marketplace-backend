<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Message;

class MessageController extends Controller
{

public function send(Request $request)
    {

    $message = Message::create([

    "sender_id"=>$request->sender_id,
    "receiver_id"=>$request->receiver_id,
    "product_id"=>$request->product_id,
    "message"=>$request->message

    ]);

    return response()->json([
    "status"=>"success",
    "message"=>$message
    ]);

    }
    public function chat($product_id)
    {

    $messages = Message::where('product_id',$product_id)->get();

    return response()->json([
    "status"=>"success",
    "messages"=>$messages
    ]);

    }

}