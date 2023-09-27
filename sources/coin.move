module suistart::suis {
    use std::option;
    use std::string;
    use std::ascii;
    use sui::url;
    use sui::coin::{Self, Coin, CoinMetadata, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct SUIS has drop {}

    fun init(witness: SUIS, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
                witness,
                9,
                b"SUIS",  b"SUIS", b"The Suistart Platform (SUIS)", option::some(url::new_unsafe_from_bytes(b"https://suistart.com/img/logo.svg")), ctx
        );
        transfer::public_transfer(treasury, tx_context::sender(ctx));
        transfer::public_share_object(metadata);
    }

    public entry fun mint(
        treasury_cap: &mut coin::TreasuryCap<SUIS>, ctx: &mut TxContext
    ) {
        assert!(sui::coin::total_supply(treasury_cap) == 0, 1);
        coin::mint_and_transfer(treasury_cap, 100_000_000_000_000_000, tx_context::sender(ctx), ctx)
    }

    public entry fun burn(treasury_cap: &mut TreasuryCap<SUIS>, coin: Coin<SUIS>) {
         coin::burn(treasury_cap, coin);
    }

    public entry fun transfer_ownership(
        treasury_cap: TreasuryCap<SUIS>,
        coin: CoinMetadata<SUIS>,
        new_owner: address
     ) {
        transfer::public_transfer(treasury_cap, new_owner);
        transfer::public_transfer(coin, new_owner);
    }

    public entry fun transfer_treasury_owner(
        treasury_cap: TreasuryCap<SUIS>, new_owner: address
    ) {
        transfer::public_transfer(treasury_cap, new_owner)
    }

    public entry fun transfer_coin_owner(
        coin: CoinMetadata<SUIS>, new_owner: address
    ) {
        transfer::public_transfer(coin, new_owner)
    }

    public entry fun update_name(
        treasury_cap: &mut TreasuryCap<SUIS>, metadata: &mut CoinMetadata<SUIS>, new_name: string::String
    ) {
        coin::update_name<SUIS>(treasury_cap, metadata, new_name);
    }

    public entry fun update_description(
        treasury_cap: &mut TreasuryCap<SUIS>, metadata: &mut CoinMetadata<SUIS>, new_description: string::String
    ) {
        coin::update_description<SUIS>(treasury_cap, metadata, new_description);
    }

    public entry fun update_symbol(
        treasury_cap: &mut TreasuryCap<SUIS>, metadata: &mut CoinMetadata<SUIS>, new_symbol: ascii::String
    ) {
        coin::update_symbol<SUIS>(treasury_cap, metadata, new_symbol);
    }

    public entry fun update_icon_url(
        treasury_cap: &mut TreasuryCap<SUIS>, metadata: &mut CoinMetadata<SUIS>, new_url: ascii::String
    ) {
        coin::update_icon_url<SUIS>(treasury_cap, metadata, new_url);
    }
}
