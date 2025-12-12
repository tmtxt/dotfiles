using System;
using System.IO;
using System.Xml.Linq;

class ProjectFinder
{
  static void Main(string[] args)
  {
    if (args.Length != 2)
    {
      Console.WriteLine("Usage: ProjectFinder <path-to-cs-file> <ReturnType>");
      return;
    }

    var filePath = Path.GetFullPath(args[0]);
    var returnType = args[1];

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
      throw new Exception("No .csproj file found in parent directories.");
    }

    if (returnType == "csproj")
    {
      Console.WriteLine(projectFile);
      return;
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

    Console.WriteLine(dllFileName);
  }
}
