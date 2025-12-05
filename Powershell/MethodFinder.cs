#:package Microsoft.CodeAnalysis.CSharp@4.8.0

using System;
using System.IO;
using System.Linq;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.CSharp.Syntax;

class Program
{
  static void Main(string[] args)
  {
    if (args.Length != 2)
    {
      Console.WriteLine("Usage: MethodFinder <path-to-cs-file> <line-number>");
      return;
    }

    var filePath = args[0];
    var lineNumber = int.Parse(args[1]);
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
      Console.WriteLine("No method found at the specified line.");
      return;
    }

    // Get class and namespace
    var classNode = method.Ancestors().OfType<ClassDeclarationSyntax>().FirstOrDefault();
    var namespaceNode = method.Ancestors().OfType<NamespaceDeclarationSyntax>().FirstOrDefault();
    var fileScopedNamespaceNode = method.Ancestors().OfType<FileScopedNamespaceDeclarationSyntax>().FirstOrDefault();

    var className = classNode?.Identifier.Text ?? "<no-class>";
    var namespaceName = namespaceNode?.Name.ToString() ?? (fileScopedNamespaceNode?.Name.ToString() ?? "<no-namespace>");
    var methodName = method.Identifier.Text;

    Console.WriteLine($"{namespaceName}.{className}.{methodName}");
  }
}
