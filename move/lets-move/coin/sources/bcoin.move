module coin::bcoin {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct BCOIN has drop {}

    fun init(witness: BCOIN, ctx: &mut TxContext) {
        let (treasury, metadata) =
            coin::create_currency(witness, 10, b"B", b"B Coin", b"B Coin", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx));
    }

    public entry fun mint(treasury_cap: &mut TreasuryCap<BCOIN>, amount: u64, recipient: address, ctx: &mut TxContext) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }

    public entry fun burn(treasury_cap: &mut TreasuryCap<BCOIN>, coin: Coin<BCOIN>) {
        coin::burn(treasury_cap, coin);
    }
}
