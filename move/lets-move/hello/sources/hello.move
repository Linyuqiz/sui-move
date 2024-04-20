/// Module: hello
module hello::Hello {
    use std::ascii::{String, string};
    use sui::transfer::transfer;

    public struct Hello has key, store {
        id: UID,
        address: address,
        content: String
    }

    fun init(ctx: &mut TxContext) {
        let hello = Hello {
            id: object::new(ctx),
            address: tx_context::sender(ctx),
            content: string(b"Hello, Move!"),
        };
        
        transfer(hello, tx_context::sender(ctx))
    }
}
