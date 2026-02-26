#:package Microsoft.CodeAnalysis.CSharp@4.8.0

using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.CSharp.Syntax;

class CW1TestHelper
{
  static void Main(string[] args)
  {
    if (args.Length != 3)
    {
      Console.WriteLine("Usage: CW1TestHelper <path-to-cs-file> <line-number> <runType>");
      return;
    }

    var filePath = Path.GetFullPath(args[0]);
    var lineNumber = int.Parse(args[1]);
    var runType = args[2];

    // Validate runType argument
    if (runType != "dotnettest" && runType != "vstest")
    {
      throw new ArgumentException($"Invalid runType value: '{runType}'. Must be 'dotnettest' or 'vstest'.");
    }

    if (runType == "dotnettest")
    {
      RunDotnetTest(filePath, lineNumber);
    }
    else
    {
      RunVstest(filePath, lineNumber);
    }
  }

  static void RunDotnetTest(string filePath, int lineNumber)
  {
    // Find project file
    var projectFile = FindProjectFile(filePath, "csproj");
    if (string.IsNullOrEmpty(projectFile))
    {
      throw new Exception("No .csproj file found in parent directories.");
    }

    // Find method
    var methodName = FindMethod(filePath, lineNumber, "FullyQualifiedName");
    if (string.IsNullOrEmpty(methodName))
    {
      Console.WriteLine("No method found at the specified line.");
      return;
    }

    Console.WriteLine("Running unit test using dotnet test...");
    Console.WriteLine($"Project: {projectFile}");
    Console.WriteLine($"Method: {methodName}");
    Console.WriteLine("");

    // Run dotnet test
    var filter = $"FullyQualifiedName~{methodName}&CapabilityRequirements~NET48";
    var processInfo = new ProcessStartInfo
    {
      FileName = "dotnet",
      Arguments = $"test --no-build \"{projectFile}\" --filter \"{filter}\"",
      WorkingDirectory = "C:\\git\\GitHub\\WiseTechGlobal\\CargoWise",
      UseShellExecute = false
    };

    var fullCommand = $"{processInfo.FileName} {processInfo.Arguments}";
    CopyToClipboard(fullCommand);
    Console.WriteLine($"Command copied to clipboard: {fullCommand}");
    Console.WriteLine("");

    using (var process = Process.Start(processInfo))
    {
      process.WaitForExit();
    }
  }

  static void RunVstest(string filePath, int lineNumber)
  {
    // Find project file (DLL)
    var dllFileName = FindProjectFile(filePath, "dll");
    if (string.IsNullOrEmpty(dllFileName))
    {
      throw new Exception("No .csproj file found in parent directories.");
    }

    // Find method (name only)
    var methodName = FindMethod(filePath, lineNumber, "NameOnly");
    if (string.IsNullOrEmpty(methodName))
    {
      // If no method found, try to use the class name instead
      methodName = FindClassName(filePath, lineNumber);
      if (string.IsNullOrEmpty(methodName))
      {
        Console.WriteLine("No method or class found at the specified line.");
        return;
      }
    }

    Console.WriteLine("Running unit test using vstest.console.exe...");
    Console.WriteLine($"DLL: {dllFileName}");
    Console.WriteLine($"Method: {methodName}");
    Console.WriteLine("");

    // Run vstest
    var processInfo = new ProcessStartInfo
    {
      FileName = "C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\Common7\\IDE\\CommonExtensions\\Microsoft\\TestWindow\\vstest.console.exe",
      Arguments = $"\"{dllFileName}\" /Tests:{methodName}",
      WorkingDirectory = "C:\\git\\GitHub\\WiseTechGlobal\\CargoWise\\Bin",
      UseShellExecute = false
    };

    var fullCommand = $"& '{processInfo.FileName}' {processInfo.Arguments}";
    CopyToClipboard(fullCommand);
    Console.WriteLine($"Command copied to clipboard: {fullCommand}");
    Console.WriteLine("");

    using (var process = Process.Start(processInfo))
    {
      process.WaitForExit();
    }
  }

