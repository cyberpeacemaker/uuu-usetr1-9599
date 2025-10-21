# Basic

https://netwrix.com/en/resources/blog/powershell-commands-cheat-sheet/
Tab

---

## Get & Help

> `Get-Command <*PartofCommandName*>`

> `Get-Help <CommandName> -Parameter *`

cmd:
> `<CommandName> /?`

> `Get-Service | Where-Object { $_.DisplayName -like "*Remote*" }`

> `Get-Member`
    
---

## What the brackets and symbols mean:

* **Square brackets `[ ]`** indicate an *optional* parameter or argument.
* **Angle brackets `< >`** enclose the *type* or *value* expected.
* **Ellipsis `...` or `[]`** indicates that the parameter can accept multiple values (an array).
* **Curly braces `{ }`** enclose a set of possible choices (enum).


---

## Command Type

| **CommandType**    | **Description**                                                                                                     | **Example**                      | **Usage**                                                    |
| ------------------ | ------------------------------------------------------------------------------------------------------------------- | -------------------------------- | ------------------------------------------------------------ |
| **Alias**          | Shortcuts or alternate names for commands.                                                                          | `ls` (alias for `Get-ChildItem`) | To create shorthand for longer cmdlet names.                 |
| **Function**       | User-defined or predefined reusable code blocks.                                                                    | `Get-Help`                       | Used for modular code in scripts or the interactive session. |
| **Cmdlet**         | Native PowerShell commands, typically compiled .NET classes.                                                        | `Get-Process`                    | Core commands in PowerShell for various tasks.               |
| **Workflow**       | Commands designed for long-running, parallel, and remote tasks.                                                     | `Get-Job`                        | Used for parallel tasks, remote execution, and resiliency.   |
| **Script**         | PowerShell script files (typically `.ps1`) containing a series of commands.                                         | `myScript.ps1`                   | Scripts that can be executed to automate tasks.              |
| **Application**    | Executable programs (e.g., `.exe`) that can be run from PowerShell.                                                 | `notepad.exe`, `calc.exe`        | External programs executed from within PowerShell.           |
| **ExternalScript** | Scripts written in external languages (e.g., Python, Batch).                                                        | `myScript.py` (Python)           | Executes scripts written in non-PowerShell languages.        |
| **CmdletBinding**  | Attribute for functions to allow them to behave like cmdlets, providing additional features like common parameters. | N/A                              | Used in functions but not a command type itself.             |


* **Examples:**

  ```powershell
  Function Get-Something {
      Write-Host "Doing something!"
  }
  ```

  ```powershell
  Function My-Function {
      Param($Name)
      Write-Host "Hello, $Name"
  }
  ```

---

# Frequent Used

ft, fl
cf

## Select & Where
`Select-Object`
`Where-Object { $_.Source -match 'NetTCPIP' }`

**example**
> `(Get-NetIPInterface)[3].InterfaceAlias`
> `(Get-NetIPInterface | Where-Object { $_.InterfaceAlias -eq 'YourAlias' })[3].InterfaceAlias
`

## Symbol `$_`

==`$_` is a special automatic variable in PowerShell that represents the current object in the pipeline during a loop or script block.==

## Symbol `${}`

`${}` is variable interpolation inside the string.

## Symbol `$()`

`$()` This is used for subexpression evaluation. It's a way to evaluate any expression or command within the parentheses and then return the result. You would use $() when you need to evaluate an expression or command that is not just a single variable but a more complex operation (like method calls, object properties, etc.).

## Pipe `|` Operation

PowerShell automatically iterates over each item in the list and passes it one-by-one into the next command in the pipeline.

>$items | Some-Command

It works like:

>foreach ($item in $items) {
    Some-Command $item
}

# Create a custom object with properties

```
$person = New-Object PSObject -property @{
    Name = 'John Doe'
    Age = 30
    Occupation = 'Software Engineer'
}

Write-Host $person.Name
Write-Host $person.Age
```