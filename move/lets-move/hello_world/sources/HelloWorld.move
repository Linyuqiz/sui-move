module hello_move::HelloWorld {
    use std::ascii::{String, string};
    use sui::object::{Self, UID};
    use sui::transfer::transfer;
    use sui::tx_context::{Self, TxContext};

    struct HelloWorld has key, store {
        id: UID,
        address: address,
        say: String
    }

    fun init(ctx: &mut TxContext) {
        let helloWorld = HelloWorld {
            id: object::new(ctx),
            address: tx_context::sender(ctx),
            say: string(b"Hello World, Move!"),
        };
        transfer(helloWorld, tx_context::sender(ctx))
    }
}