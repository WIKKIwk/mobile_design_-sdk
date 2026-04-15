.PHONY: run get clean setup

setup:
	@echo "Generating Linux platform files..."
	cd example && flutter create --platforms=linux .

run: setup
	@echo "Starting Flutter preview..."
	cd example && flutter run -d linux

get:
	@echo "Getting dependencies..."
	flutter pub get
	cd example && flutter pub get

clean:
	@echo "Cleaning projects..."
	flutter clean
	cd example && flutter clean
