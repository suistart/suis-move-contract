module suistart::suis {
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::option::{Self};

    struct SUIS has drop {}

    fun init(witness: SUIS, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
                witness,
                9,
                b"SUIS",  b"Suistart", b"The Suistart Platform (SUIS) is a comprehensive decentralized platform that is built on the Sui blockchain", option::none(), ctx
        );
        transfer::transfer(treasury, tx_context::sender(ctx));
        transfer::share_object(metadata);
    }

    public entry fun mint(
        treasury_cap: &mut coin::TreasuryCap<SUIS>, ctx: &mut TxContext
    ) {
        assert!(sui::coin::total_supply(treasury_cap) == 0, 1);
        coin::mint_and_transfer(treasury_cap, 100_000_000_000_000_000, tx_context::sender(ctx), ctx)
    }
}