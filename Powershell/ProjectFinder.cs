using System;
using System.IO;

class ProjectFinder
{
  static void Main(string[] args)
  {
    if (args.Length != 1)
    {
      Console.WriteLine("Usage: ProjectFinder <path-to-cs-file>");
      return;
    }

    var filePath = Path.GetFullPath(args[0]);
    var dir = Path.GetDirectoryName(filePath);
    string projectFile = null;

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

    if (projectFile != null)
    {
      Console.WriteLine(projectFile);
    }
    else
    {
      throw new Exception("No .csproj file found in parent directories.");
    }
  }
}
