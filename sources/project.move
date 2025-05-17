module HelloMessage::validator {
    use std::string::{String};
    use std::signer;
    use aptos_framework::account;
    use aptos_framework::timestamp;
    
    // Error codes
    const E_PRODUCT_ALREADY_EXISTS: u64 = 1;
    const E_PRODUCT_NOT_FOUND: u64 = 2;
    const E_NOT_AUTHORIZED: u64 = 3;
    
    // Product resource that stores authentication details
    struct Product has key, store {
        id: String,
        manufacturer: address,
        timestamp: u64,
        is_authentic: bool
    }
    
    // Register a new authentic product
    public entry fun register_product(
        account: &signer, 
        product_id: String
    ) {
        let signer_address = signer::address_of(account);
        
        // Check if product already exists
        assert!(!exists<Product>(signer_address), E_PRODUCT_ALREADY_EXISTS);
        
        // Create new product record
        let product = Product {
            id: product_id,
            manufacturer: signer_address,
            timestamp: timestamp::now_seconds(),
            is_authentic: true
        };
        
        // Store the product resource
        move_to(account, product);
    }
    
    // Verify if a product is authentic
    public fun verify_product(
        product_address: address
    ): bool acquires Product {
        // Ensure product exists
        assert!(exists<Product>(product_address), E_PRODUCT_NOT_FOUND);
        
        // Get product data and return authenticity status
        let product = borrow_global<Product>(product_address);
        product.is_authentic
    }
    
    // Test function to verify contract works correctly
    #[test(manufacturer = @0x123, timestamp = @aptos_framework)]
    public entry fun test_product_verification(
        manufacturer: signer,
        timestamp: signer
    ) acquires Product {
        // Setup test environment
        timestamp::set_time_has_started_for_testing(&timestamp);
        let manufacturer_addr = signer::address_of(&manufacturer);
        account::create_account_for_test(manufacturer_addr);
        
        // Register a new product
        register_product(&manufacturer, string::utf8(b"PROD12345"));
        
        // Verify the product is authentic
        assert!(verify_product(manufacturer_addr), 0);
    }
}