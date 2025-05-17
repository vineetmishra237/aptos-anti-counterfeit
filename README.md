# Aptos Anti-Counterfeit

This project is a Move-based smart contract designed to combat counterfeiting by enabling manufacturers to register and verify the authenticity of their products on the Aptos blockchain.

## Features

- **Register Products**: Manufacturers can register their products as authentic.
- **Verify Authenticity**: Anyone can verify if a product is authentic using its unique identifier.
- **Test Suite**: Includes a test function to ensure the contract works as expected.

## Smart Contract Details

### Modules

- **HelloMessage::validator**: Contains the main logic for registering and verifying products.

### Key Functions

1. `register_product(account: &signer, product_id: String)`
   - Registers a new product as authentic.
   - Ensures that the product does not already exist.

2. `verify_product(product_address: address): bool`
   - Verifies if a product is authentic.
   - Returns `true` if the product is authentic, otherwise throws an error.

3. `test_product_verification(manufacturer: signer, timestamp: signer)`
   - A test function to validate the contract's functionality.

### Error Codes

- `E_PRODUCT_ALREADY_EXISTS (1)`: Thrown when attempting to register a product that already exists.
- `E_PRODUCT_NOT_FOUND (2)`: Thrown when attempting to verify a product that does not exist.
- `E_NOT_AUTHORIZED (3)`: Reserved for future use.

## Project Structure

- `Move.toml`: Configuration file for the Move project.
- `sources/`: Contains the Move source code.
- `tests/`: Contains test cases for the smart contract.
- `build/`: Contains compiled bytecode and related artifacts.

## How to Use

1. **Setup**:
   - Install the Aptos CLI.
   - Clone this repository.

2. **Compile**:
   ```bash
   aptos move compile
   ```

3. **Run Tests**:
   ```bash
   aptos move test
   ```

4. **Deploy**:
   ```bash
   aptos move publish --assume-yes
   ```

5. **Interact**:
   Use the Aptos CLI or a custom frontend to interact with the contract.

## License

This project is licensed under the MIT License.