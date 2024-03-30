module desktop::desktop {
    use sui::tx_context::{Self, TxContext};
    use sui::display;
    use sui::object::{Self, UID};
    use sui::package;
    use sui::transfer;
    use std::string::{String, utf8};

    struct DESKTOP has drop {}

    struct DesktopDesc has key, store {
        id: UID,
        name: String,
        desc: String,
    }

    fun init(nft: DESKTOP, ctx: &mut TxContext) {
        let keys = vector[
            utf8(b"name"),
            utf8(b"desc"),
            utf8(b"url")
        ];
        let values = vector[
            utf8(b"desktop"),
            utf8(b"a desktop image"),
            utf8(b"https://img.zeroc0077.cn/avatar.png")
        ];
        let publisher = package::claim(nft, ctx);
        let display = display::new_with_fields<DesktopDesc>(&publisher, keys, values, ctx);
        display::update_version(&mut display);

        let deployer = tx_context::sender(ctx);
        transfer::public_transfer(publisher, deployer);
        transfer::public_transfer(display, deployer);
    }

    public entry fun mint(name: vector<u8>, desc: vector<u8>, recipient: address, ctx: &mut TxContext) {
        let nft = DesktopDesc {
            id: object::new(ctx),
            name: utf8(name),
            desc: utf8(desc),
        };
        transfer::public_transfer(nft, recipient);
    }
}