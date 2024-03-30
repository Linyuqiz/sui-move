module avatar::avatar {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::display;
    use sui::package;
    use std::string::utf8;
    struct AVATAR has drop {}

    struct AvatarNFT has key,store{
        id: UID,
        tokenId: u64,
        githubName: std::ascii::String,
        image_url_prefixe: std::ascii::String,
    }

    struct State has key {
        id: UID,
        count: u64
    }

    fun init(witness: AVATAR, ctx:&mut TxContext){
        let keys = vector[
            utf8(b"token_id"),
            utf8(b"name"),
            utf8(b"collection"),
            utf8(b"image_url"),
            utf8(b"description")
        ];

        let values = vector[
            utf8(b"GithubNFT #{tokenId}"),
            utf8(b"Github #{githubName}"),
            utf8(b"Github Avatars Collection"),
            utf8(b"{image_url_prefixe}/{githubName}"),
            utf8(b"This is Github User {githubName} Avatar NFT")
        ];

        let publisher = package::claim(witness,ctx);
        let display = display::new_with_fields<AvatarNFT>(&publisher, keys, values, ctx);
        display::update_version(&mut display);
        transfer::public_transfer(publisher, tx_context::sender(ctx));
        transfer::public_transfer(display, tx_context::sender(ctx));

        transfer::share_object(State{
            id: object::new(ctx),
            count: 0
        });
    
    }

    entry public fun mint( state:&mut State,github_name:std::ascii::String, ctx: &mut TxContext){
        let sender = tx_context::sender(ctx);
        state.count = state.count + 1;

        let nft = AvatarNFT {
            id: object::new(ctx),
            tokenId: state.count,
            githubName: github_name,
            image_url_prefixe: std::ascii::string(b"https://avatars.githubusercontent.com/")
        };
        transfer::public_transfer(nft, sender);
    }
}