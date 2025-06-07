pragma solidity ^0.4.22;

contract ContructorCreateModifiable{
    B b = new B(10);

    function check(){
        assert(b.foo() == 10);
    }

}

contract B{

    uint x_;
    constructor(uint x){
        x_ = x;
    }

    function foo() returns(uint){
        return x_;
    }

    function set_x(uint x){
        x_ = x;
    }
}