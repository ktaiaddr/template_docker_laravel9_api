<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    /**
     * 認証の試行を処理
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function authenticate(Request $request)
    {
        $credentials = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required'],
        ]);

        if (Auth::attempt($credentials)) {
            $request->session()->regenerate();
            return response()->json(['result'=>'ok']);
        }

        return response()->json(['result'=>'ng']);
    }

    public function check(Request $request){

        if (Auth::check()) {
            return response()->json(['result'=>'logined']);
        }

        return response()->json(['result'=>'not logined']);

    }

    public function logout(Request $request){

        Auth::logout();
        return response()->json(['result'=>'logout']);

    }

}
