There are 2 Powershell scripts to run CW1 Test, one uses `dotnet test` and the other one uses `vstest.console.exe`

This requires .net 10 to be installed on your machine even you don't develop anything on .net 10

To use them, create a new Jetbrains external tool with configuration like this

- Program: `powershell`
- Argument: `-File "c:\path\to\CW1Test-dotnet-test.ps1" -FilePath "$FilePath$" -LineNumber $LineNumber$`
- Update the path to the dotnet-test or vstest script that you want to use
- In Rider editor, place the cursor in any test method and trigger that external tool

Problems

- The vstest script doesn't exit automatically after finishing -> assign a key to stop the process in Rider
