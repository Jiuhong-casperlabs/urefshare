prepare:
	rustup target add wasm32-unknown-unknown

build-contract:
	cargo build --release -p uref_share --target wasm32-unknown-unknown

test-only:
	cargo test -p tests

lint:
	cargo fmt
	cargo clippy --all-targets --all -- -D warnings -A renamed_and_removed_lints

clean:
	cargo clean
	# rm ./tests/wasm/*
	rm -rf ./tests/wasm

copy-wasm-file-to-test:
	mkdir -p tests/wasm
	cp target/wasm32-unknown-unknown/release/uref-share.wasm tests/wasm
	cp target/wasm32-unknown-unknown/release/locked.wasm tests/wasm
	cp target/wasm32-unknown-unknown/release/locked_with_share.wasm tests/wasm

test: build-contract copy-wasm-file-to-test test-only
