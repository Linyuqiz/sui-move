module coin::dcoin {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct DCOIN has drop {}

    fun init(witness: DCOIN, ctx: &mut TxContext) {
        let (treasury, metadata) =
            coin::create_currency(witness, 6, b"D", b"D Coin", b"D Coin", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx));
    }

    public entry fun mint(treasury_cap: &mut TreasuryCap<DCOIN>, amount: u64, recipient: address, ctx: &mut TxContext) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }

    public entry fun burn(treasury_cap: &mut TreasuryCap<DCOIN>, coin: Coin<DCOIN>) {
        coin::burn(treasury_cap, coin);
    }
}
