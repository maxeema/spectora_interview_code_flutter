# Solved the "Spectora Mobile Flutter Technical Interview" assessment

This <b>solved</b> branch contains results of solving
 original challenges located at the <b>original</b> branch.

If you are interested in the original assessment source code
 and its requirements, switch to the <b>original</b> branch.

 > git checkout original

Then follow instructions to complete each challenge.
Find README.md in each challenge dir:

- lib/challenge1/README.md

- lib/challenge2/README.md

- lib/challenge3/README.md

### Run challenge1
To run the solution of the <b>challenge1</b> execute next command

> flutter run lib/challenge1/main.dart

### Run challenge2
Assuming that "challenge2" is about writing tests to the "challenge1" sources,
its solution is located at "test/challenge1".

To run the solution of the <b>challenge2</b> execute next command

> flutter test test/challenge1

### Run challenge3
To run the solution of the <b>challenge3</b> execute next command

> flutter run lib/challenge3/main.dart

## Test
To run all tests execute next command

> flutter test
 
## Run on MAC (as a native app)
You can run and debug the project on your Mac as a native app
without need of Simulator or Emulator.

> flutter run lib/challenge1/main.dart -d macos

> flutter run lib/challenge3/main.dart -d macos

## Run in Chrome (as a web app)
You can run and debug the project in the Chrome browser.

> flutter run lib/challenge1/main.dart -d chrome

> flutter run lib/challenge3/main.dart -d chrome

## Run on Linux (as a native app)
You can run and debug the project on your Linux machine as a native app
without need of Simulator or Emulator.

> flutter run lib/challenge1/main.dart -d linux

> flutter run lib/challenge3/main.dart -d linux

# ## Run on other platforms (Android, iOS)
If you want to test the app on Emulator, Simulator, or a real device,
firstly add a target platform support to the project like that.

> flutter create . --platform android

Then start an Emulator or connect a real device.
And run the app.
> flutter run

If you will face a prompt with different devices to run on,
then simply choose your Emulator or Android device.

# ## Run in release mode
You always can see how the code works in release(production) mode
that executes faster and much performant (but takes bit more seconds to be compiled),
just add the "--release" argument like that.

> flutter run --release
> 
> flutter run lib/challenge1/main.dart -d chrome --release


 © Max Shemetov, 2023