  static void CopyToClipboard(string text)
  {
    var process = new Process
    {
      StartInfo = new ProcessStartInfo
      {
        FileName = "clip",
        RedirectStandardInput = true,
        UseShellExecute = false
      }
    };
    process.Start();
    process.StandardInput.Write(text);
    process.StandardInput.Close();
    process.WaitForExit();
  }

  static string FindProjectFile(string filePath, string returnType)
  {
    // Validate ReturnType argument
    if (returnType != "csproj" && returnType != "dll")
    {
      throw new ArgumentException($"Invalid ReturnType value: '{returnType}'. Must be 'csproj' or 'dll'.");
    }

    var dir = Path.GetDirectoryName(filePath);
    string projectFile = "";

    while (dir != null)
    {
      var files = Directory.GetFiles(dir, "*.csproj");
      if (files.Length > 0)
      {
        projectFile = files[0];
        break;
      }
      dir = Directory.GetParent(dir)?.FullName;
    }

    if (string.IsNullOrEmpty(projectFile))
    {
      return null;
    }

    if (returnType == "csproj")
    {
      return projectFile;
    }

    // For ReturnType == "dll", extract the output DLL name from the project file
    var xmlDoc = XDocument.Load(projectFile);
    var assemblyName = xmlDoc.Descendants("AssemblyName").FirstOrDefault()?.Value;

    string dllFileName;
    if (!string.IsNullOrEmpty(assemblyName))
    {
      dllFileName = assemblyName + ".dll";
    }
    else
    {
      dllFileName = Path.ChangeExtension(Path.GetFileName(projectFile), ".dll");
    }

    return dllFileName;
  }

  static string FindMethod(string filePath, int lineNumber, string returnType)
  {
    // Validate ReturnType argument
    if (returnType != "FullyQualifiedName" && returnType != "NameOnly")
    {
      throw new ArgumentException($"Invalid ReturnType value: '{returnType}'. Must be 'FullyQualifiedName' or 'NameOnly'.");
    }

    var code = File.ReadAllText(filePath);
    var tree = CSharpSyntaxTree.ParseText(code);
    var root = tree.GetRoot();
    var text = tree.GetText();

    // Find the method declaration containing the line
    var method = root.DescendantNodes()
        .OfType<MethodDeclarationSyntax>()
        .FirstOrDefault(m =>
        {
          var span = m.Span;
          var startLine = text.Lines.GetLineFromPosition(span.Start).LineNumber + 1;
          var endLine = text.Lines.GetLineFromPosition(span.End).LineNumber + 1;
          return lineNumber >= startLine && lineNumber <= endLine;
        });

    if (method == null)
    {
      return null;
    }

    var methodName = method.Identifier.Text;

    // Return based on ReturnType argument
    if (returnType == "NameOnly")
    {
      return methodName;
    }

    // Get class and namespace for FullyQualifiedName
    var classNode = method.Ancestors().OfType<ClassDeclarationSyntax>().FirstOrDefault();
    var namespaceNode = method.Ancestors().OfType<NamespaceDeclarationSyntax>().FirstOrDefault();
    var fileScopedNamespaceNode = method.Ancestors().OfType<FileScopedNamespaceDeclarationSyntax>().FirstOrDefault();

    var className = classNode?.Identifier.Text ?? "<no-class>";
    var namespaceName = namespaceNode?.Name.ToString() ?? (fileScopedNamespaceNode?.Name.ToString() ?? "<no-namespace>");

    return $"{namespaceName}.{className}.{methodName}";
  }

  static string FindClassName(string filePath, int lineNumber)
  {
    var code = File.ReadAllText(filePath);
    var tree = CSharpSyntaxTree.ParseText(code);
    var root = tree.GetRoot();
    var text = tree.GetText();

    // Find the class declaration containing the line
    var classNode = root.DescendantNodes()
        .OfType<ClassDeclarationSyntax>()
        .FirstOrDefault(c =>
        {
          var span = c.Span;
          var startLine = text.Lines.GetLineFromPosition(span.Start).LineNumber + 1;
          var endLine = text.Lines.GetLineFromPosition(span.End).LineNumber + 1;
          return lineNumber >= startLine && lineNumber <= endLine;
        });

    return classNode?.Identifier.Text;
  }
}
