module b_coin::b_coin {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct B_COIN has drop {}

    fun init(witness: B_COIN, ctx: &mut TxContext) {
        let (treasury, metadata) =
            coin::create_currency(witness, 18, b"B", b"B Coin", b"B Coin", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx));
    }

    public entry fun mint(treasury_cap: &mut TreasuryCap<B_COIN>, amount: u64, recipient: address, ctx: &mut TxContext) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }

    public entry fun burn(treasury_cap: &mut TreasuryCap<B_COIN>, coin: Coin<B_COIN>) {
        coin::burn(treasury_cap, coin);
    }
}
