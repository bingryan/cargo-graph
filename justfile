@update-contributors:
	echo 'Removing old CONTRIBUTORS.md'
	mv CONTRIBUTORS.md CONTRIBUTORS.md.bak
	echo 'Downloading a list of new contributors'
	echo "the following is a list of contributors:" > CONTRIBUTORS.md
	echo "" >> CONTRIBUTORS.md
	echo "" >> CONTRIBUTORS.md
	githubcontrib --owner kbknapp --repo cargo-graph --sha master --cols 6 --format md --showlogin true --sortBy contributions --sortOrder desc >> CONTRIBUTORS.md
	echo "" >> CONTRIBUTORS.md
	echo "" >> CONTRIBUTORS.md
	echo "This list was generated by [mgechev/github-contributors-list](https://github.com/mgechev/github-contributors-list)" >> CONTRIBUTORS.md
	rm CONTRIBUTORS.md.bak

run-test TEST:
	cargo test --test {{TEST}}

debug TEST:
	cargo test --test {{TEST}} --features debug

run-tests:
	cargo test --features "yaml unstable"

install:
	cargo install --force --path .

nightly:
	rustup override add nightly

rm-nightly:
	rustup override remove

@lint: nightly
	cargo build --features lints && just rm-nightly

clean:
	cargo clean
	find . -type f -name "*.orig" -exec rm {} \;
	find . -type f -name "*.bk" -exec rm {} \;
	find . -type f -name ".*~" -exec rm {} \;
