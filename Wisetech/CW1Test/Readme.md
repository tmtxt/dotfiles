C# script to run CW1 test using `dotnet test` and `vstest.console.exe`

This requires .net 10 to be installed on your machine even you don't develop anything on .net 10

To use them, create a new Jetbrains external tool with configuration like this

- Program: `dotnet`
- Argument
  - `run .\CW1TestRunner.cs "$FilePath$" $LineNumber$ dotnettest` for dotnet test
  - `run .\CW1TestRunner.cs "$FilePath$" $LineNumber$ vstest` for vstest
- Working directory: set this to the path of the directory containing this script
- In Rider editor, place the cursor in any test method and trigger that external tool

Problems

- If you just updated with the latest build, you need to open CW1 first for it to perform a database upgrade, otherwise, the test will simply hang
- The vstest script doesn't exit automatically after finishing -> assign a key to stop the process in Rider
- The vstest script doesn't filter by fully qualified name. If there are multiple test cases having the same name, it will run all of them. Try using the dotnet-test version if possible
- The Rider output window doesn't support color. Fuck!
