# Basic

Tab

---

## Help


> `Get-Help <CommandName> -Parameter *`

cmd:
> `<CommandName> /?`

**Example: `Format-Table`**

```
Format-Table [[-Property] <Object[]>] [-AutoSize] [-HideTableHeaders] [-Wrap] [-GroupBy <Object>] [-View <string>]
[-ShowError] [-DisplayError] [-Force] [-Expand {CoreOnly | EnumOnly | Both}] [-InputObject <psobject>]
[<CommonParameters>]
```

### What the brackets and symbols mean:

* **Square brackets `[ ]`** indicate an *optional* parameter or argument.
* **Angle brackets `< >`** enclose the *type* or *value* expected.
* **Ellipsis `...` or `[]`** indicates that the parameter can accept multiple values (an array).
* **Curly braces `{ }`** enclose a set of possible choices (enum).



| Field                      | Meaning                                                                                                                                                                                   |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Required?**              | `false` — This parameter is *optional*. You don’t have to specify it for the command to work.                                                                                             |
| **Position?**              | `0` — If you provide an argument without specifying `-Property`, PowerShell treats it as this parameter because it is in position 0 (first). So it’s a *positional* parameter at index 0. |
| **Accept pipeline input?** | `false` — This parameter **does NOT** accept input from the pipeline. You can’t pipe objects directly into `-Property`.                                                                   |
| **Parameter set name**     | `(All)` — This parameter is available in all parameter sets of the cmdlet. Parameter sets let the cmdlet behave differently based on which parameters are used.                           |
| **Aliases**                | `None` — This parameter has no alternate names.                                                                                                                                           |
| **Dynamic?**               | `false` — This parameter is not dynamically generated or changed at runtime.                                                                                                              |

---

## cmdlets & function

| **Feature**        | **Cmdlet**                                | **Function**                           |
| ------------------ | ----------------------------------------- | -------------------------------------- |
| **Definition**     | A built-in, compiled .NET class           | A user-defined script or block of code |
| **Performance**    | Faster (compiled)                         | Slower (interpreted)                   |
| **Built-In**       | Part of PowerShell runtime                | Created by the user or script author   |
| **Extensibility**  | Limited to predefined functionality       | Highly customizable                    |
| **Error Handling** | Integrated with PowerShell's error system | Can be customized with try/catch       |
| **Structure**      | Must follow `Verb-Noun` format            | No strict naming convention            |


---


ft, fl
cf


## Symbol `$_`

==`$_` is a special automatic variable in PowerShell that represents the current object in the pipeline during a loop or script block.==

## Symbol `${}`

`${}` is variable interpolation inside the string.

## Symbol `$()`

`$()` This is used for subexpression evaluation. It's a way to evaluate any expression or command within the parentheses and then return the result. You would use $() when you need to evaluate an expression or command that is not just a single variable but a more complex operation (like method calls, object properties, etc.).

## Pipe '|' Operation

PowerShell automatically iterates over each item in the list and passes it one-by-one into the next command in the pipeline.

>$items | Some-Command

It works like:

>foreach ($item in $items) {
    Some-Command $item
}

# Create a custom object with properties
$person = New-Object PSObject -property @{
    Name = 'John Doe'
    Age = 30
    Occupation = 'Software Engineer'
}

Write-Host $person.Name
Write-Host $person.Age

---

# PowerShell：列出可疑使用 Base64 的命令（Windows 事件或 PowerShell 轉儲）

> Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-PowerShell/Operational'; StartTime=(Get-Date).AddDays(-7)} |
Where-Object { $_.Message -match 'EncodedCommand' } |
Select TimeCreated, Message

# Windows — 列出 service 中未簽名驅動：

> Get-WmiObject Win32_SystemDriver | Where-Object { -not (Get-AuthenticodeSignature $_.PathName).Status -eq 'Valid' } | Select Name, PathName