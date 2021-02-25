<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Web3\Web3;
use Web3\Providers\HttpProvider;
use Web3\RequestManagers\HttpRequestManager;

class EhterueumController extends Controller
{
    //
    public function check()
    {
        $web3 = new Web3(new HttpProvider(new HttpRequestManager('http://localhost:8545')));

        return "hi";
    }
}
