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
    if (args.Length != 2)
    {
      Console.WriteLine("Usage: CW1TestHelper <path-to-cs-file> <line-number>");
      return;
    }

    var filePath = Path.GetFullPath(args[0]);
    var lineNumber = int.Parse(args[1]);

    // Find project file
    var projectFile = FindProjectFile(filePath);
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
      Arguments = $"test \"{projectFile}\" --filter \"{filter}\"",
      WorkingDirectory = "C:\\git\\GitHub\\WiseTechGlobal\\CargoWise",
      UseShellExecute = false
    };

    using (var process = Process.Start(processInfo))
    {
      process.WaitForExit();
    }
  }

  static string FindProjectFile(string filePath)
  {
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

    return projectFile;
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
}
