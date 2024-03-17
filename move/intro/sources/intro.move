module intro::intro {
    use std::string::String;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct Intro has key, store {
        id: UID,
        user: address,
        desc: String
    }

    #[lint_allow(self_transfer)]
    public fun mint(desc: String, ctx: &mut TxContext) {
        let object = Intro {
            id: object::new(ctx),
            user: tx_context::sender(ctx),
            desc: desc,
        };
        transfer::public_transfer(object, tx_context::sender(ctx));
    }

    public fun look(profile: &Intro, ctx: &mut TxContext): String {
        assert!(profile.user == tx_context::sender(ctx), 0);
        profile.desc
    }
}