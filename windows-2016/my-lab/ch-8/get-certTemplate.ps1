# Scenario A: On CA
$targetQueryName = "web"
#Get-CATemplate | Where-Object Name -like "*${targetQueryName}*"

# Scenario B: On Client Machine
# TODO: Name Display fix
$templates = certutil -template
$parsedTemplates = @()
for ($i = 0; $i -lt $templates.Count; $i++) {
    if ($templates[$i] -match "TemplatePropCommonName\s+(.*)") {
        $templateName = $matches[1]
        $displayName = ""

        # Look ahead for Display Name
        for ($j = $i+1; $j -lt $templates.Count; $j++) {
            if ($templates[$j] -match "TemplatePropFriendlyName\s+(.*)") {
                $displayName = $matches[1]
                break
            }
        }

        $parsedTemplates += [PSCustomObject]@{
            TemplateName = $templateName
            DisplayName  = $displayName
        }
    }
}

# Now you can query like:
$parsedTemplates | Where-Object TemplateName -like "*${targetQueryName}*"
